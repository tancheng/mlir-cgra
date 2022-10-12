//===- OperationToSODAPass.cpp - Convert named ops into SODA operations ---- =//
//
// This pass converts different operations that match the selected named into
// soda.launch + the same operation. Marking the region to be outlined.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/PatternToCGRAPass.h"
#include "../PassDetail.h"
#include "soda/Conversion/KernelsToSODA/PatternToCGRA.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Transforms/DialectConversion.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/Support/CommandLine.h"

using namespace mlir;

namespace {
//===----------------------------------------------------------------------===//
// OperationToSODA
//===----------------------------------------------------------------------===//

// A pass that traverses top-level ops in the function and converts them to
// SODA launch operations.  Nested launches are not allowed, so this does not
// walk the function recursively to avoid considering nested dots.
struct OperationMapper : public ConvertPatternToCGRABase<OperationMapper> {
  OperationMapper() = default;

  OperationMapper(StringRef opName) {
    this->targetPatterns.setValue(opName.str());
  }

  void runOnInnerOp(scf::ForOp& forOp) {

    for (Operation &innerOp : llvm::make_early_inc_range(forOp.getBody()->getOperations())) {
      if (auto op = dyn_cast<scf::ForOp>(&innerOp)) {
        runOnInnerOp(op);
      } else {
        // if (innerOp.getName().getStringRef() == targetPatterns) {
        if (auto genericOp = dyn_cast<linalg::GenericOp>(&innerOp)) {
          if (failed(convertPatternToCGRALaunch(&innerOp, targetPatterns)))
            signalPassFailure();
	}
      }
    }
  }

  void runOnOperation() override {
    auto funcOp = getOperation();
    for (Operation &op : llvm::make_early_inc_range(funcOp.getOps())) {
      // if (op.getName().getStringRef() == targetPatterns) {
      if (auto genericOp = dyn_cast<linalg::GenericOp>(&op)) {
        if (failed(convertPatternToCGRALaunch(&op, targetPatterns)))
          signalPassFailure();
      } else if (auto forOp = dyn_cast<scf::ForOp>(&op)) {
        runOnInnerOp(forOp);
      }

    }
  }
};

} // namespace

std::unique_ptr<OperationPass<func::FuncOp>> mlir::createPatternToCGRAPass() {
  return std::make_unique<OperationMapper>();
}
