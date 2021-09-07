//===-- SNNBase.td - SNN dialect definitions -------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
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
}

#endif // SNN_BASE
