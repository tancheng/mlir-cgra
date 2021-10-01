
//===- MemrefEraseMemrefDealloc.cpp - Delete DeallocOp from function
//---------*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "soda/Misc/Passes.h"

#define DEBUG_TYPE "memref-erase-dealloc-passes"

using namespace mlir;
using namespace soda;

namespace {

struct EraseMemrefDeallocPattern : public RewritePattern {
  EraseMemrefDeallocPattern(MLIRContext *context)
      : RewritePattern(memref::DeallocOp::getOperationName(), 1, context) {}

  LogicalResult matchAndRewrite(Operation *op,
                                PatternRewriter &rewriter) const override {
    rewriter.eraseOp(op);
    return success();
  }
};

struct EraseMemrefDeallocPass
    : public mlir::soda::EraseMemrefDeallocBase<EraseMemrefDeallocPass> {
  void runOnOperation() {
    RewritePatternSet patterns(&getContext());
    populateEraseMemrefDeallocPattern(patterns);
    if (failed(applyPatternsAndFoldGreedily(getOperation()->getRegions(),
                                            std::move(patterns))))
      return signalPassFailure();
  }
};
} // end anonymous namespace

void mlir::soda::populateEraseMemrefDeallocPattern(
    RewritePatternSet &patterns) {
  patterns.add<EraseMemrefDeallocPattern>(patterns.getContext());
}

std::unique_ptr<mlir::Pass> mlir::soda::createEraseMemrefDeallocPass() {
  return std::make_unique<EraseMemrefDeallocPass>();
}