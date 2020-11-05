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

#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Transforms/RegionUtils.h"

#include "PassDetail.h"
#include "soda/Dialect/SODA/Passes.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Dialect/SODA/Utils.h"

using namespace mlir;

/// Outline the `soda.launch` operation body into a kernel function. Replace
/// `soda.terminator` operations by `soda.return` in the generated function.
static soda::SODAFuncOp
outlineKernelFuncImpl(soda::LaunchOp launchOp, StringRef kernelFnName,
                      llvm::SetVector<Value> &operands) {
  // TODO!
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
  builder.create<soda::LaunchFuncOp>(
      launchOp.getLoc(), kernelFunc, launchOp.getGridSizeOperandValues(),
      launchOp.getBlockSizeOperandValues(), operands);
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
    for (auto func : getOperation().getOps<FuncOp>()) {
      // Insert just after the function.
      Block::iterator insertPt(func.getOperation()->getNextNode());
      auto funcWalkResult = func.walk([&](soda::LaunchOp op) {
        llvm::SetVector<Value> operands;
        std::string kernelFnName =
            Twine(op.getParentOfType<FuncOp>().getName(), "_kernel").str();

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
      getOperation().setAttr(soda::SODADialect::getContainerModuleAttrName(),
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
    auto context = getOperation().getContext();
    OpBuilder builder(context);
    OperationState state(kernelFunc.getLoc(),
                         soda::SODAModuleOp::getOperationName());
    soda::SODAModuleOp::build(builder, state, kernelFunc.getName());
    auto kernelModule = cast<soda::SODAModuleOp>(Operation::create(state));
    // TODO!
    return kernelModule;
  }
};

} // namespace

std::unique_ptr<OperationPass<ModuleOp>> mlir::createSodaKernelOutliningPass() {
  return std::make_unique<SodaKernelOutliningPass>();
}