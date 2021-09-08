//===- Tensor.h - Tensor dialect --------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef SODA_DIALECT_SNN_IR_SNN_H_
#define SODA_DIALECT_SNN_IR_SNN_H_

#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/Interfaces/CastInterfaces.h"
#include "mlir/Interfaces/ControlFlowInterfaces.h"
#include "mlir/Interfaces/InferTypeOpInterface.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"
#include "mlir/Interfaces/ViewLikeInterface.h"

//===----------------------------------------------------------------------===//
// SNN Dialect
//===----------------------------------------------------------------------===//

#include "soda/Dialect/SNN/IR/SNNOpsDialect.h.inc"

//===----------------------------------------------------------------------===//
// SNN Dialect Operations
//===----------------------------------------------------------------------===//

#define GET_OP_CLASSES
#include "soda/Dialect/SNN/IR/SNNOps.h.inc"

//===----------------------------------------------------------------------===//
// Tensor Dialect Helpers
//===----------------------------------------------------------------------===//

namespace mlir {
namespace snn {} // namespace snn
} // namespace mlir

#endif // SODA_DIALECT_SNN_IR_SNN_H_
