//===- PassDetail.h - SODA MISC Pass class details ------------*- C++ //-*-===//
//===----------------------------------------------------------------------===//

#ifndef DIALECT_SODA_MISC_PASSDETAIL_H_
#define DIALECT_SODA_MISC_PASSDETAIL_H_

#include "mlir/Pass/Pass.h"

namespace mlir {

namespace memref {
class MemRefDialect;
} // end namespace memref

namespace vector {
class VectorDialect;
} // end namespace vector

// Needed by the mlir::soda::AffineDataCopyGen - Buffer Trick
#define GEN_PASS_CLASSES
#include "mlir/Dialect/Affine/Passes.h.inc"

} // end namespace mlir

#endif // DIALECT_SODA_MISC_PASSDETAIL_H_
