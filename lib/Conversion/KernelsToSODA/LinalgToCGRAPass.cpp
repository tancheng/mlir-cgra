//===- LinalgToCGRAPass.cpp - Convert Linalg operations into CGRA operations =//
//
// This pass converts different linalg... operations into cgra.launch + the
// same operation. Marking the region to be outlined.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/LinalgToCGRAPass.h"
#include "../PassDetail.h"
#include "soda/Conversion/KernelsToSODA/LinalgToCGRA.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Transforms/DialectConversion.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/Support/CommandLine.h"

#include <iostream>

using namespace mlir;

namespace {
//===----------------------------------------------------------------------===//
// Linalg<Operation>ToSODA
//===----------------------------------------------------------------------===//

// A pass that traverses top-level dots in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested dots.
// struct LinalgDotMapper : public ConvertLinalgDotToCGRABase<LinalgDotMapper> {
//   LinalgDotMapper() = default;
// 
//   void runOnOperation() override {
//     for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
//       if (auto dotOp = dyn_cast<linalg::DotOp>(&op)) {
//         if (failed(convertLinalgDotToSODALaunch(dotOp)))
//           signalPassFailure();
//       }
//     }
//   }
// };

// A pass that traverses top-level matmuls in the function and converts them to
// CGRA launch operations.
struct LinalgMatmulMapper: public ConvertLinalgMatmulToCGRABase<LinalgMatmulMapper> {
  LinalgMatmulMapper() = default;

  void runOnInnerOp(scf::ForOp& forOp) {
    for (Operation &innerOp : llvm::make_early_inc_range(forOp.getBody()->getOperations())) {
      if (auto innerMatmulOp = dyn_cast<linalg::MatmulOp>(&innerOp)) {
        if (failed(convertLinalgMatmulToCGRALaunch(innerMatmulOp))) {
          signalPassFailure();
        }
      } else if (auto forOp = dyn_cast<scf::ForOp>(&innerOp)) {
        runOnInnerOp(forOp);
      }
    }
  }

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto matmulOp = dyn_cast<linalg::MatmulOp>(&op)) {
        if (failed(convertLinalgMatmulToCGRALaunch(matmulOp)))
          signalPassFailure();
      } else if (auto forOp = dyn_cast<scf::ForOp>(&op)) {
	      runOnInnerOp(forOp);
      }
    }
  }
};


// A pass that traverses top-level batch_matmuls in the function and converts them to
// CGRA launch operations.
struct LinalgBatchMatmulMapper: public ConvertLinalgBatchMatmulToCGRABase<LinalgBatchMatmulMapper> {
  LinalgBatchMatmulMapper() = default;

  void runOnInnerOp(scf::ForOp& forOp) {
    for (Operation &innerOp : llvm::make_early_inc_range(forOp.getBody()->getOperations())) {
      if (auto innerMatmulOp = dyn_cast<linalg::BatchMatmulOp>(&innerOp)) {
        if (failed(convertLinalgBatchMatmulToCGRALaunch(innerMatmulOp))) {
          signalPassFailure();
        }
      } else if (auto forOp = dyn_cast<scf::ForOp>(&innerOp)) {
        runOnInnerOp(forOp);
      }
    }
  }

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto matmulOp = dyn_cast<linalg::BatchMatmulOp>(&op)) {
        if (failed(convertLinalgBatchMatmulToCGRALaunch(matmulOp)))
          signalPassFailure();
      } else if (auto forOp = dyn_cast<scf::ForOp>(&op)) {
	      runOnInnerOp(forOp);
      }
    }
  }
};

// A pass that traverses top-level conv in the function and converts them to
// CGRA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested conv.
struct LinalgConvMapper: public ConvertLinalgConvToCGRABase<LinalgConvMapper> {
  LinalgConvMapper() = default;

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto convOp = dyn_cast<linalg::Conv2DOp>(&op)) {
        if (failed(convertLinalgConvToCGRALaunch(convOp)))
          signalPassFailure();
      }
    }
  }
};

// A pass that traverses top-level GenericOps in the function and converts them
// to CGRA launch operations.
struct LinalgGenericMapper: public ConvertLinalgGenericToCGRABase<LinalgGenericMapper> {
  LinalgGenericMapper() = default;

  void runOnInnerOp(scf::ForOp& forOp) {
    for (Operation &innerOp : llvm::make_early_inc_range(forOp.getBody()->getOperations())) {
      if (auto innerGenericOp = dyn_cast<linalg::GenericOp>(&innerOp)) {
        if (failed(convertLinalgGenericToCGRALaunch(innerGenericOp))) {
          signalPassFailure();
        }
      } else if (auto forOp = dyn_cast<scf::ForOp>(&innerOp)) {
        runOnInnerOp(forOp);
      }
    }
  }

  void runOnOperation() override {
    for (Operation &op : llvm::make_early_inc_range(getOperation().getOps())) {
      if (auto genericOp = dyn_cast<linalg::GenericOp>(&op)) {
        if (failed(convertLinalgGenericToCGRALaunch(genericOp)))
          signalPassFailure();
      } else if (auto forOp = dyn_cast<scf::ForOp>(&op)) {
	      runOnInnerOp(forOp);
      }
    }
  }
};
} // namespace

// std::unique_ptr<OperationPass<func::FuncOp>>
// mlir::createLinalgDotToSODAPass() {
//   return std::make_unique<LinalgDotMapper>();
// }

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::createLinalgMatmulToCGRAPass() {
  return std::make_unique<LinalgMatmulMapper>();
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::createLinalgBatchMatmulToCGRAPass() {
  return std::make_unique<LinalgBatchMatmulMapper>();
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::createLinalgConvToCGRAPass() {
  return std::make_unique<LinalgConvMapper>();
}

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::createLinalgGenericToCGRAPass() {
  return std::make_unique<LinalgGenericMapper>();
}

// std::unique_ptr<OperationPass<func::FuncOp>>
// mlir::createLinalgGenericToSODAPass() {
//   return std::make_unique<LinalgGenericMapper>();
// }
