//===- SCFToSODAPass.cpp - Convert a loop nest to a SODA kernel -----------===//
//===----------------------------------------------------------------------===//
//
// This pass converts the outermost scf.for operations into soda.launch + the
// same scf.for operation. Marking the region to be outlined.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/SCFToSODAPass.h"
#include "../PassDetail.h"
#include "soda/Conversion/KernelsToSODA/SCFToSODA.h"

#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Transforms/DialectConversion.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/Support/CommandLine.h"

using namespace mlir;
using namespace mlir::scf;

//===----------------------------------------------------------------------===//
// AffineToSODA
//===----------------------------------------------------------------------===//

namespace {
// A pass that traverses top-level loops in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested loops.
struct AffineForLoopMapper
    : public ConvertAffineForToSODABase<AffineForLoopMapper> {
  AffineForLoopMapper() = default;

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto forOp = dyn_cast<AffineForOp>(&op)) {
        if (failed(convertAffineLoopNestToSODALaunch(forOp)))
          signalPassFailure();
      }
    }
  }
};

//===----------------------------------------------------------------------===//
// SCFToSODA
//===----------------------------------------------------------------------===//

// A pass that traverses top-level loops in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested loops.
struct SCFForLoopMapper : public ConvertSCFForToSODABase<SCFForLoopMapper> {
  SCFForLoopMapper() = default;

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto forOp = dyn_cast<scf::ForOp>(&op)) {
        if (failed(convertSCFLoopNestToSODALaunch(forOp)))
          signalPassFailure();
      }
    }
  }
};

} // namespace

std::unique_ptr<OperationPass<func::FuncOp>> mlir::createAffineForToSODAPass() {
  return std::make_unique<AffineForLoopMapper>();
}

std::unique_ptr<OperationPass<func::FuncOp>> mlir::createSCFForToSODAPass() {
  return std::make_unique<SCFForLoopMapper>();
}