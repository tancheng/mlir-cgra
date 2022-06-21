//===- AsyncRegionRewriter.cpp - Implementation of SODA async rewriters ---===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA dialect pattern rewriters that make SODA op
// within a region execute asynchronously.
//
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#include "PassDetail.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Transforms/RegionUtils.h"

#include "soda/Dialect/SODA/Passes.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Dialect/SODA/Utils.h"

using namespace mlir;
namespace {
class SodaAsyncRegionPass
    : public SodaAsyncRegionPassBase<SodaAsyncRegionPass> {
  struct Callback;
  void runOnOperation() override;
};
} // namespace

// Region walk callback which makes SODA ops implementing the AsyncOpInterface
// execute asynchronously.
struct SodaAsyncRegionPass::Callback {
  // If `op` implements the AsyncOpInterface, insert a `soda.wait async` to
  // create a current token (unless it already exists), and 'thread' that token
  // through the `op` so that it executes asynchronously.
  //
  // If `op` is a terminator or an op with side-effects, insert a `soda.wait` to
  // host-synchronize execution.
  WalkResult operator()(Operation *op) {
    if (isa<soda::LaunchOp>(op))
      return op->emitOpError("replace with soda.launch_func first");
    if (isa<soda::WaitOp>(op))
      return op->emitOpError("unexpected pre-existing soda.wait");
    builder.setInsertionPoint(op);
    if (auto asyncOp = dyn_cast<soda::AsyncOpInterface>(op))
      return rewriteAsyncOp(asyncOp); // Replace SODA op with async version.
    if (!currentToken)
      return success();
    if (!op->hasTrait<OpTrait::IsTerminator>() &&
        MemoryEffectOpInterface::hasNoEffect(op))
      return success();
    // Insert host synchronization before terminator or op with side effects.
    currentToken = createWaitOp(op->getLoc(), Type(), {currentToken});
    return success();
  }

  // Replaces asyncOp with a clone that returns a token.
  LogicalResult rewriteAsyncOp(soda::AsyncOpInterface asyncOp) {
    auto *op = asyncOp.getOperation();
    if (asyncOp.getAsyncToken())
      // TODO: Support ops that are already async.
      return op->emitOpError("is already async");
    if (op->getNumRegions() > 0)
      return op->emitOpError("regions are not supported");

    // If there is no current token, insert a `soda.wait async` without
    // dependencies to create one.
    if (!currentToken)
      currentToken = createWaitOp(op->getLoc(), tokenType, {});
    asyncOp.addAsyncDependency(currentToken);

    // Clone the op to return a token in addition to the other results.
    SmallVector<Type, 1> resultTypes = {tokenType};
    resultTypes.reserve(1 + op->getNumResults());
    copy(op->getResultTypes(), std::back_inserter(resultTypes));
    auto *newOp = Operation::create(op->getLoc(), op->getName(), resultTypes,
                                    op->getOperands(), op->getAttrDictionary(),
                                    op->getSuccessors());

    // Replace the op with the async clone.
    auto results = newOp->getResults();
    currentToken = results.front();
    builder.insert(newOp);
    op->replaceAllUsesWith(results.drop_front());
    op->erase();

    return success();
  }

  Value createWaitOp(Location loc, Type resultType, ValueRange operands) {
    return builder.create<soda::WaitOp>(loc, resultType, operands).asyncToken();
  }

  OpBuilder builder;
  const Type tokenType = builder.getType<soda::AsyncTokenType>();
  // The token that represents the current asynchronous dependency. It's valid
  // range starts with a `soda.wait async` op, and ends with a `soda.wait` op.
  // In between, each soda::AsyncOpInterface depends on the current token and
  // produces the new one.
  Value currentToken = {};
};

// Replaces synchronous SODA ops in the op's region with asynchronous ones and
// inserts the necessary synchronization (as soda.wait ops). Assumes sequential
// execution semantics and that no SODA ops are asynchronous yet.
void SodaAsyncRegionPass::runOnOperation() {
  Callback callback{OpBuilder(&getContext())};
  if (getOperation().getRegion().walk(callback).wasInterrupted())
    return signalPassFailure();
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::soda::createSodaAsyncRegionPass() {
  return std::make_unique<SodaAsyncRegionPass>();
}
