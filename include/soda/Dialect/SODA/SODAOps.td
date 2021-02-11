//===-- SODAOps.td - SODA dialect operation definitions ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines some operations of the SODA dialect.
//
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef SODA_OPS
#define SODA_OPS

include "soda/Dialect/SODA/SODABase.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

//===----------------------------------------------------------------------===//
// SODA Dialect operations.
//===----------------------------------------------------------------------===//

class SODA_Op<string mnemonic, list<OpTrait> traits = []> :
    Op<SODA_Dialect, mnemonic, traits>;

class SODA_IndexOp<string mnemonic, list<OpTrait> traits = []> :
    SODA_Op<mnemonic, !listconcat(traits, [NoSideEffect])>,
    Arguments<(ins StrAttr:$dimension)>, Results<(outs Index)> {
  let verifier = [{ return ::verifyIndexOp(*this); }];
}


def SODA_SODAFuncOp : SODA_Op<"func", [HasParent<"SODAModuleOp">,
                                    AutomaticAllocationScope, FunctionLike,
                                    IsolatedFromAbove, Symbol]> {
  let summary = "Function executable on a SODA enabled architecture";

  let description = [{
    Defines a function that can be executed on a SODA enabled architecture.
    This supports memory attribution and its body has a particular execution
    model.

    SODA functions are either kernels (as indicated by the `kernel` attribute) or
    regular functions. The former can be launched from the host side, while the
    latter are device side only.

    The memory attribution defines SSA values that correspond to memory buffers
    allocated in the memory hierarchy of the SODA (see below).

    The operation has one attached region that corresponds to the body of the
    function. The region arguments consist of the function arguments without
    modification, followed by buffers defined in memory annotations.
    Declarations of SODA functions, i.e. not having the
    body region, are not supported.

    Syntax:

    ```
    op ::= `soda.func` symbol-ref-id `(` argument-list `)` (`->`
    function-result-list)?
           memory-attribution `kernel`? function-attributes? region

    memory-attribution ::= (`workgroup` `(` ssa-id-and-type-list `)`)?
                           (`private` `(` ssa-id-and-type-list `)`)?
    ```

    Example:

    ```mlir
    soda.func @foo(%arg0: index)
        workgroup(%workgroup: memref<32xf32, 3>)
        private(%private: memref<1xf32, 5>)
        kernel
        attributes {qux: "quux"} {
      soda.return
    }
    ```

    The generic form illustrates the concept

    ```mlir
    "soda.func"(%arg: index) {sym_name: "foo", kernel, qux: "quux"} ({
    ^bb0(%arg0: index, %workgroup: memref<32xf32, 3>,
         %private: memref<1xf32, 5>):
      "soda.return"() : () -> ()
    }) : (index) -> ()
    ```

    Note the non-default memory spaces used in memref types in memory
    attribution.
  }];

  let regions = (region AnyRegion:$body);

  let skipDefaultBuilders = 1;

  let builders = [
    OpBuilderDAG<(ins "StringRef":$name, "FunctionType":$type,
      CArg<"TypeRange", "{}">:$workgroupAttributions,
      CArg<"TypeRange", "{}">:$privateAttributions,
      CArg<"ArrayRef<NamedAttribute>", "{}">:$attrs)>
  ];

  let extraClassDeclaration = [{
    /// Returns `true` if the SODA function defined by this Op is a kernel, i.e.
    /// it is intended to be launched from host.
    bool isKernel() {
      return (*this)->getAttrOfType<UnitAttr>(SODADialect::getKernelFuncAttrName()) !=
             nullptr;
    }

    /// Change the type of this function in place. This is an extremely
    /// dangerous operation and it is up to the caller to ensure that this is
    /// legal for this function, and to restore invariants:
    ///  - the entry block args must be updated to match the function params.
    ///  - the argument/result attributes may need an update: if the new type
    ///  has less parameters we drop the extra attributes, if there are more
    ///  parameters they won't have any attributes.
    // TODO: consider removing this function thanks to rewrite patterns.
    void setType(FunctionType newType);

    /// Returns the number of buffers located in the workgroup memory.
    unsigned getNumWorkgroupAttributions() {
      return (*this)->getAttrOfType<IntegerAttr>(getNumWorkgroupAttributionsAttrName())
          .getInt();
    }

    /// Returns a list of block arguments that correspond to buffers located in
    /// the workgroup memory
    ArrayRef<BlockArgument> getWorkgroupAttributions() {
      auto begin =
          std::next(getBody().args_begin(), getType().getNumInputs());
      auto end = std::next(begin, getNumWorkgroupAttributions());
      return {begin, end};
    }

    /// Adds a new block argument that corresponds to buffers located in
    /// workgroup memory.
    BlockArgument addWorkgroupAttribution(Type type);

    /// Returns the number of buffers located in the private memory.
    unsigned getNumPrivateAttributions() {
      return getBody().getNumArguments() - getType().getNumInputs() -
          getNumWorkgroupAttributions();
    }

    /// Returns a list of block arguments that correspond to buffers located in
    /// the private memory.
    ArrayRef<BlockArgument> getPrivateAttributions() {
      // Buffers on the private memory always come after buffers on the workgroup
      // memory.
      auto begin =
          std::next(getBody().args_begin(),
                    getType().getNumInputs() + getNumWorkgroupAttributions());
      return {begin, getBody().args_end()};
    }

    /// Adds a new block argument that corresponds to buffers located in
    /// private memory.
    BlockArgument addPrivateAttribution(Type type);

    /// Returns the name of the attribute containing the number of buffers
    /// located in the workgroup memory.
    static StringRef getNumWorkgroupAttributionsAttrName() {
      return "workgroup_attributions";
    }

    // FunctionLike trait needs access to the functions below.
    friend class OpTrait::FunctionLike<SODAFuncOp>;

    /// Hooks for the input/output type enumeration in FunctionLike .
    unsigned getNumFuncArguments() { return getType().getNumInputs(); }
    unsigned getNumFuncResults() { return getType().getNumResults(); }

    /// Returns the keywords used in the custom syntax for this Op.
    static StringRef getWorkgroupKeyword() { return "workgroup"; }
    static StringRef getPrivateKeyword() { return "private"; }
    static StringRef getKernelKeyword() { return "kernel"; }

    /// Hook for FunctionLike verifier.
    LogicalResult verifyType();

    /// Verifies the body of the function.
    LogicalResult verifyBody();
  }];

  // let verifier = [{ return ::verifFuncOpy(*this); }];
  let printer = [{ printSODAFuncOp(p, *this); }];
  let parser = [{ return parseSODAFuncOp(parser, result); }];
}

def SODA_LaunchFuncOp : SODA_Op<"launch_func", [SODA_AsyncOpInterface,
                                                AttrSizedOperandSegments]>,
    Arguments<(ins Variadic<SODA_AsyncToken>:$asyncDependencies,
                   SymbolRefAttr:$kernel,
                   Variadic<AnyType>:$operands)>,
    Results<(outs Optional<SODA_AsyncToken>:$asyncToken)> {
  let summary = "Launches a function as a SODA kernel";

  let description = [{
    Launch a kernel function.
    `soda.launch` operations are lowered to `soda.launch_func` operations by
    outlining the kernel body into a function in a dedicated module, which
    reflects the separate compilation process. The kernel function is required
    to have the `soda.kernel` attribute. The module containing the kernel
    function is required to be a soda.module. And finally, the module containing
    the kernel module (which thus cannot be the top-level module) is required
    to have the `soda.container_module` attribute. The `soda.launch_func`
    operation has a symbol attribute named `kernel` to identify the fully 
    specified kernel function to launch (both the soda.module and func).

    The `gpu.launch_func` supports async dependencies: the kernel does not
    start executing until the ops that produce those async dependencies have
    completed.

    By the default, the host implicitly blocks until kernel execution has
    completed. If the `async` keyword is present, the host does not block but
    instead a `!gpu.async.token` is returned. Other async GPU ops can take this
    token as dependency.
    
    During outlining transformation, any variables needed by the kernel
    function, that were created outside of the `soda.launch` operation are
    transformed into arguments of the kernel function.

    Example:

    ```mlir
    module attributes {soda.container_module} {

      // This module creates a separate compilation unit for the SODA optimizer.
      soda.module @kernels {
        func @kernel_1(%arg0 : f32, %arg1 : memref<?xf32, 1>)
            attributes { nvvm.kernel = true } {

          %idx0 = constant 1 : index
          %idx1 = constant 2 : index
          "some_op"(%idx0, idx1) : (index, index) -> ()
          %42 = load %arg1[idx0] : memref<?xf32, 1>
        }
      }

      soda.launch_func
          @kernels::@kernel_1                          // Kernel function.
          args(%arg0 : f32, %arg1 : memref<?xf32, 1>)  // Kernel arguments.
      
      %t0 = soda.wait async
      soda.launch_func
          async                           // (Optional) Don't block host, return token.
          [%t0]                           // (Optional) Execute only after %t0 has completed.
          @kernels::@kernel_1             // Kernel function.
          args(%arg0 : f32,               // (Optional) Kernel arguments.
               %arg1 : memref<?xf32, 1>)
    }
    ```
  }];

  let skipDefaultBuilders = 1;

  let builders = [
    OpBuilderDAG<(ins "SODAFuncOp":$kernelFunc, "ValueRange":$kernelOperands)>
  ];

  let extraClassDeclaration = [{
    /// The number of operands passed to the kernel function.
    unsigned getNumKernelOperands();

    /// The name of the kernel's containing module.
    StringRef getKernelModuleName();

    /// The name of the kernel.
    StringRef getKernelName();

    /// The i-th operand passed to the kernel function.
    Value getKernelOperand(unsigned i);

    /// The number of launch configuration operands, placed at the leading
    /// positions of the operand list.
    /// Parameter inherited from GPU dialect.
    static constexpr unsigned kNumConfigOperands = 0;

    // This needs to quietly verify if attributes with names defined below are
    // present since it is run before the verifier of this op.
    friend LogicalResult SODADialect::verifyOperationAttribute(Operation *,
                                                              NamedAttribute);

    /// The name of the symbol reference attribute specifying the kernel to launch.
    static StringRef getKernelAttrName() { return "kernel"; }
  }];

  let verifier = [{ return ::verify(*this); }];
  let assemblyFormat = [{
      custom<AsyncDependencies>(type($asyncToken), $asyncDependencies)
      $kernel
      custom<LaunchFuncOperands>($operands, type($operands))
      attr-dict
  }];
}

def SODA_LaunchOp : SODA_Op<"launch">,
    Arguments<(ins)>,
    Results<(outs)> {
  let summary = "SODA kernel launch operation";

  let description = [{
    Launch a kernel. The body of the kernel is defined by the single region
    that this operation contains.

    Syntax:

    ```
    operation ::= `soda.launch` region attr-dict?
    ssa-reassignment ::= `(` ssa-id `=` ssa-use (`,` ssa-id `=` ssa-use)* `)`
    ```

    Example:

    // TODO

    ```mlir
    soda.launch {
      "some_op"(%bx, %tx) : (index, index) -> ()
      // Assuming %val1 is defined outside the soda.launch region.
      %42 = load %val1[%bx] : memref<?xf32, 1>
    }
    ```

  }];

  let regions = (region AnyRegion:$body);

  let skipDefaultBuilders = 1;

  let builders = [
    OpBuilderDAG<(ins)>
  ];
  
  let extraClassDeclaration = [{

    /// The number of launch configuration operands, placed at the leading
    /// positions of the operand list.
    /// Legacy from copying GPU dialect.
    static constexpr unsigned kNumConfigOperands = 0;

    /// The number of region attributes containing the launch configuration,
    /// placed in the leading positions of the argument list.
    /// Legacy from copying GPU dialect.
    static constexpr unsigned kNumConfigRegionAttributes = 0;
  }];

  let parser = [{ return parseLaunchOp(parser, result); }];
  let printer = [{ printLaunchOp(p, *this); }];
  let verifier = [{ return ::verify(*this); }];
}

def SODA_ReturnOp : SODA_Op<"return", [HasParent<"SODAFuncOp">, NoSideEffect,
                                     Terminator]>,
    Arguments<(ins Variadic<AnyType>:$operands)>, Results<(outs)> {
  let summary = "Terminator for SODA functions.";
  let description = [{
    A terminator operation for regions that appear in the body of  `soda.func`
    functions. The operands to the `soda.return` are the result values returned
    by an invocation of the `soda.func`.
  }];

  let builders = [OpBuilderDAG<(ins), [{ // empty}]>];

  let parser = [{ return parseReturnOp(parser, result); }];
  let printer = [{ p << getOperationName(); }];
  let verifier = [{ return ::verify(*this); }];
}

def SODA_TerminatorOp : SODA_Op<"terminator", [HasParent<"LaunchOp">,
                                             NoSideEffect, Terminator]>,
    Arguments<(ins)>, Results<(outs)> {
  let summary = "Terminator for SODA launch regions.";
  let description = [{
    A terminator operation for regions that appear in the body of `soda.launch`
    operation.  These regions are not expected to return any value so the
    terminator takes no operands.
  }];

  let parser = [{ return success(); }];
  let printer = [{ p << getOperationName(); }];
}

def SODA_YieldOp : SODA_Op<"yield", [NoSideEffect, Terminator]>,
    Arguments<(ins Variadic<AnyType>:$values)> {
  let summary = "SODA yield operation";
  let description = [{
    soda.yield` is a special terminator operation for blocks inside regions
    in soda ops. It returns values to the immediately enclosing soda op.

    Example:

    ```mlir
    soda.yield %f0, %f1 : f32, f32
    ```
  }];
}



def SODA_BarrierOp : SODA_Op<"barrier"> {
  let summary = "Synchronizes all work items of a workgroup.";
  let description = [{
    TODO: Inherited from the GPU dialect. Maybe it will change in the future.

    The "barrier" op synchronizes all work items of a workgroup. It is used
    to coordinate communication between the work items of the workgroup.

    ```mlir
    soda.barrier
    ```

    waits until all work items in the workgroup have reached this point
    and all memory accesses made by these work items prior to the op are
    visible to all work items in the workgroup. Data hazards between work items
    accessing the same memory can be avoided by synchronizing work items
    in-between these accesses.

    Either none or all work items of a workgroup need to execute this op
    in convergence.
  }];
  let parser = [{ return success(); }];
  let printer = [{ p << getOperationName(); }];
}


def SODA_SODAModuleOp : SODA_Op<"module", [
  IsolatedFromAbove, SymbolTable, Symbol,
  SingleBlockImplicitTerminator<"ModuleEndOp">
]> {
  let summary = "A top level compilation unit to be run on a SODA enabled device.";
  let description = [{
    SODA module contains code that is intended to be run on a SODA enabled
    device. A host device can launch this code through a soda.launc_func that
    creates a fully qualified symbol through the soda.module's symbol and a
    soda.func symbol contained in the soda.module.

    The module's top-level scope is modeled by a single region with a single
    block. SODA modules are required to have a name that is used for symbol
    resolution by the soda.launch_func operation.
    
    Using an op with a region to define a SODA module enables "embedding" SODA
    modules with SIMT execution models in other dialects in a clean manner and
    allows filtering of code regions to execute passes on only code intended to
    or not intended to be run on the separate device.

    ```
      soda.module @symbol_name {
      soda.func {}
        ...
      soda.module_end
    }

    ```
  }];
  let builders = [OpBuilderDAG<(ins "StringRef":$name)>];
  let parser = [{ return ::parseSODAModuleOp(parser, result); }];
  let printer = [{ return ::print(p, *this); }];
  let regions = (region SizedRegion<1>:$body);

  // We need to ensure the block inside the region is properly terminated;
  // the auto-generated builders do not guarantee that.
  let skipDefaultBuilders = 1;
}

def SODA_ModuleEndOp : SODA_Op<"module_end", [
  Terminator, HasParent<"SODAModuleOp">
]> {
  let summary = "A pseudo op that marks the end of a soda.module.";
  let description = [{
    This op terminates the only block inside the only region of a `soda.module`.
  }];

  let parser = [{ return success(); }];
  let printer = [{ p << getOperationName(); }];
}

def SODA_HostRegisterOp : SODA_Op<"host_register">,
    Arguments<(ins AnyUnrankedMemRef:$value)> {
  let summary = "Registers a memref for access from device.";
  let description = [{
    TODO: Inherited from the GPU dialect. Maybe it will change in the future.

    This op maps the provided host buffer into the device address space.

    This operation may not be supported in every environment, there is not yet a
    way to check at runtime whether this feature is supported.

    Writes from the host are guaranteed to be visible to device kernels that are
    launched afterwards. Writes from the device are guaranteed to be visible on
    the host after synchronizing with the device kernel completion.
  }];

  let assemblyFormat = "$value attr-dict `:` type($value)";
  let verifier = [{ return success(); }];
}

def SODA_WaitOp : SODA_Op<"wait", [SODA_AsyncOpInterface]> {
  let summary = "Wait for async soda ops to complete.";
  let description = [{
    TODO: Inherited from the GPU dialect. Maybe it will change in the future.

    This op synchronizes the host or the device with a list of dependent ops.

    If the op contains the `async` keyword, it returns a new async token which
    is synchronized with the op arguments. This new token is merely a shortcut
    to the argument list, and one could replace the uses of the result with the
    arguments for the same effect. The async version of this op is primarily
    used to make each async token have a single use during lowering and
    thereby make forks in async execution explicit. Example usage:

    ```mlir
    %t0 = soda.foo async : !soda.async.token
    %t1 = soda.bar async : !soda.async.token
    %t2 = soda.wait async [%t0, %t1]
    // soda.baz doesn't run until soda.foo and soda.bar have both completed,
    // just as if the async dependencies were [%t0, %t1].
    %t3 = soda.baz async [%t2]
    ```

    If the op does not contain the `async` keyword, it does not return a new
    async token but blocks until all ops producing the async dependency tokens
    finished execution. All dependent memory operations are visible to the host
    once this op completes. Example usage:

    ```mlir
    %t0 = soda.foo async : !soda.async.token
    %t1 = soda.bar async : !soda.async.token
    // The soda.wait op blocks until soda.foo and soda.bar have completed.
    soda.wait [%t0, %t1]
    ```
  }];

  let arguments = (ins Variadic<SODA_AsyncToken>:$asyncDependencies);
  let results = (outs Optional<SODA_AsyncToken>:$asyncToken);

  let assemblyFormat = [{
    custom<AsyncDependencies>(type($asyncToken), $asyncDependencies) attr-dict
  }];
}

#endif // SODA_OPS
