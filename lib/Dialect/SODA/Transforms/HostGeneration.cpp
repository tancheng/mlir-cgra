//===- HostGeneration.cpp - Implementation of host call generation --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA dialect host genration pass.
//
// It transforms soda.launch_func operations into call to the bambu host api.
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

class SodaHostGenerationPass
    : public SodaHostGenerationBase<SodaHostGenerationPass> {
public:
  void runOnOperation() override {
    // TODO(nico): Finish implementation
  }
};

} // namespace

std::unique_ptr<OperationPass<ModuleOp>>
mlir::soda::createSodaHostGenerationPass() {
  return std::make_unique<SodaHostGenerationPass>();
}