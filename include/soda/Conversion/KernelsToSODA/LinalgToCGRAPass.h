//===- LinalgToCGRAPass.h - Pass converting loops to CGRA kernels -*- C++ -*-=//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_LINALGTOCGRA_LINALGTOCGRAPASS_H_
#define MLIR_CONVERSION_LINALGTOCGRA_LINALGTOCGRAPASS_H_

#include "mlir/Support/LLVM.h"

#include <memory>

namespace mlir {
namespace func {
class FuncOp;
}
template <typename T>
class OperationPass;
class Pass;

/// Create a pass that converts linalg ops into soda launch ops.
// std::unique_ptr<OperationPass<func::FuncOp>> createLinalgDotToSODAPass();
std::unique_ptr<OperationPass<func::FuncOp>> createLinalgMatmulToCGRAPass();
std::unique_ptr<OperationPass<func::FuncOp>> createLinalgBatchMatmulToCGRAPass();
std::unique_ptr<OperationPass<func::FuncOp>> createLinalgConvToCGRAPass();
std::unique_ptr<OperationPass<func::FuncOp>> createLinalgGenericToCGRAPass();

} // namespace mlir

#endif // MLIR_CONVERSION_LINALGTOCGRA_LINALGTOCGRAPASS_H_
