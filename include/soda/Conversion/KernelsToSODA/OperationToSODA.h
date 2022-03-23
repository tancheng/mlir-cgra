//===- OperationToSODA.h - Convert Named Operations to SODA kernels C++ -*-===//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_OPERATIONTOSODA_OPERATIONTOSODA_H_
#define MLIR_CONVERSION_OPERATIONTOSODA_OPERATIONTOSODA_H_

#include "mlir/Support/LLVM.h"

namespace mlir {
struct LogicalResult;

class Operation;

/// Convert Operations that match opName into soda.
LogicalResult convertOperationToSODALaunch(Operation *op);

} // namespace mlir

#endif // MLIR_CONVERSION_OPERATIONTOSODA_OPERATIONTOSODA_H_
