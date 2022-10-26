//===- OperationToCGRA.h - Convert Named Operations to CGRA kernels C++ -*-===//
//===----------------------------------------------------------------------===//
#ifndef MLIR_PATTERN_TO_CGRA_H_
#define MLIR_PATTERN_TO_CGRA_H_

#include "mlir/Support/LLVM.h"
#include <string>

namespace mlir {
struct LogicalResult;

class Operation;

/// Convert Operations that match opName into soda.
LogicalResult convertPatternToCGRALaunch(Operation *op, ArrayRef<std::string> patterns);

} // namespace mlir

#endif // MLIR_PATTERN_TO_CGRA_H_
