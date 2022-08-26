//===- AllToSODAPass.h - Pass converting function into a SODA kernel  C++ -*-=//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_ALLTOSODA_ALLTOSODAPASS_H_
#define MLIR_CONVERSION_ALLTOSODA_ALLTOSODAPASS_H_

#include "mlir/Support/LLVM.h"

#include <memory>

namespace mlir {
namespace func {
class FuncOp;
}
template <typename T>
class OperationPass;
class Pass;

std::unique_ptr<OperationPass<func::FuncOp>> createAllToSODAPass();

} // namespace mlir

#endif // MLIR_CONVERSION_ALLTOSODA_ALLTOSODAPASS_H_
