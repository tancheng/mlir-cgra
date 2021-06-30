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
class DotOp;
class MatmulOp;
class ConvOp;
class GenericOp;
// TODO: add more ops
} // namespace linalg

/// Convert linalg Dot op into soda.
LogicalResult convertLinalgDotToSODALaunch(linalg::DotOp dotOp);

/// Convert linalg Matmul op into soda.
LogicalResult convertLinalgMatmulToSODALaunch(linalg::MatmulOp matmulOp);

/// Convert linalg Conv op into soda.
LogicalResult convertLinalgConvToSODALaunch(linalg::ConvOp convOp);

/// Convert linalg Generic op into soda.
LogicalResult convertLinalgGenericToSODALaunch(linalg::GenericOp genericOp);

} // namespace mlir

#endif // MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODA_H_
