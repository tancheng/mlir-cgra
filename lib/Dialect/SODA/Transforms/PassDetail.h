//===- PassDetail.h - SODA Pass class details -------------------*- C++ -*-===//
//===----------------------------------------------------------------------===//

#ifndef DIALECT_SODA_TRANSFORMS_PASSDETAIL_H_
#define DIALECT_SODA_TRANSFORMS_PASSDETAIL_H_

#include "mlir/Pass/Pass.h"

namespace LLVM {
class LLVMDialect;
} // end namespace LLVM

namespace mlir {

#define GEN_PASS_CLASSES
#include "soda/Dialect/SODA/Passes.h.inc"

} // end namespace mlir

#endif // DIALECT_SODA_TRANSFORMS_PASSDETAIL_H_
