//===- ForwardMemrefAlloc.cpp - Forward memref.alloc ops to the top -----*-===//
//
// This file implements a pass that forward any non-nested memory allocation
// operation to the top of the function.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/MemRef/IR/MemRef.h"

#include "mlir/IR/Operation.h"
#include "mlir/Pass/Pass.h"
#include "soda/Misc/Passes.h"

using namespace mlir;
using namespace soda;

#define DEBUG_TYPE "forward-memref-allocations-passes"

namespace {

struct ForwardMemrefAlloc : public ForwardMemrefAllocBase<ForwardMemrefAlloc> {
  void runOnOperation() override;
};

void ForwardMemrefAlloc::runOnOperation() {

  func::FuncOp funcOp = getOperation();

  if (funcOp.isExternal())
    return;

  Operation *firstOp = &funcOp.front().front();

  funcOp.walk([&](memref::AllocOp op) {
    op->moveAfter(firstOp);
    firstOp = op;
  });

  funcOp->walk([&](memref::AllocaOp op) {
    op->moveAfter(firstOp);
    firstOp = op;
  });
}

} // end anonymous namespace

std::unique_ptr<mlir::Pass> mlir::soda::createForwardMemrefAllocPass() {
  return std::make_unique<ForwardMemrefAlloc>();
}
