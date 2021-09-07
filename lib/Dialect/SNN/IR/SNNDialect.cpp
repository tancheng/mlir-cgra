//===- SNNDialect.cpp - MLIR Dialect for SNN Kernels implementation -----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SNN kernel-related dialect and its operations.
//
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#include "mlir/Transforms/InliningUtils.h"
#include "soda/Dialect/SNN/IR/SNN.h"

using namespace mlir;
using namespace mlir::snn;

#include "soda/Dialect/SNN/IR/SNNOpsDialect.cpp.inc"
// #include "mlir/Dialect/Tensor/IR/TensorOpsDialect.cpp.inc"

//===----------------------------------------------------------------------===//
// SNNDialect
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// SNNDialect Methods
//===----------------------------------------------------------------------===//

void SNNDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "soda/Dialect/SNN/IR/SNNOps.cpp.inc"
      >();
}