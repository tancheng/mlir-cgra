//===- LinalgToSODAPass.cpp - Convert Linalg operations into SODA operations =//
//
// This pass converts different linalg... operations into soda.launch + the
// same operation. Marking the region to be outlined.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/LinalgToSODAPass.h"
#include "../PassDetail.h"
#include "soda/Conversion/KernelsToSODA/LinalgToSODA.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Transforms/DialectConversion.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/Support/CommandLine.h"

using namespace mlir;

namespace {
//===----------------------------------------------------------------------===//
// Linalg<Operation>ToSODA
//===----------------------------------------------------------------------===//

// A pass that traverses top-level dots in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested dots.
struct LinalgDotMapper : public ConvertLinalgDotToSODABase<LinalgDotMapper> {
  LinalgDotMapper() = default;

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto dotOp = dyn_cast<linalg::DotOp>(&op)) {
        if (failed(convertLinalgDotToSODALaunch(dotOp)))
          signalPassFailure();
      }
    }
  }
};

// A pass that traverses top-level matmuls in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested matmuls.
struct LinalgMatmulMapper
    : public ConvertLinalgMatmulToSODABase<LinalgMatmulMapper> {
  LinalgMatmulMapper() = default;

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto matmulOp = dyn_cast<linalg::MatmulOp>(&op)) {
        if (failed(convertLinalgMatmulToSODALaunch(matmulOp)))
          signalPassFailure();
      }
    }
  }
};

// A pass that traverses top-level conv in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested conv.
struct LinalgConvMapper : public ConvertLinalgConvToSODABase<LinalgConvMapper> {
  LinalgConvMapper() = default;

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto convOp = dyn_cast<linalg::Conv2DOp>(&op)) {
        if (failed(convertLinalgConvToSODALaunch(convOp)))
          signalPassFailure();
      }
    }
  }
};

// A pass that traverses top-level GenericOps in the function and converts them
// to SODA launch operations. Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested GenericOp.
struct LinalgGenericMapper
    : public ConvertLinalgGenericToSODABase<LinalgGenericMapper> {
  LinalgGenericMapper() = default;

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto genericOp = dyn_cast<linalg::GenericOp>(&op)) {
        if (failed(convertLinalgGenericToSODALaunch(genericOp)))
          signalPassFailure();
      }
    }
  }
};

} // namespace

std::unique_ptr<OperationPass<func::FuncOp>> mlir::createLinalgDotToSODAPass() {
  return std::make_unique<LinalgDotMapper>();
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::createLinalgMatmulToSODAPass() {
  return std::make_unique<LinalgMatmulMapper>();
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::createLinalgConvToSODAPass() {
  return std::make_unique<LinalgConvMapper>();
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::createLinalgGenericToSODAPass() {
  return std::make_unique<LinalgGenericMapper>();
}