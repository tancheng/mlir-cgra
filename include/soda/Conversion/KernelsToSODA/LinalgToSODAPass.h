//===- LinalgToSODAPass.h - Pass converting loops to SODA kernels --*- C++
//-*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODAPASS_H_
#define MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODAPASS_H_

#include "mlir/Support/LLVM.h"

#include <memory>

namespace mlir {
class FuncOp;
template <typename T>
class OperationPass;
class Pass;

/// Create a pass that converts linalg ops into soda launch ops.
std::unique_ptr<OperationPass<FuncOp>> createLinalgDotToSODAPass();
std::unique_ptr<OperationPass<FuncOp>> createLinalgMatmulToSODAPass();
std::unique_ptr<OperationPass<FuncOp>> createLinalgConvToSODAPass();
std::unique_ptr<OperationPass<FuncOp>> createLinalgGenericToSODAPass();

} // namespace mlir

#endif // MLIR_CONVERSION_SCFTOSODA_SCFTOSODAPASS_H_
