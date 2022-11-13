//===- LinalgToCGRA.h - Convert Linalg Ops to CGRA kernels ------*- C++ -*-===//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_LINALGTOCGRA_LINALGTOCGRA_H_
#define MLIR_CONVERSION_LINALGTOCGRA_LINALGTOCGRA_H_

#include "mlir/Support/LLVM.h"

namespace mlir {
struct LogicalResult;

namespace linalg {
// class DotOp;
class MatmulOp;
class BatchMatmulOp;
class Conv2DOp;
class GenericOp;
// TODO: add more ops
} // namespace linalg

/// Convert linalg Dot op into soda.
// LogicalResult convertLinalgDotToCGRALaunch(linalg::DotOp dotOp);

/// Convert linalg Matmul op into CGRA.
LogicalResult convertLinalgMatmulToCGRALaunch(linalg::MatmulOp matmulOp);

/// Convert linalg BatchMatmul op into CGRA.
LogicalResult convertLinalgBatchMatmulToCGRALaunch(linalg::BatchMatmulOp batchMatmulOp);

/// Convert linalg Conv op into CGRA.
LogicalResult convertLinalgConvToCGRALaunch(linalg::Conv2DOp convOp);

/// Convert linalg Generic op into CGRA.
LogicalResult convertLinalgGenericToCGRALaunch(linalg::GenericOp genericOp);

} // namespace mlir

#endif // MLIR_CONVERSION_LINALGTOCGRA_LINALGTOCGRA_H_
