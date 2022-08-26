//===- KernelOutlining.cpp - Implementation of SODA kernel outlining ------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA dialect kernel outlining pass.
//
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/Arithmetic/IR/Arithmetic.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Transforms/RegionUtils.h"

#include "PassDetail.h"
#include "soda/Dialect/SODA/Passes.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Dialect/SODA/Utils.h"

using namespace mlir;

/// Identifies operations that are beneficial to sink into kernels. These
/// operations may not have side-effects, as otherwise sinking (and hence
/// duplicating them) is not legal.
static bool isSinkingBeneficiary(Operation *op) {
  return isa<arith::ConstantOp, func::ConstantOp, memref::DimOp,
             arith::SelectOp, arith::CmpIOp>(op);
}

/// For a given operation `op`, computes whether it is beneficial to sink the
/// operation into the kernel. An operation can be sunk if doing so does not
/// introduce new kernel arguments. Whether a value is already available in the
/// kernel (and hence does not introduce new arguments) is checked by
/// querying `existingDependencies` and `availableValues`.
/// If an operand is not yet available, we recursively check whether it can be
/// made available by siking its defining op.
/// Operations that are indentified for sinking are added to `beneficiaryOps` in
/// the order they should appear in the kernel. Furthermore, `availableValues`
/// is updated with results that will be available after sinking the identified
/// ops.
static bool
extractBeneficiaryOps(Operation *op,
                      llvm::SetVector<Value> existingDependencies,
                      llvm::SetVector<Operation *> &beneficiaryOps,
                      llvm::SmallPtrSetImpl<Value> &availableValues) {
  if (beneficiaryOps.count(op))
    return true;

  if (!isSinkingBeneficiary(op))
    return false;

  for (Value operand : op->getOperands()) {
    // It is already visible in the kernel, keep going.
    if (availableValues.count(operand))
      continue;
    // Else check whether it can be made available via sinking or already is a
    // dependency.
    Operation *definingOp = operand.getDefiningOp();
    if ((!definingOp ||
         !extractBeneficiaryOps(definingOp, existingDependencies,
                                beneficiaryOps, availableValues)) &&
        !existingDependencies.count(operand))
      return false;
  }
  // We will sink the operation, mark its results as now available.
  beneficiaryOps.insert(op);
  for (Value result : op->getResults())
    availableValues.insert(result);
  return true;
}

LogicalResult mlir::sinkOperationsIntoLaunchOp(soda::LaunchOp launchOp) {
  Region &launchOpBody = launchOp.body();

  // Identify uses from values defined outside of the scope of the launch
  // operation.
  llvm::SetVector<Value> sinkCandidates;
  getUsedValuesDefinedAbove(launchOpBody, sinkCandidates);

  llvm::SetVector<Operation *> toBeSunk;
  llvm::SmallPtrSet<Value, 4> availableValues;
  for (Value operand : sinkCandidates) {
    Operation *operandOp = operand.getDefiningOp();
    if (!operandOp)
      continue;
    extractBeneficiaryOps(operandOp, sinkCandidates, toBeSunk, availableValues);
  }

  // Insert operations so that the defs get cloned before uses.
  BlockAndValueMapping map;
  OpBuilder builder(launchOpBody);
  for (Operation *op : toBeSunk) {
    Operation *clonedOp = builder.clone(*op, map);
    // Only replace uses within the launch op.
    for (auto pair : llvm::zip(op->getResults(), clonedOp->getResults()))
      replaceAllUsesInRegionWith(std::get<0>(pair), std::get<1>(pair),
                                 launchOp.body());
  }
  return success();
}

/// Outline the `soda.launch` operation body into a kernel function. Replace
/// `soda.terminator` operations by `soda.return` in the generated function.
static soda::SODAFuncOp
outlineKernelFuncImpl(soda::LaunchOp launchOp, StringRef kernelFnName,
                      llvm::SetVector<Value> &operands) {
  Location loc = launchOp.getLoc();
  // Create a builder with no insertion point, insertion will happen separately
  // due to symbol table manipulation
  OpBuilder builder(launchOp.getContext());
  // Contains the region of code that will be outlined
  Region &launchOpBody = launchOp.body();

  // Identify uses from values defined outside of the scope of the launch
  // operation.
  getUsedValuesDefinedAbove(launchOpBody, operands);

  // Create the soda.func operation.
  SmallVector<Type, 4> kernelOperandTypes;
  kernelOperandTypes.reserve(operands.size());
  for (Value operand : operands) {
    kernelOperandTypes.push_back(operand.getType());
  }
  FunctionType type =
      FunctionType::get(launchOp.getContext(), kernelOperandTypes, {});
  auto outlinedFunc = builder.create<soda::SODAFuncOp>(loc, kernelFnName, type);
  outlinedFunc->setAttr(soda::SODADialect::getKernelFuncAttrName(),
                        builder.getUnitAttr());
  BlockAndValueMapping map;

  // Map the arguments corresponding to the launch parameter like blockIdx,
  // threadIdx, etc.
  Region &outlinedFuncBody = outlinedFunc.body();
  // This is a good area to add preamble operations

  // Map arguments from soda.launch region to the argument of the soda.func
  // operation.
  Block &entryBlock = outlinedFuncBody.front();
  for (auto operand : enumerate(operands))
    map.map(operand.value(), entryBlock.getArgument(operand.index()));

  // Clone the region of the soda.launch operation into the soda.func operation.
  // TODO: If cloneInto can be modified such that if a mapping for a block
  // exists, that block will be used to clone operations into (at the end of the
  // block), instead of creating a new block this would be much cleaner.
  launchOpBody.cloneInto(&outlinedFuncBody, map);

  // Branch from entry of the soda.func operation to the block that is cloned
  // from the entry block of the gpu.launch operation
  Block &launchOpEntry = launchOpBody.front();
  Block *clonedLaunchOpEntry = map.lookup(&launchOpEntry);
  builder.setInsertionPointToEnd(&entryBlock);
  builder.create<cf::BranchOp>(loc, clonedLaunchOpEntry);

  outlinedFunc.walk([](soda::TerminatorOp op) {
    OpBuilder replacer(op);
    replacer.create<soda::ReturnOp>(op.getLoc());
    op.erase();
  });
  return outlinedFunc;
}

soda::SODAFuncOp
mlir::outlineKernelFunc(soda::LaunchOp launchOp, StringRef kernelFnName,
                        llvm::SmallVectorImpl<Value> &operands) {
  DenseSet<Value> inputOperandSet;
  inputOperandSet.insert(operands.begin(), operands.end());
  llvm::SetVector<Value> operandSet(operands.begin(), operands.end());
  auto funcOp = outlineKernelFuncImpl(launchOp, kernelFnName, operandSet);
  for (auto operand : operandSet) {
    if (!inputOperandSet.count(operand))
      operands.push_back(operand);
  }
  return funcOp;
}

/// Replace `soda.launch` operations with an `soda.launch_func` operation
/// launching `kernelFunc`. The kernel func contains the body of the
/// `soda.launch` with constant region arguments inlined.
static void convertToLaunchFuncOp(soda::LaunchOp launchOp,
                                  soda::SODAFuncOp kernelFunc,
                                  ValueRange operands) {
  OpBuilder builder(launchOp);
  builder.create<soda::LaunchFuncOp>(launchOp.getLoc(), kernelFunc, operands);
  launchOp.erase();
}

namespace {
/// Pass that moves the kernel of each LaunchOp into its separate nested module.
///
/// This pass moves the kernel code of each LaunchOp into a function created
/// inside a nested module. It also creates an external function of the same
/// name in the parent module.
///
/// The soda.modules are intended to be compiled to different targets
/// independently in a separate pass. The external functions can then be
/// annotated with the symbol of the accessor function.
class SodaKernelOutliningPass
    : public SodaKernelOutliningBase<SodaKernelOutliningPass> {
public:
  void runOnOperation() override {
    SymbolTable symbolTable(getOperation());
    bool modified = false;
    for (auto func : getOperation().getOps<func::FuncOp>()) {
      // Insert just after the function.
      Block::iterator insertPt(func.getOperation()->getNextNode());
      auto funcWalkResult = func.walk([&](soda::LaunchOp op) {
        llvm::SetVector<Value> operands;
        std::string kernelFnName =
            Twine(op->getParentOfType<func::FuncOp>().getName(), "_kernel")
                .str();

        // func.emitWarning()<< kernelFnName;
        // auto newName =
        //     (Twine(op.getKernelModuleName(), "_" +
        //     Twine(kernelFnName)).str();

        // // auto func = getOperation().lookupSymbol<func::FuncOp>(newName);
        // if(getOperation().lookupSymbol<func::FuncOp>(newName)){
        //   kernelFnName = kernelFnName+"_kernel";
        // }

        // Pull in instructions that can be sunk
        if (failed(sinkOperationsIntoLaunchOp(op)))
          return WalkResult::interrupt();
        soda::SODAFuncOp outlinedFunc =
            outlineKernelFuncImpl(op, kernelFnName, operands);

        // Create nested module and insert outlinedFunc. The module will
        // originally get the same name as the function, but may be renamed on
        // insertion into the parent module.
        auto kernelModule = createKernelModule(outlinedFunc, symbolTable);
        symbolTable.insert(kernelModule, insertPt);

        convertToLaunchFuncOp(op, outlinedFunc, operands.getArrayRef());
        modified = true;
        return WalkResult::advance();
      });
      if (funcWalkResult.wasInterrupted())
        return signalPassFailure();
    }

    // If any new module was inserted in this module, annotate this module as
    // a container module.
    if (modified)
      getOperation()->setAttr(soda::SODADialect::getContainerModuleAttrName(),
                              UnitAttr::get(&getContext()));
  }

private:
  /// Returns a soda.module containing kernelFunc and all callees (recursive).
  soda::SODAModuleOp createKernelModule(soda::SODAFuncOp kernelFunc,
                                        const SymbolTable &parentSymbolTable) {
    // TODO: This code cannot use an OpBuilder because it must be inserted into
    // a SymbolTable by the caller. SymbolTable needs to be refactored to
    // prevent manual building of Ops with symbols in code using SymbolTables
    // and then this needs to use the OpBuilder.

    // Prevent module and kernel name combination aliasing to an existing
    // function name in the symbol table
    std::string newModuleName = kernelFunc.getName().str();
    std::string possibleConflict =
        (Twine(newModuleName) + "_" + Twine(kernelFunc.getName())).str();
    while (parentSymbolTable.lookup<func::FuncOp>(possibleConflict)) {
      newModuleName = newModuleName + "_m";
      possibleConflict =
          (Twine(newModuleName) + "_" + Twine(kernelFunc.getName())).str();
    }

    auto context = getOperation().getContext();
    OpBuilder builder(context);
    auto kernelModule =
        builder.create<soda::SODAModuleOp>(kernelFunc.getLoc(), newModuleName);
    SymbolTable symbolTable(kernelModule);
    symbolTable.insert(kernelFunc);

    SmallVector<Operation *, 8> symbolDefWorklist = {kernelFunc};
    while (!symbolDefWorklist.empty()) {
      if (Optional<SymbolTable::UseRange> symbolUses =
              SymbolTable::getSymbolUses(symbolDefWorklist.pop_back_val())) {
        for (SymbolTable::SymbolUse symbolUse : *symbolUses) {
          StringRef symbolName =
              symbolUse.getSymbolRef().cast<FlatSymbolRefAttr>().getValue();
          if (symbolTable.lookup(symbolName))
            continue;

          Operation *symbolDefClone =
              parentSymbolTable.lookup(symbolName)->clone();
          symbolDefWorklist.push_back(symbolDefClone);
          symbolTable.insert(symbolDefClone);
        }
      }
    }

    return kernelModule;
  }
};

} // namespace

std::unique_ptr<OperationPass<ModuleOp>>
mlir::soda::createSodaKernelOutliningPass() {
  return std::make_unique<SodaKernelOutliningPass>();
}