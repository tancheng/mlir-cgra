//===- PassDetail.h - SNN Pass class details --------------------*- C++ -*-===//
//===----------------------------------------------------------------------===//

#ifndef DIALECT_TENSOR_TRANSFORMS_PASSDETAIL_H_
#define DIALECT_TENSOR_TRANSFORMS_PASSDETAIL_H_

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"

namespace mlir {

namespace Tensor {
class TensorDialect;
} // namespace Tensor

#define GEN_PASS_CLASSES
#include "soda/Dialect/SNN/Transforms/Passes.h.inc"

} // end namespace mlir

#endif // DIALECT_TENSOR_TRANSFORMS_PASSDETAIL_H_
