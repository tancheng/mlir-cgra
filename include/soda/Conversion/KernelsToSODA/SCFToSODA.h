//===- SCFToSODA.h - Convert loop nests to SODA kernels -----------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_SCFTOSODA_SCFTOSODA_H_
#define MLIR_CONVERSION_SCFTOSODA_SCFTOSODA_H_

#include "mlir/Support/LLVM.h"

namespace mlir {
class AffineForOp;
struct LogicalResult;

/// Convert a perfect affine loop nest with the outermost loop identified by
/// `forOp` into a soda::Launch operation.
LogicalResult convertAffineLoopNestToSODALaunch(AffineForOp forOp);

} // namespace mlir

#endif // MLIR_CONVERSION_SCFTOSODA_SCFTOSODA_H_
