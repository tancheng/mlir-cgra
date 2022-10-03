//===- LinalgToSODA.cpp - Convert linalg operations to a SODA operations --===//
//===----------------------------------------------------------------------===//
//
// This implements a straightforward conversion of an key linalg operation into
// SODA launch operations.
//
//===----------------------------------------------------------------------===//
#include <iostream>

#include "soda/Conversion/KernelsToSODA/LinalgToSODA.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Arithmetic/IR/Arithmetic.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Location.h"

#define DEBUG_TYPE "linalg-to-soda"

using namespace mlir;

namespace {
// Helper structure that holds common state of the loop to SODA kernel
// conversion.
struct LinalgToSodaConverter {
  template <class T>
  void createLaunch(T rootOp);
  template <class T>
  void createMatmulLaunch(T rootOp);
  template <class T>
  void createGenericLaunch(T rootOp);
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

/// Add a CGRA launch operation around the "linalg.matmul" op.
template <class T>
void LinalgToSodaConverter::createMatmulLaunch(T rootLinalgOp) {
  OpBuilder builder(rootLinalgOp.getOperation());

  if (dyn_cast<linalg::MatmulOp>(&rootLinalgOp) != nullptr) {

    // Create a launch op and move target op into the region
    Location loc = rootLinalgOp.getLoc();
    auto launchOp = builder.create<soda::LaunchOp>(loc);
    builder.setInsertionPointToEnd(&launchOp.body().front());
    builder.create<soda::TerminatorOp>(loc);
    builder.setInsertionPointToStart(&launchOp.body().front());
  
    Operation* newOp = builder.create<soda::MatmulOp>(loc, rootLinalgOp->getOperands());

    auto results = newOp->getResults();
    rootLinalgOp->replaceAllUsesWith(results);
    rootLinalgOp->erase();
  }
}

/// Add a CGRA launch operation around the "linalg.generic" op.
template <class T>
void LinalgToSodaConverter::createGenericLaunch(T rootLinalgOp) {
  OpBuilder builder(rootLinalgOp.getOperation());

  if (dyn_cast<linalg::GenericOp>(&rootLinalgOp) != nullptr) {

    // Create a launch op and move target op into the region
    Location loc = rootLinalgOp.getLoc();
    auto launchOp = builder.create<soda::LaunchOp>(loc);
    builder.setInsertionPointToEnd(&launchOp.body().front());
    builder.create<soda::TerminatorOp>(loc);
    builder.setInsertionPointToStart(&launchOp.body().front());
  
    Operation* newOp = NULL;

    // TODO: fuse arbitrary operations into single CGRA operation
    auto genericOp = dyn_cast<linalg::GenericOp>(&rootLinalgOp);
    for (Operation &arithOp : llvm::make_early_inc_range(genericOp->getRegion().front().getOperations())) {
      if (auto maxOp = dyn_cast<arith::MaxFOp>(&arithOp)) {
        mlir::Value maxInput = maxOp.getOperand(0);
        auto maxInputOp = maxInput.getDefiningOp<arith::AddFOp>();
	if (maxInputOp) {
          newOp = builder.create<soda::AddMaxOp>(loc, rootLinalgOp->getOperands());
	}
      }
    }

    if (newOp != NULL) {
      auto results = newOp->getResults();
      rootLinalgOp->replaceAllUsesWith(results);
      rootLinalgOp->erase();
    }
  }
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
  converter.createMatmulLaunch(op);

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
  converter.createGenericLaunch(op);

  return success();
}

LogicalResult mlir::convertLinalgGenericToSODALaunch(linalg::GenericOp op) {
  return ::convertLinalgGenericToSODALaunch(op);
}
