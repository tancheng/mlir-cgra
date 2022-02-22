//===- Passes.h - Pass Entrypoints ------------------------------*- C++ -*-===//
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
namespace soda {

/// Replaces `soda.launch` with `soda.launch_func` by moving the region into a
/// separate kernel function.
std::unique_ptr<OperationPass<ModuleOp>> createSodaKernelOutliningPass();

/// Extract code called by `soda.launch_func` into isolated mlir module/file,
/// with no host code information. This file can be later lowered and consumed
/// by bambu
std::unique_ptr<OperationPass<ModuleOp>> createSodaKernelGenerationPass();

/// Transform `soda.launch_func` into calls to the bambu accelerator API
void populateHostGenerationConversionPatterns(RewritePatternSet &patterns);
std::unique_ptr<Pass> createSodaHostGenerationPass();

/// Rewrites a function region so that SODA ops execute async.
std::unique_ptr<OperationPass<FuncOp>> createSodaAsyncRegionPass();

/// Collect all patterns to rewrite ops within the SODA dialect.
inline void populateSodaRewritePatterns(MLIRContext *context,
                                        RewritePatternSet &patterns) {
  // populateSodaAllReducePatterns(context, patterns);
}

//===----------------------------------------------------------------------===//
// Registration
//===----------------------------------------------------------------------===//

/// Generate the code for registering passes.
#define GEN_PASS_REGISTRATION
#include "soda/Dialect/SODA/Passes.h.inc"

} // namespace soda
} // namespace mlir

#endif // MLIR_DIALECT_SODA_PASSES_H_
