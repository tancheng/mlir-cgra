//===- Passes.h - Pass Entrypoints ------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This header file defines utility functions exposed by the SODA dialect
// 
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_SODA_UTILS_H_
#define MLIR_DIALECT_SODA_UTILS_H_

#include "mlir/Support/LLVM.h"

namespace mlir {
struct LogicalResult;
class Value;

namespace soda {
class SODAFuncOp;
class LaunchOp;
} // namespace soda

/// Get a soda.func created from outlining the region of a soda.launch op with the
/// given `kernelFnName`. The region of the `launchOp` can use values from
/// above. These need to be captured and passed as arguments to the generated
/// soda.func. The generated function has arguments
/// - corresponding to the values passed in as `operands`, in that order.
/// - any additional values that might be used within the region of the
///   `launchOp` and defined above it. These captured values are appended to the
///   `operands` list.
soda::SODAFuncOp outlineKernelFunc(soda::LaunchOp launchOp, StringRef kernelFnName,
                                 SmallVectorImpl<Value> &operands);

/// Sink operations into the `launchOp` to reduce the number of values that are
/// used within the region of the operation, but defined outside of the
/// region.
LogicalResult sinkOperationsIntoLaunchOp(soda::LaunchOp launchOp);

} // namespace mlir
#endif // MLIR_DIALECT_SODA_UTILS_H_
