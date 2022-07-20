//===- OperationToSODAPass.h - Pass converting loops to SODA kernels  C++ -*-=//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_OPERATIONTOSODA_OPERATIONTOSODAPASS_H_
#define MLIR_CONVERSION_OPERATIONTOSODA_OPERATIONTOSODAPASS_H_

#include "mlir/Support/LLVM.h"

#include <memory>

namespace mlir {
namespace func {
class FuncOp;
}
template <typename T>
class OperationPass;
class Pass;

std::unique_ptr<OperationPass<func::FuncOp>> createOperationToSODAPass();

} // namespace mlir

#endif // MLIR_CONVERSION_OPERATIONTOSODA_OPERATIONTOSODAPASS_H_
