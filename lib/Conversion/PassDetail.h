//===- PassDetail.h - Conversion Pass class details -------------*- C++ -*-===//
//===----------------------------------------------------------------------===//

#ifndef CONVERSION_PASSDETAIL_H_
#define CONVERSION_PASSDETAIL_H_

#include "mlir/Pass/Pass.h"

#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/FunctionInterfaces.h"

namespace mlir {
class AffineDialect;

// Forward declaration from Dialect.h
template <typename ConcreteDialect>
void registerDialect(DialectRegistry &registry);

namespace func {
class FuncOp;
} // end namespace func

namespace soda {
class SODADialect;
class SODAModuleOp;
} // end namespace soda

namespace scf {
class SCFDialect;
} // end namespace scf

#define GEN_PASS_CLASSES
#include "soda/Conversion/Passes.h.inc"

} // end namespace mlir

#endif // CONVERSION_PASSDETAIL_H_
