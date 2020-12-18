//===- LinalgToSODA.h - Convert Linalg Ops to SODA kernels ------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODA_H_
#define MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODA_H_

#include "mlir/Support/LLVM.h"

namespace mlir {
struct LogicalResult;

namespace linalg {
class MatmulOp;
// TODO: add more ops
// class ConvOp;
} // namespace linalg

/// Convert linalg Matmul op into soda.
LogicalResult convertLinalgMatmulToSODALaunch(linalg::MatmulOp matmulOp);

} // namespace mlir

#endif // MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODA_H_
