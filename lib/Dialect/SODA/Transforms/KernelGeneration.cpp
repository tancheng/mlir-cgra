//===- KernelGeneration.cpp - Implementation of SODA kernel generation ----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA dialect kernel genration for Bambu pass.
//
// It pulls the kernel code into a completely isolated, clean of soda operations
// mlir file that can be further optimized by regular mlir-opt and subsequently
// lowered into llvm ir.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/FunctionInterfaces.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Transforms/RegionUtils.h"

#include "PassDetail.h"
#include "soda/Dialect/SODA/Passes.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Dialect/SODA/Utils.h"

using namespace mlir;
using namespace mlir::LLVM;

namespace {

class SodaKernelGenerationPass
    : public SodaKernelGenerationBase<SodaKernelGenerationPass> {
public:
  void runOnOperation() override;
};

} // namespace

void SodaKernelGenerationPass::runOnOperation() {

  // Steps:
  // 1 Transfer SODAModuleOp region to its parent mlir::ModuleOp
  // 2 Delete any code unrelated to the kernel
  // 3 Walk through the module and change soda.module terminator
  // 4 Walk through the module and change soda.func to regular func
  // 5 Walk through the module and change soda.return
  // 6 Set attribute marking that we modified this mlir:ModuleOp for Bambu
  // target

  Operation *op = getOperation();

  if (!isa<ModuleOp>(op)) {
    return signalPassFailure();
  }

  ModuleOp mop = dyn_cast<ModuleOp>(op);
  if (!mop) {
    return signalPassFailure();
  }

  // Will be set to true if the current module has a SODAModuleOp
  bool modified = false;
  mop.walk([this, &modified, &mop](soda::SODAModuleOp sodaOp) {
    if (modified) {
      sodaOp.emitError("should only contain one 'soda::SODAModuleOp' op");
      return signalPassFailure();
    }

    BlockAndValueMapping map;
    sodaOp.body().cloneInto(&(mop.getRegion()), map);
    sodaOp.erase();

    modified = true;
  });

  // This module does not have a SODAModuleOp
  if (!modified) {
    return signalPassFailure();
  }

  // We inserted a new block into a ModuleOp, ModuleOp should have only one
  // block, thus delete the old (first) block. This also takes care of deleting
  // the nested SODAModuleOp or other unrelated code.
  Block *oldBlock = &mop->getRegions().front().getBlocks().front();
  oldBlock->erase();

  mop.walk([](soda::ModuleEndOp endOp) { endOp.erase(); });

  mop.walk([this](soda::SODAFuncOp funcOp) {
    OpBuilder replacer(funcOp);

    func::FuncOp dstFunc = replacer.create<func::FuncOp>(
        funcOp.getLoc(), funcOp.getName(), funcOp.getFunctionType());

    dstFunc.getRegion().takeBody(funcOp.body());
    funcOp.erase();

    // Set all memref arguments to noalias
    // TODO (NICO): Create analysis on the outliner, only carry decisions here

    if (!(this->noAliasAnalysis)) {
      int index = 0;
      for (BlockArgument argument : dstFunc.getArguments()) {
        if (argument.getType().isa<MemRefType>()) {
          dstFunc.setArgAttr(index, LLVMDialect::getNoAliasAttrName(),
                             UnitAttr::get(dstFunc.getContext()));
        }
        index++;
      }
    }
  });

  mop.walk([](soda::ReturnOp returnOp) {
    OpBuilder replacer(returnOp);
    replacer.create<mlir::func::ReturnOp>(returnOp.getLoc());
    returnOp.erase();
  });

  if (modified)
    mop->setAttr("soda.bambu.container_module", UnitAttr::get(&getContext()));
}

std::unique_ptr<OperationPass<ModuleOp>>
mlir::soda::createSodaKernelGenerationPass() {
  return std::make_unique<SodaKernelGenerationPass>();
}