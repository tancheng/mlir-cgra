//===- Passes.h - Pass Entrypoints ------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This header file defines prototypes that expose pass constructors.
// 
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_SODA_PASSES_H_
#define MLIR_DIALECT_SODA_PASSES_H_

#include "mlir/Pass/Pass.h"

namespace mlir {
std::unique_ptr<OperationPass<ModuleOp>> createSodaKernelOutliningPass();

/// Collect a set of patterns to rewrite all-reduce ops within the SODA dialect.
void populateSodaAllReducePatterns(MLIRContext *context,
                                  OwningRewritePatternList &patterns);

/// Collect all patterns to rewrite ops within the SODA dialect.
inline void populateSodaRewritePatterns(MLIRContext *context,
                                       OwningRewritePatternList &patterns) {
  populateSodaAllReducePatterns(context, patterns);
}

//===----------------------------------------------------------------------===//
// Registration
//===----------------------------------------------------------------------===//

/// Generate the code for registering passes.
#define GEN_PASS_REGISTRATION
#include "soda/Dialect/SODA/Passes.h.inc"

} // namespace mlir

#endif // MLIR_DIALECT_SODA_PASSES_H_
