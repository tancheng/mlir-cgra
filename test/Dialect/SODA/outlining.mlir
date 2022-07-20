// RUN: soda-opt -allow-unregistered-dialect -soda-outline-bambu-code -split-input-file -verify-diagnostics %s | FileCheck %s

// CHECK: module attributes {soda.container_module}

// CHECK-LABEL: func @launch()
func.func @launch() {
  // CHECK: %[[ARG0:.*]] = "op"() : () -> f32
  %0 = "op"() : () -> (f32)
  // CHECK: %[[ARG1:.*]] = "op"() : () -> memref<?xf32, 1>
  %1 = "op"() : () -> (memref<?xf32, 1>)
  
  // CHECK: %[[IDX0:.*]] = arith.constant 1 : index
  %idx0 = arith.constant 1 : index
  // CHECK: %[[IDX1:.*]] = arith.constant 2 : index
  %idx1 = arith.constant 2 : index

  // CHECK: soda.launch_func @launch_kernel::@launch_kernel args(%[[ARG0]] : f32, %[[ARG1]] : memref<?xf32, 1>)
  // CHECK-NOT: soda.launch
  soda.launch {
    "use"(%0): (f32) -> ()
    "some_op"(%idx0, %idx1) : (index, index) -> ()
    %42 = memref.load %1[%idx0] : memref<?xf32, 1>
    soda.terminator
  }
  return
}


// CHECK-LABEL: module @launch_kernel
// CHECK-NEXT: soda.func @launch_kernel
// CHECK-SAME: (%[[KERNEL_ARG0:.*]]: f32, %[[KERNEL_ARG1:.*]]: memref<?xf32, 1>)
// CHECK-NEXT: cf.br ^[[BLOCK:.*]]
// CHECK-NEXT: ^[[BLOCK]]:
// CHECK: "use"(%[[KERNEL_ARG0]]) : (f32) -> ()
// CHECK-NEXT: "some_op"(%[[IDX0]], %[[IDX1]]) : (index, index) -> ()
// CHECK-NEXT: = memref.load %[[KERNEL_ARG1]][%[[IDX0]]] : memref<?xf32, 1>

// -----

// CHECK: module attributes {soda.container_module}
// CHECK-LABEL: @multiple_launches
func.func @multiple_launches() {
  // CHECK: soda.launch_func @multiple_launches_kernel::@multiple_launches_kernel
  soda.launch {
    soda.terminator
  }
  // CHECK: soda.launch_func @multiple_launches_kernel_0::@multiple_launches_kernel
  soda.launch {
    soda.terminator
  }
  return
}

// CHECK: module @multiple_launches_kernel
// CHECK: func @multiple_launches_kernel
// CHECK: module @multiple_launches_kernel_0
// CHECK: func @multiple_launches_kernel

// -----

// CHECK-LABEL: @extra_constants_not_inlined
func.func @extra_constants_not_inlined(%arg0: memref<?xf32>) {
  %cst2 = arith.constant 2 : index
  %c0 = arith.constant 0 : index
  %cst3 = "secret_constant"() : () -> index
  // CHECK: soda.launch_func @extra_constants_not_inlined_kernel::@extra_constants_not_inlined_kernel args({{.*}} : memref<?xf32>, {{.*}} : index)
  soda.launch {
    "use"(%cst2, %arg0, %cst3) : (index, memref<?xf32>, index) -> ()
    soda.terminator
  }
  return
}

// CHECK-LABEL: func @extra_constants_not_inlined_kernel(%{{.*}}: memref<?xf32>, %{{.*}}: index)
// CHECK: constant 2

// -----

// CHECK-LABEL: @extra_constants
// CHECK-SAME: %[[ARG0:.*]]: memref<?xf32>
func.func @extra_constants(%arg0: memref<?xf32>) {
  %cst = arith.constant 8 : index
  %cst2 = arith.constant 2 : index
  %c0 = arith.constant 0 : index
  %cst3 = memref.dim %arg0, %c0 : memref<?xf32>
  // CHECK: soda.launch_func @extra_constants_kernel::@extra_constants_kernel args(%[[ARG0]] : memref<?xf32>)
  soda.launch {
    "use"(%cst2, %arg0, %cst3) : (index, memref<?xf32>, index) -> ()
    soda.terminator
  }
  return
}

// CHECK-LABEL: func @extra_constants_kernel(
// CHECK-SAME: %[[KARG0:.*]]: memref<?xf32>
// CHECK: constant 2
// CHECK: constant 0
// CHECK: memref.dim %[[KARG0]]

// -----

// CHECK-LABEL: @extra_constants_noarg
// CHECK-SAME: %[[ARG0:.*]]: memref<?xf32>, %[[ARG1:.*]]: memref<?xf32>
func.func @extra_constants_noarg(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
  %cst2 = arith.constant 2 : index
  %c0 = arith.constant 0 : index
  // CHECK: memref.dim %[[ARG1]]
  %cst3 = memref.dim %arg1, %c0 : memref<?xf32>
  // CHECK: soda.launch_func @extra_constants_noarg_kernel::@extra_constants_noarg_kernel args(%[[ARG0]] : memref<?xf32>, {{.*}} : index)
  soda.launch {
    "use"(%cst2, %arg0, %cst3) : (index, memref<?xf32>, index) -> ()
    soda.terminator
  }
  return
}

// CHECK-LABEL: func @extra_constants_noarg_kernel(
// CHECK-SAME: %[[KARG0:.*]]: memref<?xf32>, %[[KARG1:.*]]: index
// CHECK: %[[KCST:.*]] = arith.constant 2
// CHECK: "use"(%[[KCST]], %[[KARG0]], %[[KARG1]])

// -----

// CHECK-LABEL: @multiple_uses
func.func @multiple_uses(%arg0 : memref<?xf32>) {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  // CHECK: soda.func {{.*}}
  // CHECK:   %[[C2:.*]] = arith.constant 2 : index
  // CHECK:   "use1"(%[[C2]], %[[C2]])
  // CHECK:   "use2"(%[[C2]])
  // CHECK:   soda.return
  // CHECK: }
  soda.launch {
    "use1"(%c2, %c2) : (index, index) -> ()
    "use2"(%c2) : (index) -> ()
    soda.terminator
  }
  return
}

// -----

// CHECK-LABEL: @multiple_uses2
func.func @multiple_uses2(%arg0 : memref<*xf32>) {
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %d = memref.dim %arg0, %c2 : memref<*xf32>
  // CHECK: soda.func {{.*}}
  // CHECK:   %[[C2:.*]] = arith.constant 2 : index
  // CHECK:   %[[D:.*]] = memref.dim %[[ARG:.*]], %[[C2]]
  // CHECK:   "use1"(%[[D]])
  // CHECK:   "use2"(%[[C2]], %[[C2]])
  // CHECK:   "use3"(%[[ARG]])
  // CHECK:   soda.return
  // CHECK: }
  soda.launch {
    "use1"(%d) : (index) -> ()
    "use2"(%c2, %c2) : (index, index) -> ()
    "use3"(%arg0) : (memref<*xf32>) -> ()
    soda.terminator
  }
  return
}

// -----

llvm.mlir.global internal @global(42 : i64) : i64

//CHECK-LABEL: @function_call
func.func @function_call(%arg0 : memref<?xf32>) {
  %cst = arith.constant 8 : index
  soda.launch {
    func.call @device_function() : () -> ()
    func.call @device_function() : () -> ()
    %0 = llvm.mlir.addressof @global : !llvm.ptr<i64>
    soda.terminator
  }
  return
}

func.func @device_function() {
  func.call @recursive_device_function() : () -> ()
  return
}

func.func @recursive_device_function() {
  func.call @recursive_device_function() : () -> ()
  return
}

// CHECK: soda.module @function_call_kernel {
// CHECK:   soda.func @function_call_kernel()
// CHECK:     call @device_function() : () -> ()
// CHECK:     call @device_function() : () -> ()
// CHECK:     llvm.mlir.addressof @global : !llvm.ptr<i64>
// CHECK:     soda.return
//
// CHECK:   llvm.mlir.global internal @global(42 : i64) : i64
//
// CHECK:   func.func @device_function()
// CHECK:   func.func @recursive_device_function()
// CHECK-NOT:   func.func @device_function

// -----

// Check if generating module,kernel names will avoid similar names to already
// defined functions by append _m to soda.module name
// CHECK-LABEL: @krnl
func.func private @krnl_kernel_krnl_kernel(memref<?xf32>, memref<?xf32>)
func.func private @dummy() -> memref<?xf32>
func.func @krnl(%arg0: memref<?xf32>) {
  soda.launch {
    %0 = func.call @dummy() : () -> memref<?xf32>
    func.call @krnl_kernel_krnl_kernel(%arg0, %0) : (memref<?xf32>, memref<?xf32>) -> ()
    soda.terminator
  }
  return
}
// CHECK: soda.launch_func  @krnl_kernel_m::@krnl_kernel
// CHECK-NOT: soda.module @krnl_kernel
// CHECK: soda.module @krnl_kernel_m
// CHECK:   soda.func @krnl_kernel
// CHECK:     call @krnl_kernel_krnl_kernel
// CHECK:     soda.return
//
// CHECK:   func.func private @dummy()
// CHECK:   func.func private @krnl_kernel_krnl_kernel
