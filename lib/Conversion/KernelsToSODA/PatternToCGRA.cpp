//===- OperationToSODA.cpp - Convert operations matching string to a SODA -===//
//===----------------------------------------------------------------------===//
//
// This implements a straightforward conversion of operation that matches anchor
// string to SODA launch operations.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/PatternToCGRA.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Location.h"

#define DEBUG_TYPE "pattern-to-cgra"

using namespace mlir;

namespace {
// Helper structure that holds common state of the loop to SODA kernel
// conversion.
struct PatternToCGRAConverter {
  void createLaunch(Operation *rootOp);
};

} // namespace

//===----------------------------------------------------------------------===//
// OperationToSODA
//===----------------------------------------------------------------------===//

/// Add a SODA launch operation around the selected anchor op.
void PatternToCGRAConverter::createLaunch(Operation *rootOp) {
  OpBuilder builder(rootOp);

  // Create a launch op and move target op into the region
  Location loc = rootOp->getLoc();
  auto launchOp = builder.create<soda::LaunchOp>(loc);
  builder.setInsertionPointToEnd(&launchOp.body().front());
  builder.create<soda::TerminatorOp>(loc);
  builder.setInsertionPointToStart(&launchOp.body().front());

  // Clone the op.
  auto *newOp = Operation::create(
      rootOp->getLoc(), rootOp->getName(), rootOp->getResultTypes(),
      rootOp->getOperands(), rootOp->getAttrDictionary(),
      rootOp->getSuccessors(), rootOp->getRegions());

  // Insert the clone into the soda launch.
  auto results = newOp->getResults();
  builder.insert(newOp);
  rootOp->replaceAllUsesWith(results);
  rootOp->erase();
}

static LogicalResult convertPatternToCGRALaunch(Operation *op) {
  PatternToCGRAConverter converter;
  converter.createLaunch(op);
  return success();
}

LogicalResult mlir::convertPatternToCGRALaunch(Operation *op) {
  return ::convertPatternToCGRALaunch(op);
}
