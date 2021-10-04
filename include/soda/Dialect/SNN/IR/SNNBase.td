//===-- SNNBase.td - SNN dialect definitions ---------------*- tablegen -*-===//
//===----------------------------------------------------------------------===//
//
// Defines the SNN dialect
// 
//===----------------------------------------------------------------------===//

#ifndef SNN_BASE
#define SNN_BASE

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// SNN Dialect.
//===----------------------------------------------------------------------===//

def SNN_Dialect : Dialect {
  let name = "snn";
  let cppNamespace = "::mlir::snn";

  let extraClassDeclaration = [{
  }];

  let description = [{
  }];

  let dependentDialects = ["tensor::TensorDialect"];
}

#endif // SNN_BASE
