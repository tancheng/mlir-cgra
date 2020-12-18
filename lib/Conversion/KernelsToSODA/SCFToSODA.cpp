//===- SCFToSODA.cpp - Convert an affine loop nest to a SODA kernel -------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This implements a straightforward conversion of an loop nest into a SODA
// kernel.  The caller is expected to guarantee that the conversion is correct
// or to further transform the kernel to ensure correctness.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/SCFToSODA.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Location.h"

#define DEBUG_TYPE "loops-to-soda"

using namespace mlir;

namespace {
// Helper structure that holds common state of the loop to SODA kernel
// conversion.
struct AffineLoopToSodaConverter {
  void createLaunch(AffineForOp rootForOp);
};

// Helper structure that holds common state of the loop to SODA kernel
// conversion.
struct SCFLoopToSodaConverter {
  void createLaunch(scf::ForOp rootForOp);
};
} // namespace

//===----------------------------------------------------------------------===//
// AffineToSODA
//===----------------------------------------------------------------------===//

/// Add a SODA launch operation around the "rootForOp".
void AffineLoopToSodaConverter::createLaunch(AffineForOp rootForOp) {
  OpBuilder builder(rootForOp.getOperation());

  // Create a launch op and move the body region of the innermost loop to the
  // launch op.
  Location loc = rootForOp.getLoc();
  auto launchOp = builder.create<soda::LaunchOp>(loc);
  builder.setInsertionPointToEnd(&launchOp.body().front());
  builder.create<soda::TerminatorOp>(loc);
  builder.setInsertionPointToStart(&launchOp.body().front());

  // Copy root loop and its operations into the soda launch function
  auto &ops = rootForOp.getBody()->getOperations();
  launchOp.body().front().getOperations().splice(
      launchOp.body().front().begin(), ops, Block::iterator(rootForOp));
}

static LogicalResult convertAffineLoopNestToSODALaunch(AffineForOp forOp) {

  AffineLoopToSodaConverter converter;
  converter.createLaunch(forOp);

  return success();
}

LogicalResult mlir::convertAffineLoopNestToSODALaunch(AffineForOp forOp) {
  return ::convertAffineLoopNestToSODALaunch(forOp);
}

//===----------------------------------------------------------------------===//
// SCFToSODA
//===----------------------------------------------------------------------===//

/// Add a SODA launch operation around the "rootForOp".
void SCFLoopToSodaConverter::createLaunch(scf::ForOp rootForOp) {
  OpBuilder builder(rootForOp.getOperation());

  // Create a launch op and move the body region of the innermost loop to the
  // launch op.
  Location loc = rootForOp.getLoc();
  auto launchOp = builder.create<soda::LaunchOp>(loc);
  builder.setInsertionPointToEnd(&launchOp.body().front());
  builder.create<soda::TerminatorOp>(loc);
  builder.setInsertionPointToStart(&launchOp.body().front());

  // Copy root loop and its operations into the soda launch function
  auto &ops = rootForOp.getBody()->getOperations();
  launchOp.body().front().getOperations().splice(
      launchOp.body().front().begin(), ops, Block::iterator(rootForOp));
}

static LogicalResult convertSCFLoopNestToSODALaunch(scf::ForOp forOp) {

  SCFLoopToSodaConverter converter;
  converter.createLaunch(forOp);

  return success();
}

LogicalResult mlir::convertSCFLoopNestToSODALaunch(scf::ForOp forOp) {
  return ::convertSCFLoopNestToSODALaunch(forOp);
}