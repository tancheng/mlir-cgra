//===- Print.cpp - Simple print to terminal for `snn` dialect ops ---------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements a print to terminal for `snn` dialect ops
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Support/LLVM.h"

#include "PassDetail.h"
#include "soda/Dialect/SNN/IR/SNN.h"
#include "soda/Dialect/SNN/Transforms/Passes.h"

using namespace mlir;

namespace {
class SNNPrintPass : public SNNPrintBase<SNNPrintPass> {
  void runOnOperation() override {}
};
} // namespace

std::unique_ptr<OperationPass<ModuleOp>> mlir::snn::createSNNPrintPass() {
  return std::make_unique<SNNPrintPass>();
}
