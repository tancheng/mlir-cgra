//===- OperationToSODAPass.cpp - Convert named ops into SODA operations ---- =//
//
// This pass converts different operations that match the selected named into
// soda.launch + the same operation. Marking the region to be outlined.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/OperationToSODAPass.h"
#include "../PassDetail.h"
#include "soda/Conversion/KernelsToSODA/OperationToSODA.h"

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
struct OperationMapper : public ConvertOperationToSODABase<OperationMapper> {
  OperationMapper() = default;

  OperationMapper(StringRef opName) {
    this->anchorOpName.setValue(opName.str());
  }

  OperationMapper(StringRef funcName, StringRef opName) {
    this->anchorFuncName.setValue(funcName.str());
    this->anchorOpName.setValue(opName.str());
  }

  void runOnInnerOp(scf::ForOp& forOp) {

    for (Operation &innerOp : llvm::make_early_inc_range(forOp.getBody()->getOperations())) {
      if (auto op = dyn_cast<scf::ForOp>(&innerOp)) {
        runOnInnerOp(op);
      } else {
        if (innerOp.getName().getStringRef() == anchorOpName) {
          if (failed(convertOperationToSODALaunch((&innerOp))))
            signalPassFailure();
	}
      }
    }
  }

  void runOnOperation() override {
    auto funcOp = getOperation();
    if (!anchorFuncName.empty() && funcOp.getName() != anchorFuncName)
      return;

    // bool foundMatch = false;
    for (Operation &op : llvm::make_early_inc_range(funcOp.getOps())) {
      if (op.getName().getStringRef() == anchorOpName) {
        // foundMatch = true;
        if (failed(convertOperationToSODALaunch((&op))))
          signalPassFailure();
      } else if (auto forOp = dyn_cast<scf::ForOp>(&op)) {
        runOnInnerOp(forOp);
      }

    }
    // if (!foundMatch) {
    //   funcOp.emitWarning() << "Could not find any operation to mark "
    //                           "for future outlining in this function.";
    // }
  }
};

} // namespace

std::unique_ptr<OperationPass<func::FuncOp>> mlir::createOperationToSODAPass() {
  return std::make_unique<OperationMapper>();
}
