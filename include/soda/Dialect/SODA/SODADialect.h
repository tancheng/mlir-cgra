//===- SODADialect.h - MLIR Dialect for SODA Kernels ------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the SODA kernel-related operations and puts them in the
// corresponding dialect.
//
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef SODA_DIALECT_SODA_SODADIALECT_H
#define SODA_DIALECT_SODA_SODADIALECT_H

#include "mlir/IR/Builders.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/FunctionInterfaces.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

namespace mlir {
namespace soda {

// TODO Remove
/// Utility class for the SODA dialect to represent triples of `Value`s
/// accessible through `.x`, `.y`, and `.z` similarly to CUDA notation.
struct KernelDim3 {
  Value x;
  Value y;
  Value z;
};

class AsyncTokenType
    : public Type::TypeBase<AsyncTokenType, Type, TypeStorage> {
public:
  // Used for generic hooks in TypeBase.
  using Base::Base;
};

// Adds a `soda.async.token` to the front of the argument list.
void addAsyncDependency(Operation *op, Value token);

} // end namespace soda
} // end namespace mlir

#include "soda/Dialect/SODA/SODAOpsEnums.h.inc"

#include "soda/Dialect/SODA/SODAOpsDialect.h.inc"

#include "soda/Dialect/SODA/SODAOpInterfaces.h.inc"

#define GET_ATTRDEF_CLASSES
#include "soda/Dialect/SODA/SODAOpsAttributes.h.inc"

#define GET_OP_CLASSES
#include "soda/Dialect/SODA/SODAOps.h.inc"

#endif // SODA_DIALECT_SODA_SODADIALECT_H
