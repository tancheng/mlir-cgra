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

def SODA_BlockDimOp : SODA_IndexOp<"block_dim"> {
  let description = [{
    Returns the number of threads in the thread block (aka the block size) along
    the x, y, or z `dimension`.

    Example:

    ```mlir
    %bDimX = "soda.block_dim"() {dimension = "x"} : () -> (index)
    ```
  }];
}
def SODA_BlockIdOp : SODA_IndexOp<"block_id"> {
  let description = [{
    Returns the block id, i.e. the index of the current block within the grid
    along the x, y, or z `dimension`.

    Example:

    ```mlir
    %bIdY = "soda.block_id"() {dimension = "y"} : () -> (index)
    ```
  }];
}
def SODA_GridDimOp : SODA_IndexOp<"grid_dim"> {
  let description = [{
    Returns the number of thread blocks in the grid along the x, y, or z
    `dimension`.

    Example:

    ```mlir
    %gDimZ = "soda.grid_dim"() {dimension = "z"} : () -> (index)
    ```
  }];
}
def SODA_ThreadIdOp : SODA_IndexOp<"thread_id"> {
  let description = [{
    Returns the thread id, i.e. the index of the current thread within the block
    along the x, y, or z `dimension`.

    Example:

    ```mlir
    %tIdX = "soda.thread_id"() {dimension = "x"} : () -> (index)
    ```
  }];
}

def SODA_SubgroupIdOp : SODA_Op<"subgroup_id", [NoSideEffect]>,
    Arguments<(ins)>, Results<(outs Index:$result)> {
  let description = [{
    Returns the subgroup id, i.e. the index of the current subgroup within the
    workgroup.

    Example:

    ```mlir
    %sgId = soda.subgroup_id : index
    ```
  }];

  let assemblyFormat = "attr-dict `:` type($result)";
  let verifier = [{ return success(); }];
}

def SODA_NumSubgroupsOp : SODA_Op<"num_subgroups", [NoSideEffect]>,
    Arguments<(ins)>, Results<(outs Index:$result)> {
  let description = [{
    Returns the number of subgroups within a workgroup.

    Example:

    ```mlir
    %numSg = soda.num_subgroups : index
    ```
  }];

  let assemblyFormat = "attr-dict `:` type($result)";
  let verifier = [{ return success(); }];
}

def SODA_SubgroupSizeOp : SODA_Op<"subgroup_size", [NoSideEffect]>,
    Arguments<(ins)>, Results<(outs Index:$result)> {
  let description = [{
    Returns the number of threads within a subgroup.

    Example:

    ```mlir
    %sgSz = soda.subgroup_size : index
    ```
  }];

  let assemblyFormat = "attr-dict `:` type($result)";
  let verifier = [{ return success(); }];
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
    modification, followed by buffers defined in memory annotations. The body of
    a SODA function, when launched, is executed by multiple work items. There are
    no guarantees on the order in which work items execute, or on the connection
    between them. In particular, work items are not necessarily executed in
    lock-step. Synchronization ops such as "soda.barrier" should be used to
    coordinate work items. Declarations of SODA functions, i.e. not having the
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
      return getAttrOfType<UnitAttr>(SODADialect::getKernelFuncAttrName()) !=
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
      return getAttrOfType<IntegerAttr>(getNumWorkgroupAttributionsAttrName())
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

def SODA_LaunchFuncOp : SODA_Op<"launch_func">,
    Arguments<(ins SymbolRefAttr:$kernel,
               Index:$gridSizeX, Index:$gridSizeY, Index:$gridSizeZ,
               Index:$blockSizeX, Index:$blockSizeY, Index:$blockSizeZ,
               Variadic<AnyType>:$operands)>,
    Results<(outs)> {
  let summary = "Launches a function as a SODA kernel";

  let description = [{
    Launch a kernel function on the specified grid of thread blocks.
    `soda.launch` operations are lowered to `soda.launch_func` operations by
    outlining the kernel body into a function in a dedicated module, which
    reflects the separate compilation process. The kernel function is required
    to have the `soda.kernel` attribute. The module containing the kernel
    function is required to be a soda.module. And finally, the module containing
    the kernel module (which thus cannot be the top-level module) is required
    to have the `soda.container_module` attribute. The `soda.launch_func`
    operation has a symbol attribute named `kernel` to identify the fully 
    specified kernel function to launch (both the soda.module and func).

    The operation takes at least six operands, with the first three operands
    being grid sizes along x,y,z dimensions and the following three being block
    sizes along x,y,z dimensions. When a lower-dimensional kernel is required,
    unused sizes must be explicitly set to `1`. The remaining operands are
    passed as arguments to the kernel function.

    Example:

    ```mlir
    module attributes {soda.container_module} {

      // This module creates a separate compilation unit for the SODA optimizer.
      soda.module @kernels {
        func @kernel_1(%arg0 : f32, %arg1 : memref<?xf32, 1>)
            attributes { nvvm.kernel = true } {

          // Operations that produce block/thread IDs and dimensions are
          // injected when outlining the `soda.launch` body to a function called
          // by `soda.launch_func`.
          %tIdX = "soda.thread_id"() {dimension = "x"} : () -> (index)
          %tIdY = "soda.thread_id"() {dimension = "y"} : () -> (index)
          %tIdZ = "soda.thread_id"() {dimension = "z"} : () -> (index)

          %bDimX = "soda.block_dim"() {dimension = "x"} : () -> (index)
          %bDimY = "soda.block_dim"() {dimension = "y"} : () -> (index)
          %bDimZ = "soda.block_dim"() {dimension = "z"} : () -> (index)

          %bIdX = "soda.block_id"() {dimension = "x"} : () -> (index)
          %bIdY = "soda.block_id"() {dimension = "y"} : () -> (index)
          %bIdZ = "soda.block_id"() {dimension = "z"} : () -> (index)

          %gDimX = "soda.grid_dim"() {dimension = "x"} : () -> (index)
          %gDimY = "soda.grid_dim"() {dimension = "y"} : () -> (index)
          %gDimZ = "soda.grid_dim"() {dimension = "z"} : () -> (index)

          "some_op"(%bx, %tx) : (index, index) -> ()
          %42 = load %arg1[%bx] : memref<?xf32, 1>
        }
      }

      soda.launch_func
          @kernels::@kernel_1                          // Kernel function.
          blocks in (%cst, %cst, %cst)                 // Grid size.
          threads in (%cst, %cst, %cst)                // Block size.
          args(%arg0 : f32, %arg1 : memref<?xf32, 1>)  // Kernel arguments.
    }
    ```
  }];

  let skipDefaultBuilders = 1;

  let builders = [
    OpBuilderDAG<(ins "SODAFuncOp":$kernelFunc, "KernelDim3":$gridSize,
      "KernelDim3":$blockSize, "ValueRange":$kernelOperands)>
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

    /// Get the SSA values passed as operands to specify the grid size.
    KernelDim3 getGridSizeOperandValues();

    /// Get the SSA values passed as operands to specify the block size.
    KernelDim3 getBlockSizeOperandValues();

    /// The number of launch configuration operands, placed at the leading
    /// positions of the operand list.
    static constexpr unsigned kNumConfigOperands = 6;

    // This needs to quietly verify if attributes with names defined below are
    // present since it is run before the verifier of this op.
    friend LogicalResult SODADialect::verifyOperationAttribute(Operation *,
                                                              NamedAttribute);

    /// The name of the symbol reference attribute specifying the kernel to launch.
    static StringRef getKernelAttrName() { return "kernel"; }
  }];

  let verifier = [{ return ::verify(*this); }];
  let assemblyFormat = [{
      $kernel
      `blocks` `in` ` ` `(`$gridSizeX`,` $gridSizeY`,` $gridSizeZ`)`
      `threads` `in` ` ` `(`$blockSizeX`,` $blockSizeY`,` $blockSizeZ`)`
      custom<LaunchFuncOperands>($operands, type($operands))
      attr-dict
  }];
}

def SODA_LaunchOp : SODA_Op<"launch">,
    Arguments<(ins Index:$gridSizeX, Index:$gridSizeY, Index:$gridSizeZ,
               Index:$blockSizeX, Index:$blockSizeY, Index:$blockSizeZ)>,
    Results<(outs)> {
  let summary = "SODA kernel launch operation";

  let description = [{
    Launch a kernel on the specified grid of thread blocks. The body of the
    kernel is defined by the single region that this operation contains. The
    operation takes six operands, with first three operands being grid sizes
    along x,y,z dimensions and the following three arguments being block sizes
    along x,y,z dimension. When a lower-dimensional kernel is required,
    unused sizes must be explicitly set to `1`.

    The body region has _twelve_ arguments, grouped as follows:

    -   three arguments that contain block identifiers along x,y,z dimensions;
    -   three arguments that contain thread identifiers along x,y,z dimensions;
    -   operands of the `soda.launch` operation as is (i.e. the operands for
        grid and block sizes).

    Syntax:

    ```
    operation ::= `soda.launch` `block` `(` ssa-id-list `)` `in` ssa-reassignment
                             `threads` `(` ssa-id-list `)` `in` ssa-reassignment
                               region attr-dict?
    ssa-reassignment ::= `(` ssa-id `=` ssa-use (`,` ssa-id `=` ssa-use)* `)`
    ```

    Example:

    ```mlir
    soda.launch blocks(%bx, %by, %bz) in (%sz_bx = %0, %sz_by = %1, %sz_bz = %2)
               threads(%tx, %ty, %tz) in (%sz_tx = %3, %sz_ty = %4, %sz_tz = %5) {
      // Block and thread identifiers, as well as block/grid sizes are
      // immediately usable inside body region.
      "some_op"(%bx, %tx) : (index, index) -> ()
      // Assuming %val1 is defined outside the soda.launch region.
      %42 = load %val1[%bx] : memref<?xf32, 1>
    }

    // Generic syntax explains how the pretty syntax maps to the IR structure.
    "soda.launch"(%cst, %cst, %c1,  // Grid sizes.
                 %cst, %c1, %c1)   // Block sizes.

        {/*attributes*/}
        // All sizes and identifiers have "index" size.
        : (index, index, index, index, index, index) -> () {
    // The operation passes block and thread identifiers, followed by grid and
    // block sizes.
    ^bb0(%bx : index, %by : index, %bz : index,
         %tx : index, %ty : index, %tz : index,
         %num_bx : index, %num_by : index, %num_bz : index,
         %num_tx : index, %num_ty : index, %num_tz : index)
      "some_op"(%bx, %tx) : (index, index) -> ()
      %3 = "std.load"(%val1, %bx) : (memref<?xf32, 1>, index) -> f32
    }
    ```

    Rationale: using operation/block arguments gives analyses a clear way of
    understanding that a value has additional semantics (e.g., we will need to
    know what value corresponds to threadIdx.x for coalescing). We can recover
    these properties by analyzing the operations producing values, but it is
    easier just to have that information by construction.
  }];

  let regions = (region AnyRegion:$body);

  let skipDefaultBuilders = 1;

  let builders = [
    OpBuilderDAG<(ins "Value":$gridSizeX, "Value":$gridSizeY,
      "Value":$gridSizeZ, "Value":$blockSizeX, "Value":$blockSizeY,
      "Value":$blockSizeZ)>
  ];

  let extraClassDeclaration = [{
    /// Get the SSA values corresponding to kernel block identifiers.
    KernelDim3 getBlockIds();
    /// Get the SSA values corresponding to kernel thread identifiers.
    KernelDim3 getThreadIds();
    /// Get the SSA values corresponding to kernel grid size.
    KernelDim3 getGridSize();
    /// Get the SSA values corresponding to kernel block size.
    KernelDim3 getBlockSize();

    /// Get the SSA values passed as operands to specify the grid size.
    KernelDim3 getGridSizeOperandValues();
    /// Get the SSA values passed as operands to specify the block size.
    KernelDim3 getBlockSizeOperandValues();

    static StringRef getBlocksKeyword() { return "blocks"; }
    static StringRef getThreadsKeyword() { return "threads"; }

    /// The number of launch configuration operands, placed at the leading
    /// positions of the operand list.
    static constexpr unsigned kNumConfigOperands = 6;

    /// The number of region attributes containing the launch configuration,
    /// placed in the leading positions of the argument list.
    static constexpr unsigned kNumConfigRegionAttributes = 12;
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

// add, mul mirror the XLA ComparisonDirection enum.
def SODA_AllReduceOpAdd : StrEnumAttrCase<"add">;
def SODA_AllReduceOpAnd : StrEnumAttrCase<"and">;
def SODA_AllReduceOpMax : StrEnumAttrCase<"max">;
def SODA_AllReduceOpMin : StrEnumAttrCase<"min">;
def SODA_AllReduceOpMul : StrEnumAttrCase<"mul">;
def SODA_AllReduceOpOr : StrEnumAttrCase<"or">;
def SODA_AllReduceOpXor : StrEnumAttrCase<"xor">;

def SODA_AllReduceOperationAttr : StrEnumAttr<"AllReduceOperationAttr",
    "built-in reduction operations supported by soda.allreduce.",
    [
      SODA_AllReduceOpAdd,
      SODA_AllReduceOpAnd,
      SODA_AllReduceOpMax,
      SODA_AllReduceOpMin,
      SODA_AllReduceOpMul,
      SODA_AllReduceOpOr,
      SODA_AllReduceOpXor
    ]>;

def SODA_AllReduceOp : SODA_Op<"all_reduce",
    [SameOperandsAndResultType, IsolatedFromAbove]>,
    Arguments<(ins AnyType:$value,
               OptionalAttr<SODA_AllReduceOperationAttr>:$op)>,
    Results<(outs AnyType)> {
  let summary = "Reduce values among workgroup.";
  let description = [{
    The `all_reduce` op reduces the value of every work item across a local
    workgroup. The result is equal for all work items of a workgroup.

    For example, both

    ```mlir
    %1 = "soda.all_reduce"(%0) ({}) { op = "add" } : (f32) -> (f32)
    %2 = "soda.all_reduce"(%0) ({
    ^bb(%lhs : f32, %rhs : f32):
      %sum = addf %lhs, %rhs : f32
      "soda.yield"(%sum) : (f32) -> ()
    }) : (f32) -> (f32)
    ```

    compute the sum of each work item's %0 value. The first version specifies
    the accumulation as operation, whereas the second version specifies the
    accumulation as code region. The accumulation operation must be one of:
    `add`, `and`, `max`, `min`, `mul`, `or`, `xor`.

    Either none or all work items of a workgroup need to execute this op
    in convergence.
  }];
  let regions = (region AnyRegion:$body);
  let verifier = [{ return ::verifyAllReduce(*this); }];
}

def SODA_ShuffleOpXor : StrEnumAttrCase<"xor">;

def SODA_ShuffleModeAttr : StrEnumAttr<"ShuffleModeAttr",
    "Indexing modes supported by soda.shuffle.",
    [
      SODA_ShuffleOpXor,
    ]>;
//TODO(NICO) - Remove arguments
def SODA_ShuffleOp : SODA_Op<"shuffle", [NoSideEffect]>,
    Arguments<(ins AnyType:$value, I32:$offset, I32:$width,
               SODA_ShuffleModeAttr:$mode)>,
    Results<(outs AnyType:$result, I1:$valid)> {
  let summary = "Shuffles values within a subgroup.";
  let description = [{
    The "shuffle" op moves values to a different invocation within the same
    subgroup.

    Example:

    ```mlir
    %1, %2 = soda.shuffle %0, %offset, %width xor : f32
    ```

    For lane k returns the value from lane `k ^ offset` and `true` if that lane
    is smaller than %width. Otherwise it returns an unspecified value and
    `false`. A lane is the index of an invocation relative to its subgroup.

    The width specifies the number of invocations that participate in the
    shuffle. The width needs to be the same for all invocations that participate
    in the shuffle. Exactly the first `width` invocations of a subgroup need to
    execute this op in convergence.
  }];
  let verifier = [{ return ::verifyShuffleOp(*this); }];
  let printer = [{ printShuffleOp(p, *this); }];
  let parser = [{ return parseShuffleOp(parser, result); }];
}

def SODA_BarrierOp : SODA_Op<"barrier"> {
  let summary = "Synchronizes all work items of a workgroup.";
  let description = [{
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


//TODO(NICO) - Single block
def SODA_SODAModuleOp : SODA_Op<"module", [
  IsolatedFromAbove, SymbolTable, Symbol,
  SingleBlockImplicitTerminator<"ModuleEndOp">
]> {
  let summary = "A top level compilation unit to be run on a SODA enabled device.";
  let description = [{
    SODA module contains code that is intended to be run on a SODA. A host
    device can launch this code through a soda.launc_func that creates a
    fully qualified symbol through the soda.module's symbol and a soda.func
    symbol contained in the soda.module.

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
    // soda.baz doesn't run until soda.foo and soda.bar have both completed, just
    // as if the async dependencies were [%t0, %t1].
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
