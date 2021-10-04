//===- SNNDialect.cpp - MLIR Dialect for SNN Kernels implementation -------===//
//===----------------------------------------------------------------------===//
//
// This file implements the SNN kernel-related dialect and its operations.
//
//===----------------------------------------------------------------------===//

#include "soda/Dialect/SNN/IR/SNN.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"

using namespace mlir;
using namespace mlir::snn;

#include "soda/Dialect/SNN/IR/SNNOpsDialect.cpp.inc"

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