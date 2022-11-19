//===- LinalgTilingForCGRA.cpp - tiling Linalg::op based on HW param ----*-===//
//
// This file implements a pass that tiles the linalg operations (e.g., matmul,
// generic) to fit CGRA's compute and communication constraints/overhead.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/Transforms/Transforms.h"
#include "mlir/Dialect/Linalg/Transforms/CodegenStrategy.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/SCF/IR/SCF.h"

#include "mlir/IR/Operation.h"
#include "mlir/Pass/Pass.h"
#include "soda/Misc/Passes.h"
#include "mlir/Pass/PassManager.h"
#include <iostream>
#include <string>

using namespace std;
using namespace mlir;
using namespace soda;

#define DEBUG_TYPE "linalg-tiling-for-cgra-pass"

const StringLiteral kLinalgTransformMarker = "__internal_linalg_transform__";

namespace {

struct LinalgTilingForCGRA : public LinalgTilingForCGRABase<LinalgTilingForCGRA> {
  LinalgTilingForCGRA() = default;

  LinalgTilingForCGRA(ArrayRef<uint64_t> configs) {
    this->CGRAConfigs = configs;
  }

  void runOnOperation() override {
    int dimX = 4;
    int dimY = 4;
    int buffInput0 = 1024;
    int buffInput1 = 1024;
    int buffInput2 = 1024;
    int buffOutput = 1024;
    if (CGRAConfigs.size() > 0) {
        assert(CGRAConfigs.size() == 6);
        dimX = CGRAConfigs[0];
        dimY = CGRAConfigs[1];
        assert(dimX == dimY);
        buffInput0 = CGRAConfigs[2];
        buffInput1 = CGRAConfigs[3];
        buffInput2 = CGRAConfigs[4];
        buffOutput = CGRAConfigs[5];
        assert(buffInput0 == buffInput1);
        assert(buffInput1 == buffInput2);
        assert(buffInput2 == buffOutput);
    }

    int matmulReducedTile = buffInput0 / 4 / (dimX * dimY);
    int genericOpTile = buffInput0 / 4;

    SmallVector<int64_t> GenericOpTileSizes;
    SmallVector<int64_t> MatmulOpTileSizes;
    SmallVector<int64_t> BatchMatmulOpTileSizes;

    if (matmulReducedTile > 1) {
        MatmulOpTileSizes.push_back(dimX);
        MatmulOpTileSizes.push_back(dimY);
        MatmulOpTileSizes.push_back(matmulReducedTile);

        BatchMatmulOpTileSizes.push_back(1);
        BatchMatmulOpTileSizes.push_back(dimX);
        BatchMatmulOpTileSizes.push_back(dimY);
        BatchMatmulOpTileSizes.push_back(matmulReducedTile);
    } else {
        MatmulOpTileSizes.push_back(dimX);
        MatmulOpTileSizes.push_back(dimY);

        BatchMatmulOpTileSizes.push_back(dimX);
        BatchMatmulOpTileSizes.push_back(dimY);
    }

    auto module = getOperation()->getParentOfType<mlir::ModuleOp>();
    auto ctx = module.getContext();
    PassManager pm(module.getContext());
    
    auto matmulOpOptions = linalg::LinalgTilingOptions().setTileSizes(MatmulOpTileSizes);
    auto batchMatmulOpOptions = linalg::LinalgTilingOptions().setTileSizes(BatchMatmulOpTileSizes);

    // In this prototype, we only target the genericOp that contains more than 1 opt for simplicity,
    // i.e., avoid the ones only contain single `yield`.
    getOperation().walk([&](linalg::GenericOp op) {
      if (op.getRegion().front().getOperations().size() > 1 &&
          !op->getAttr(kLinalgTransformMarker)) {

        bool isTarget = true;
        for (uint64_t i=0; i<op->getOperands().size(); ++i) {
          if (op->getOperand(i).getType().dyn_cast<MemRefType>().getShape().size() < 1) {
            isTarget = false;
            break;
          }
        }

        if (isTarget) {
          auto shape0 = op->getOperand(0).getType().dyn_cast<MemRefType>().getShape();
          for (uint64_t i=1; i<op->getOperands().size(); ++i) {
            auto curShape = op->getOperand(i).getType().dyn_cast<MemRefType>().getShape();
            if (shape0.size() != curShape.size()) {
              isTarget = false;
              break;
            }
            for (uint64_t j=0; j<shape0.size(); ++j) {
              if (shape0[j] != curShape[j]) {
                isTarget = false;
                break;
              }
            }
            if (!isTarget)
              break;
          }
        }

        if (isTarget) {
          auto memrefType = op->getOperand(0).getType().dyn_cast<MemRefType>();
          auto shapes = memrefType.getShape();
          int curAccum = 1;
          int lastAccum = 1;
          SmallVector<int64_t> reversedGenericOpTileSizes;
          for (int i=shapes.size()-1; i>=0; i--) {
            curAccum *= shapes[i];
            if (curAccum <= genericOpTile) {
              reversedGenericOpTileSizes.push_back(shapes[i]);
            } else {
              reversedGenericOpTileSizes.push_back(genericOpTile / lastAccum);
              i--;
              while (i >= 0) {
                reversedGenericOpTileSizes.push_back(1);
                i--;
              }
              break;
            }
            lastAccum = curAccum;
          }

          GenericOpTileSizes.clear();
          // cout<<"tiling: ";
          while (reversedGenericOpTileSizes.size() != 0) {
            GenericOpTileSizes.push_back(reversedGenericOpTileSizes.back());
            // cout<<"  "<<reversedGenericOpTileSizes.back();
            reversedGenericOpTileSizes.pop_back();
          }
          // cout<<"   tiling done"<<endl;
          op->setAttr(kLinalgTransformMarker,
                      StringAttr::get(&getContext(), "GenericOpTilable"));
        }
      }
    });

    getOperation().walk([&](linalg::MatmulOp op) {
      if (!op->getAttr(kLinalgTransformMarker)) {
        op->setAttr(kLinalgTransformMarker,
                    StringAttr::get(&getContext(), "MatmulOpTilable"));
      }
    });

    getOperation().walk([&](linalg::BatchMatmulOp op) {
      if (!op->getAttr(kLinalgTransformMarker)) {
        op->setAttr(kLinalgTransformMarker,
                    StringAttr::get(&getContext(), "BatchMatmulTilable"));
      }
    });

    auto genericOpOptions = linalg::LinalgTilingOptions().setTileSizes(GenericOpTileSizes);

    linalg::LinalgTransformationFilter genericOpF(StringAttr::get(ctx, "GenericOpTilable"), StringAttr::get(ctx, "offloadedOnCGRA"));
    linalg::LinalgTransformationFilter matmulOpF(StringAttr::get(ctx, "MatmulOpTilable"), StringAttr::get(ctx, "offloadedOnCGRA"));
    linalg::LinalgTransformationFilter batchMatmulOpF(StringAttr::get(ctx, "BatchMatmulTilable"), StringAttr::get(ctx, "offloadedOnCGRA"));
    
    pm.addNestedPass<func::FuncOp>(
      mlir::createLinalgStrategyTilePass("linalg.generic", genericOpOptions, genericOpF));
    
    pm.addNestedPass<func::FuncOp>(
      mlir::createLinalgStrategyTilePass("linalg.matmul", matmulOpOptions, matmulOpF));

    pm.addNestedPass<func::FuncOp>(
      mlir::createLinalgStrategyTilePass("linalg.batch_matmul", batchMatmulOpOptions, batchMatmulOpF));

    getOperation().emitWarning();
    if (failed(pm.run(module)))
      signalPassFailure();
  }
};

} // end anonymous namespace

std::unique_ptr<OperationPass<func::FuncOp>>
mlir::soda::createLinalgTilingForCGRAPass() {
  return std::make_unique<LinalgTilingForCGRA>();
}
