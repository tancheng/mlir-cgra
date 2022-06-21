//===- AffineLoopPermutation.cpp - Test affine loop permutation -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file was modified based on:
//   llvm-project/mlir/test/lib/Dialect/Affine/TestLoopPermutation.cpp
// Adding the functionality of creating passes based on this transformation.
//
// This file implements a pass to test the affine for op permutation utility.
//
//===----------------------------------------------------------------------===//

#include "soda/Misc/Passes.h"

#include "mlir/Dialect/Affine/Analysis/Utils.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/LoopUtils.h"
#include "mlir/Pass/Pass.h"

#define PASS_NAME "soda-affine-test-loop-permutation"

using namespace mlir;
using namespace soda;

static llvm::cl::OptionCategory clOptionsCategory(PASS_NAME " options");

namespace {

/// This pass applies the permutation on the first maximal perfect nest.
struct TestLoopPermutation
    : public PassWrapper<TestLoopPermutation, OperationPass<func::FuncOp>> {
  StringRef getArgument() const final { return PASS_NAME; }
  StringRef getDescription() const final {
    return "Tests affine loop permutation utility";
  }
  TestLoopPermutation() = default;
  TestLoopPermutation(const TestLoopPermutation &pass){};
  TestLoopPermutation(const ArrayRef<unsigned> &permList) {
    this->permList = permList;
  };

  void runOnOperation() override;

private:
  /// Permutation specifying loop i is mapped to permList[i] in
  /// transformed nest (with i going from outermost to innermost).
  ListOption<unsigned> permList{*this, "permutation-map",
                                llvm::cl::desc("Specify the loop permutation"),
                                llvm::cl::OneOrMore, llvm::cl::CommaSeparated};
};

} // end anonymous namespace

void TestLoopPermutation::runOnOperation() {

  SmallVector<unsigned, 4> permMap(permList.begin(), permList.end());

  SmallVector<AffineForOp, 2> forOps;
  getOperation().walk([&](AffineForOp forOp) { forOps.push_back(forOp); });

  for (auto forOp : forOps) {
    SmallVector<AffineForOp, 6> nest;
    // Get the maximal perfect nest.
    getPerfectlyNestedLoops(nest, forOp);
    // Permute if the nest's size is consistent with the specified
    // permutation.
    if (nest.size() >= 2 && nest.size() == permMap.size()) {
      permuteLoops(nest, permMap);
    }
  }
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::soda::createAffineLoopPermutationPass(
    const ArrayRef<unsigned> &permList) {
  return std::make_unique<TestLoopPermutation>(permList);
}
