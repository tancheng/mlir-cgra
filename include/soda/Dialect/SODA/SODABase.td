//===-- SODABase.td - SODA dialect definitions -------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines the SODA dialect
// 
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef SODA_BASE
#define SODA_BASE

include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// SODA Dialect.
//===----------------------------------------------------------------------===//

def SODA_Dialect : Dialect {
  let name = "soda";
  let cppNamespace = "::mlir::soda";
  let hasOperationAttrVerify = 1;

  let extraClassDeclaration = [{
    /// Get the name of the attribute used to annotate the modules that contain
    /// kernel modules.
    static StringRef getContainerModuleAttrName() {
      return "soda.container_module";
    }
    /// Get the name of the attribute used to annotate external kernel
    /// functions.
    static StringRef getKernelFuncAttrName() { return "soda.kernel"; }

    /// Returns whether the given function is a kernel function, i.e., has the
    /// 'soda.kernel' attribute.
    static bool isKernel(Operation *op);

    /// Returns the numeric value used to identify the workgroup memory address
    /// space.
    // TODO: Inherited from the GPU dialect. Maybe it will change in the future.
    static unsigned getWorkgroupAddressSpace() { return 3; }

    /// Returns the numeric value used to identify the private memory address
    /// space.
    static unsigned getPrivateAddressSpace() { return 5; }
  }];
  
  let useDefaultAttributePrinterParser = 1;
  let useDefaultTypePrinterParser = 1;
}

def SODA_AsyncToken : DialectType<
  SODA_Dialect, CPred<"$_self.isa<::mlir::soda::AsyncTokenType>()">, "async token type">,
             BuildableType<"mlir::soda::AsyncTokenType::get($_builder.getContext())">;

def SODA_AsyncOpInterface : OpInterface<"AsyncOpInterface"> {
  let description = [{
    Interface for SODA operations that execute asynchronously on the device.

    SODA operations implementing this interface take a list of dependencies
    as `soda.async.token` arguments and optionally return a `soda.async.token`.

    The op doesn't start executing until all depent ops producing the async
    dependency tokens have finished executing.

    If the op returns a token, the op merely schedules the execution on the
    device and returns immediately, without waiting for the execution to
    complete. On the hand, if the op does not return a token, the op will wait
    for the execution to complete.
  }];
  let cppNamespace = "::mlir::soda";

  let methods = [
    InterfaceMethod<[{
        Query the operands that represent async dependency tokens.
      }],
      "OperandRange", "getAsyncDependencies", (ins), [{}], [{
        ConcreteOp op = cast<ConcreteOp>(this->getOperation());
        return op.asyncDependencies();
      }]
    >,
    InterfaceMethod<[{
        Adds a new token to the list of async dependencies.
      }],
      "void", "addAsyncDependency", (ins "Value":$token),
      [{}], [{
        ::mlir::soda::addAsyncDependency(this->getOperation(), token);
      }]
    >,
    InterfaceMethod<[{
        Query the result that represents the async token to depend on.
      }],
      "OpResult", "getAsyncToken", (ins), [{}], [{
        ConcreteOp op = cast<ConcreteOp>(this->getOperation());
        return op.asyncToken().template dyn_cast_or_null<OpResult>();
      }]
    >
  ];
}

//===----------------------------------------------------------------------===//
// SODA Attributes.
//===----------------------------------------------------------------------===//

class SODA_Attr<string attrName, string attrMnemonic, list<Trait> traits = []>
    : AttrDef<SODA_Dialect, attrName, traits> {
  let mnemonic = attrMnemonic;
}

#endif // SODA_BASE
