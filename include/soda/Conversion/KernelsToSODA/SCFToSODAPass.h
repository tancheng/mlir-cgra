//===- SCFToSODAPass.h - Pass converting loops to SODA kernels ----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_SCFTOSODA_SCFTOSODAPASS_H_
#define MLIR_CONVERSION_SCFTOSODA_SCFTOSODAPASS_H_

#include "mlir/Support/LLVM.h"

#include <memory>

namespace mlir {
class FuncOp;
template <typename T>
class OperationPass;
class Pass;

/// Create a pass that converts loop nests into SODA kernels.  It considers
/// top-level affine.for operations as roots of loop nests and converts them to
/// the soda.launch operations if possible.
///
/// No check on the size of the block or grid, or on the validity of
/// parallelization is performed, it is under the responsibility of the caller
/// to strip-mine the loops and to perform the dependence analysis before
/// calling the conversion.
std::unique_ptr<OperationPass<FuncOp>>
createAffineForToSODAPass(unsigned numBlockDims, unsigned numThreadDims);
std::unique_ptr<OperationPass<FuncOp>> createAffineForToSODAPass();

/// Creates a pass that converts scf.parallel operations into a soda.launch
/// operation. The mapping of loop dimensions to launch dimensions is derived
/// from mapping attributes. See ParallelToSodaLaunchLowering::matchAndRewrite
/// for a description of the used attributes.
std::unique_ptr<Pass> createParallelLoopToSodaPass();

} // namespace mlir

#endif // MLIR_CONVERSION_SCFTOSODA_SCFTOSODAPASS_H_
