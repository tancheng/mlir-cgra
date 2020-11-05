//===- SODADialect.cpp - MLIR Dialect for SODA Kernels implementation -----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA kernel-related dialect and its operations.
// 
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/FunctionImplementation.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/StandardTypes.h"
#include "llvm/ADT/TypeSwitch.h"

using namespace mlir;
using namespace mlir::soda;

//===----------------------------------------------------------------------===//
// SODADialect
//===----------------------------------------------------------------------===//

bool SODADialect::isKernel(Operation *op) {
  UnitAttr isKernelAttr = op->getAttrOfType<UnitAttr>(getKernelFuncAttrName());
  return static_cast<bool>(isKernelAttr);
}

void SODADialect::initialize() {
  addTypes<AsyncTokenType>();
  addOperations<
#define GET_OP_LIST
#include "soda/Dialect/SODA/SODAOps.cpp.inc"
      >();
}

//TODO(NICO): Add implementations
// #include "soda/Dialect/SODA/SODAOpInterfaces.cpp.inc"

// #define GET_OP_CLASSES
// #include "soda/Dialect/SODA/SODAOps.cpp.inc"