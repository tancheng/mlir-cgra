//===- LinalgToSODA.h - Convert Linalg Ops to SODA kernels ------*- C++ -*-===//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODA_H_
#define MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODA_H_

#include "mlir/Support/LLVM.h"

namespace mlir {
struct LogicalResult;

namespace linalg {
class DotOp;
class MatmulOp;
class Conv2DOp;
class GenericOp;
// TODO: add more ops
} // namespace linalg

/// Convert linalg Dot op into soda.
LogicalResult convertLinalgDotToSODALaunch(linalg::DotOp dotOp);

/// Convert linalg Matmul op into soda.
LogicalResult convertLinalgMatmulToSODALaunch(linalg::MatmulOp matmulOp);

/// Convert linalg Conv op into soda.
LogicalResult convertLinalgConvToSODALaunch(linalg::Conv2DOp convOp);

/// Convert linalg Generic op into soda.
LogicalResult convertLinalgGenericToSODALaunch(linalg::GenericOp genericOp);

} // namespace mlir

#endif // MLIR_CONVERSION_LINALGTOSODA_LINALGTOSODA_H_
