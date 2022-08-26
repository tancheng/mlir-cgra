//===- SCFToSODAPass.h - Pass converting loops to SODA kernels --*- C++ -*-===//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_SCFTOSODA_SCFTOSODAPASS_H_
#define MLIR_CONVERSION_SCFTOSODA_SCFTOSODAPASS_H_

#include "mlir/Support/LLVM.h"

#include <memory>

namespace mlir {
namespace func {
class FuncOp;
}
template <typename T>
class OperationPass;
class Pass;

/// Create a pass that converts loop nests into SODA kernels.  It considers
/// top-level affine.for operations as roots of loop nests and converts them to
/// the soda.launch operations if possible.
std::unique_ptr<OperationPass<func::FuncOp>> createAffineForToSODAPass();

/// Create a pass that converts loop nests into SODA kernels.  It considers
/// top-level scf.for operations as roots of loop nests and converts them to
/// the soda.launch operations if possible.
std::unique_ptr<OperationPass<func::FuncOp>> createSCFForToSODAPass();

} // namespace mlir

#endif // MLIR_CONVERSION_SCFTOSODA_SCFTOSODAPASS_H_
