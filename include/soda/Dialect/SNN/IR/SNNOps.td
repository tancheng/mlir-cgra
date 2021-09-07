//===-- SNNOps.td - SNN dialect operation definitions ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines some operations of the SNN dialect.
//
//===----------------------------------------------------------------------===//

#ifndef SNN_OPS
#define SNN_OPS

include "soda/Dialect/SNN/IR/SNNBase.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

//===----------------------------------------------------------------------===//
// SNN Dialect operations.
//===----------------------------------------------------------------------===//

class SNN_Op<string mnemonic, list<OpTrait> traits = []> :
    Op<SNN_Dialect, mnemonic, traits> {
  let printer = [{ return ::print(p, *this); }];
  let verifier = [{ return ::verify(*this); }];
  let parser = [{ return ::parse$cppClass(parser, result); }];
}

//===----------------------------------------------------------------------===//
// CastOp
//===----------------------------------------------------------------------===//

def SNN_DummyOp : SNN_Op<"dummy", [ NoSideEffect
  ]> {
  let summary = "snn dummy operation";
  let description = [{
    Description...

    Example:

    ```mlir
    // TODO
    ```
  }];

  let arguments = (ins AnyType:$source);
  let results = (outs AnyType:$dest);
  let assemblyFormat = "$source attr-dict `:` type($source) `to` type($dest)";

  let hasCanonicalizer = 1;
  let verifier = ?;
}

#endif // SNN_OPS
