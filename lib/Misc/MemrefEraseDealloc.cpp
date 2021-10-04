//===- MemrefEraseMemrefDealloc.cpp - Delete DeallocOp from function-----*-===//
//
// This file implements a pass that deletes memref.dealloc operations.
// This is a necessary preparation for the AffineDataCopyGen pass.
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