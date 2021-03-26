//===- KernelGeneration.cpp - Implementation of SODA kernel generation ----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA dialect kernel genration pass.
//
// It pull the kernel code into a completely isolated, clean of soda operations
// mlir file that can be further optimized by regular mlir-opt and subsequently
// lowered into llvm ir.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/MemRef/IR/MemRef.h"
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

namespace {

class SodaKernelGenerationPass
    : public SodaKernelGenerationBase<SodaKernelGenerationPass> {
public:
  void runOnOperation() override {
    // TODO(nico): Finish implementation
  }
};

} // namespace

std::unique_ptr<OperationPass<ModuleOp>>
mlir::soda::createSodaKernelGenerationPass() {
  return std::make_unique<SodaKernelGenerationPass>();
}