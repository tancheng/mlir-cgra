//===-- SNNOps.td - SNN dialect operation definitions ------*- tablegen -*-===//
//===----------------------------------------------------------------------===//
//
// Defines some operations of the SNN dialect.
//
//===----------------------------------------------------------------------===//

#ifndef SNN_OPS
#define SNN_OPS

include "soda/Dialect/SNN/IR/SNNBase.td"
include "soda/Dialect/SNN/IR/SNNTypesBase.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

//===----------------------------------------------------------------------===//
// SNN Dialect operations.
//===----------------------------------------------------------------------===//

class SNN_Op<string mnemonic, list<Trait> traits = []> :
    Op<SNN_Dialect, mnemonic, traits>;

//===----------------------------------------------------------------------===//
// DummyOp
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
  let hasVerifier = 0;
}

//===----------------------------------------------------------------------===//
// EncodeSpikeTrainOp
//===----------------------------------------------------------------------===//

def SNN_EncodeSpikeTrainOp : SNN_Op<"encode_spike_train", [ NoSideEffect
  ]> {
  let summary = "Transform a tensor of times into a spike train";
  let description = [{
    Description...

    Example:

    ```mlir
    // TODO
    ```
  }];

  let arguments = (ins SNN_AnyNumber:$source);
  let results = (outs SNN_AnyNumber:$dest);
  let assemblyFormat = "$source attr-dict `:` type($source) `to` type($dest)";

  let hasCanonicalizer = 1;
  let hasVerifier = 0;
}

#endif // SNN_OPS
