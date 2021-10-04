//===- SCFToSODA.h - Convert loop nests to SODA kernels ---------*- C++ -*-===//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_SCFTOSODA_SCFTOSODA_H_
#define MLIR_CONVERSION_SCFTOSODA_SCFTOSODA_H_

#include "mlir/Support/LLVM.h"

namespace mlir {
class AffineForOp;
struct LogicalResult;

namespace scf {
class ForOp;
}

/// Convert a perfect affine loop nest with the outermost loop identified by
/// `forOp` into a soda::Launch operation.
LogicalResult convertAffineLoopNestToSODALaunch(AffineForOp forOp);

/// Convert a scf loop nest with the outermost loop identified by
/// `forOp` into a soda::Launch operation.
LogicalResult convertSCFLoopNestToSODALaunch(scf::ForOp forOp);

} // namespace mlir

#endif // MLIR_CONVERSION_SCFTOSODA_SCFTOSODA_H_
