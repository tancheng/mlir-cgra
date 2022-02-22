//===- Passes.h - Pass Entrypoints ------------------------------*- C++ -*-===//
//===----------------------------------------------------------------------===//
//
// This header file defines prototypes that expose pass constructors.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_SNN_PASSES_H_
#define MLIR_DIALECT_SNN_PASSES_H_

#include "mlir/Pass/Pass.h"

namespace mlir {
namespace snn {

/// Print ops from the SNN dialect
std::unique_ptr<OperationPass<ModuleOp>> createSNNPrintPass();

/// Collect all patterns to rewrite ops within the SNN dialect.
inline void populateSNNRewritePatterns(MLIRContext *context,
                                       RewritePatternSet &patterns) {
  // populateSodaAllReducePatterns(context, patterns);
}

//===----------------------------------------------------------------------===//
// Registration
//===----------------------------------------------------------------------===//

// Generate the code for registering passes.
#define GEN_PASS_REGISTRATION
#include "soda/Dialect/SNN/Transforms/Passes.h.inc"

} // namespace snn
} // namespace mlir

#endif // MLIR_DIALECT_SNN_PASSES_H_
