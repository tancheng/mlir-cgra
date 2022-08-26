//===- LinalgToSODA.cpp - Convert linalg operations to a SODA operations --===//
//===----------------------------------------------------------------------===//
//
// This implements a straightforward conversion of an key linalg operation into
// SODA launch operations.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/LinalgToSODA.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Location.h"

#define DEBUG_TYPE "linalg-to-soda"

using namespace mlir;

namespace {
// Helper structure that holds common state of the loop to SODA kernel
// conversion.
struct LinalgToSodaConverter {
  template <class T>
  void createLaunch(T rootMatmulOp);
};

} // namespace

//===----------------------------------------------------------------------===//
// LinalgToSODA
//===----------------------------------------------------------------------===//

/// Add a SODA launch operation around the "linalg.<operation>" op.
template <class T>
void LinalgToSodaConverter::createLaunch(T rootLinalgOp) {
  OpBuilder builder(rootLinalgOp.getOperation());

  // Create a launch op and move target op into the region
  Location loc = rootLinalgOp.getLoc();
  auto launchOp = builder.create<soda::LaunchOp>(loc);
  builder.setInsertionPointToEnd(&launchOp.body().front());
  builder.create<soda::TerminatorOp>(loc);
  builder.setInsertionPointToStart(&launchOp.body().front());

  // Clone the linalg op.
  auto *newOp = Operation::create(
      rootLinalgOp->getLoc(), rootLinalgOp->getName(),
      rootLinalgOp->getResultTypes(), rootLinalgOp->getOperands(),
      rootLinalgOp->getAttrDictionary(), rootLinalgOp->getSuccessors(),
      rootLinalgOp->getRegions());

  // Insert the clone into the soda launch.
  auto results = newOp->getResults();
  builder.insert(newOp);
  rootLinalgOp->replaceAllUsesWith(results);
  rootLinalgOp->erase();
}

static LogicalResult convertLinalgDotToSODALaunch(linalg::DotOp op) {

  LinalgToSodaConverter converter;
  converter.createLaunch(op);

  return success();
}

LogicalResult mlir::convertLinalgDotToSODALaunch(linalg::DotOp op) {
  return ::convertLinalgDotToSODALaunch(op);
}

static LogicalResult convertLinalgMatmulToSODALaunch(linalg::MatmulOp op) {

  LinalgToSodaConverter converter;
  converter.createLaunch(op);

  return success();
}

LogicalResult mlir::convertLinalgMatmulToSODALaunch(linalg::MatmulOp op) {
  return ::convertLinalgMatmulToSODALaunch(op);
}

static LogicalResult convertLinalgConvToSODALaunch(linalg::Conv2DOp op) {

  LinalgToSodaConverter converter;
  converter.createLaunch(op);

  return success();
}

LogicalResult mlir::convertLinalgConvToSODALaunch(linalg::Conv2DOp op) {
  return ::convertLinalgConvToSODALaunch(op);
}

static LogicalResult convertLinalgGenericToSODALaunch(linalg::GenericOp op) {

  LinalgToSodaConverter converter;
  converter.createLaunch(op);

  return success();
}

LogicalResult mlir::convertLinalgGenericToSODALaunch(linalg::GenericOp op) {
  return ::convertLinalgGenericToSODALaunch(op);
}