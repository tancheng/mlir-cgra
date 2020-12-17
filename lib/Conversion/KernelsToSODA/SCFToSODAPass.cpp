//===- SCFToSODAPass.cpp - Convert a loop nest to a SODA kernel -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/SCFToSODAPass.h"
#include "../PassDetail.h"
#include "soda/Conversion/KernelsToSODA/SCFToSODA.h"

#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Transforms/DialectConversion.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/Support/CommandLine.h"

using namespace mlir;
using namespace mlir::scf;

namespace {
// A pass that traverses top-level loops in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested loops.
struct ForLoopMapper : public ConvertAffineForToSODABase<ForLoopMapper> {
  ForLoopMapper() = default;
  ForLoopMapper(unsigned numBlockDims, unsigned numThreadDims) {
    this->numBlockDims = numBlockDims;
    this->numThreadDims = numThreadDims;
  }

  void runOnFunction() override {
    for (Operation &op : llvm::make_early_inc_range(getFunction().getOps())) {
      if (auto forOp = dyn_cast<AffineForOp>(&op)) {
        if (failed(convertAffineLoopNestToSODALaunch(forOp, numBlockDims,
                                                    numThreadDims)))
          signalPassFailure();
      }
    }
  }
};

struct ParallelLoopToSodaPass
    : public ConvertParallelLoopToSodaBase<ParallelLoopToSodaPass> {
  void runOnOperation() override {
    OwningRewritePatternList patterns;
    populateParallelLoopToSODAPatterns(patterns, &getContext());
    ConversionTarget target(getContext());
    target.addLegalDialect<StandardOpsDialect>();
    target.addLegalDialect<AffineDialect>();
    target.addLegalDialect<soda::SODADialect>();
    target.addLegalDialect<scf::SCFDialect>();
    target.addIllegalOp<scf::ParallelOp>();
    if (failed(applyPartialConversion(getOperation(), target,
                                      std::move(patterns))))
      signalPassFailure();
  }
};

} // namespace

std::unique_ptr<OperationPass<FuncOp>>
mlir::createAffineForToSODAPass(unsigned numBlockDims, unsigned numThreadDims) {
  return std::make_unique<ForLoopMapper>(numBlockDims, numThreadDims);
}
std::unique_ptr<OperationPass<FuncOp>> mlir::createAffineForToSODAPass() {
  return std::make_unique<ForLoopMapper>();
}

std::unique_ptr<Pass> mlir::createParallelLoopToSodaPass() {
  return std::make_unique<ParallelLoopToSodaPass>();
}
