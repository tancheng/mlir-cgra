//===- ForwardLinalgOps.cpp - Forward linalg fill+copy ops to the top ---*-===//
//
// This file implements a pass that forwards any fill+copy ops to the earliest
// position possible.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/Arithmetic/IR/Arithmetic.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/BuiltinOps.h"

#include "mlir/IR/Operation.h"
#include "mlir/Pass/Pass.h"
#include "soda/Misc/Passes.h"

using namespace mlir;
using namespace soda;

#define DEBUG_TYPE "forward-memref-allocations-passes"

namespace {

struct ForwardLinalgFill : public ForwardLinalgFillBase<ForwardLinalgFill> {
  void runOnOperation() override;
};

struct ForwardMemrefCopy : public ForwardMemrefCopyBase<ForwardMemrefCopy> {
  void runOnOperation() override;
};

unsigned getPosition(Operation *op) {
  unsigned position = 0;

  for (Operation &cmp : op->getParentRegion()->front().getOperations()) {
    if (op->getLoc() == cmp.getLoc()) {
      return position;
    }
    position++;
  }
  return 0;
}

Operation *getLastDominator(Operation *op) {

  Operation *last = &op->getParentRegion()->front().front();
  unsigned lastPostion = 0;

  for (Value v : op->getOperands()) {

    if (Operation *producer = v.getDefiningOp()) {
      unsigned currentPosition = getPosition(producer);
      if (currentPosition > lastPostion) {
        last = producer;
        lastPostion = currentPosition;
      }
    } else {
      // If there is no defining op, the Value is necessarily a Block
      // argument.
    }
  }
  return last;
}

void ForwardLinalgFill::runOnOperation() {

  func::FuncOp funcOp = getOperation();

  funcOp->walk(
      [&](arith::ConstantOp op) { op->moveAfter(getLastDominator(op)); });

  funcOp->walk([&](linalg::FillOp op) { op->moveAfter(getLastDominator(op)); });
}

void ForwardMemrefCopy::runOnOperation() {

  func::FuncOp funcOp = getOperation();

  funcOp->walk([&](memref::CopyOp op) { op->moveAfter(getLastDominator(op)); });
}

} // end anonymous namespace

std::unique_ptr<mlir::Pass> mlir::soda::createForwardLinalgFillPass() {
  return std::make_unique<ForwardLinalgFill>();
}

std::unique_ptr<mlir::Pass> mlir::soda::createForwardMemrefCopyPass() {
  return std::make_unique<ForwardMemrefCopy>();
}
