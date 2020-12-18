//===- LinalgToSODAPass.cpp - Convert Linalg operations into SODA operations =//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/LinalgToSODAPass.h"
#include "../PassDetail.h"
#include "soda/Conversion/KernelsToSODA/LinalgToSODA.h"

#include "mlir/Dialect/Linalg/IR/LinalgOps.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Transforms/DialectConversion.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/Support/CommandLine.h"

using namespace mlir;


namespace {
//===----------------------------------------------------------------------===//
// LinalgMatmulToSODA
//===----------------------------------------------------------------------===//

// A pass that traverses top-level matmuls in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested matmuls.
struct LinalgMatmulMapper
    : public ConvertLinalgMatmulToSODABase<LinalgMatmulMapper> {
  LinalgMatmulMapper() = default;

  void runOnFunction() override {
    for (Operation &op : llvm::make_early_inc_range(getFunction().getOps())) {
      if (auto matmulOp = dyn_cast<linalg::MatmulOp>(&op)) {
        if (failed(convertLinalgMatmulToSODALaunch(matmulOp)))
          signalPassFailure();
      }
    }
  }
};

} // namespace


std::unique_ptr<OperationPass<FuncOp>> mlir::createLinalgMatmulToSODAPass() {
  return std::make_unique<LinalgMatmulMapper>();
}