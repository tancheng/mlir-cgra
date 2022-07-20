//===- AllToSODAPass.cpp - Convert ops in a function to SODA operatios ---- =//
//
// This pass converts all operations in a function into soda.launch + the same
// operation. Marking the region to be outlined.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/AllToSODAPass.h"
#include "../PassDetail.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Transforms/DialectConversion.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/Support/CommandLine.h"

#include "mlir/IR/Builders.h"
#include "mlir/IR/Location.h"

#define DEBUG_TYPE "all-to-soda"

using namespace mlir;

namespace {

//===----------------------------------------------------------------------===//
// AllToSODA
//===----------------------------------------------------------------------===//

struct ConvertAllToSODAPass
    : public ConvertAllToSODABase<ConvertAllToSODAPass> {
  ConvertAllToSODAPass() = default;

  ConvertAllToSODAPass(StringRef funcName) {
    this->anchorFuncName.setValue(funcName.str());
  }

  void runOnOperation() override {
    func::FuncOp funcOp = getOperation();

    if (!anchorFuncName.empty() && funcOp.getName() != anchorFuncName)
      return;

    // Clone all ops
    std::vector<Operation *> opsToClone;
    for (Operation &op : llvm::make_early_inc_range(funcOp.getOps())) {
      if (!(isa<func::ReturnOp>(&op))) {
        opsToClone.push_back(&op);
      }
    }

    OpBuilder builder(funcOp);

    // Create a launch op and place all ops into its region
    Location loc = funcOp.front().front().getLoc();
    builder.setInsertionPointToStart(&funcOp.front());
    auto launchOp = builder.create<soda::LaunchOp>(loc);
    builder.setInsertionPointToEnd(&launchOp.body().front());
    builder.create<soda::TerminatorOp>(loc);
    builder.setInsertionPointToStart(&launchOp.body().front());

    for (Operation *op : opsToClone) {
      Operation *newOp = Operation::create(
          op->getLoc(), op->getName(), op->getResultTypes(), op->getOperands(),
          op->getAttrDictionary(), op->getSuccessors(), op->getRegions());

      // Insert the clone into the soda launch.
      auto results = newOp->getResults();
      builder.insert(newOp);
      op->replaceAllUsesWith(results);
      op->erase();
    }
  }
};

} // namespace

std::unique_ptr<OperationPass<func::FuncOp>> mlir::createAllToSODAPass() {
  return std::make_unique<ConvertAllToSODAPass>();
}
