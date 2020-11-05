//===- KernelOutlining.cpp - Implementation of SODA kernel outlining ------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA dialect kernel outlining pass.
// 
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#include "PassDetail.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Dialect/SODA/Passes.h"

using namespace mlir;

/// Replace `soda.launch` operations with an `soda.launch_func` operation
/// launching `kernelFunc`. The kernel func contains the body of the
/// `soda.launch` with constant region arguments inlined.
static void convertToLaunchFuncOp(soda::LaunchOp launchOp,
                                  soda::SODAFuncOp kernelFunc,
                                  ValueRange operands) {
  OpBuilder builder(launchOp);
  builder.create<soda::LaunchFuncOp>(
      launchOp.getLoc(), kernelFunc, launchOp.getGridSizeOperandValues(),
      launchOp.getBlockSizeOperandValues(), operands);
  launchOp.erase();
}