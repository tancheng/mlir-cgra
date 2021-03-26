//===- LinalgToSODA.cpp - Convert linalg operations to a SODA operations --===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This implements a straightforward conversion of an key linalg operation into
// SODA launch operations..
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/LinalgToSODA.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/Linalg/IR/LinalgOps.h"
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

/// Add a SODA launch operation around the "linalg.matmul" op.
template <class T>
void LinalgToSodaConverter::createLaunch(T rootMatmulOp) {
  OpBuilder builder(rootMatmulOp.getOperation());

  // Create a launch op and move target op into the region
  Location loc = rootMatmulOp.getLoc();
  auto launchOp = builder.create<soda::LaunchOp>(loc);
  builder.setInsertionPointToEnd(&launchOp.body().front());
  builder.create<soda::TerminatorOp>(loc);
  builder.setInsertionPointToStart(&launchOp.body().front());

  // Clone the linalg op.
  auto *newOp = Operation::create(
      rootMatmulOp->getLoc(), rootMatmulOp->getName(),
      rootMatmulOp->getResultTypes(), rootMatmulOp->getOperands(),
      rootMatmulOp->getAttrDictionary(), rootMatmulOp->getSuccessors(),
      rootMatmulOp->getRegions());

  // Insert the clone into the soda launch.
  auto results = newOp->getResults();
  builder.insert(newOp);
  rootMatmulOp->replaceAllUsesWith(results);
  rootMatmulOp->erase();
}

static LogicalResult convertLinalgMatmulToSODALaunch(linalg::MatmulOp op) {

  LinalgToSodaConverter converter;
  converter.createLaunch(op);

  return success();
}

LogicalResult mlir::convertLinalgMatmulToSODALaunch(linalg::MatmulOp op) {
  return ::convertLinalgMatmulToSODALaunch(op);
}

static LogicalResult convertLinalgConvToSODALaunch(linalg::ConvOp op) {

  LinalgToSodaConverter converter;
  converter.createLaunch(op);

  return success();
}

LogicalResult mlir::convertLinalgConvToSODALaunch(linalg::ConvOp op) {
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