// RUN: soda-opt -allow-unregistered-dialect -soda-kernel-outlining -split-input-file -verify-diagnostics %s | FileCheck %s

// CHECK: module attributes {soda.container_module}

// CHECK-LABEL: func @launch()
func @launch() {
  // CHECK: %[[ARG0:.*]] = "op"() : () -> f32
  %0 = "op"() : () -> (f32)
  // CHECK: %[[ARG1:.*]] = "op"() : () -> memref<?xf32, 1>
  %1 = "op"() : () -> (memref<?xf32, 1>)
  
  // CHECK: %[[IDX0:.*]] = constant 1 : index
  %idx0 = constant 1 : index
  // CHECK: %[[IDX1:.*]] = constant 2 : index
  %idx1 = constant 2 : index

  // CHECK: soda.launch_func @launch_kernel::@launch_kernel args(%[[ARG0]] : f32, %[[ARG1]] : memref<?xf32, 1>)
  // CHECK-NOT: soda.launch
  soda.launch {
    "use"(%0): (f32) -> ()
    "some_op"(%idx0, %idx1) : (index, index) -> ()
    %42 = load %1[%idx0] : memref<?xf32, 1>
    soda.terminator
  }
  return
}


// CHECK-LABEL: module @launch_kernel
// CHECK-NEXT: soda.func @launch_kernel
// CHECK-SAME: (%[[KERNEL_ARG0:.*]]: f32, %[[KERNEL_ARG1:.*]]: memref<?xf32, 1>)
// CHECK-NEXT: br ^[[BLOCK:.*]]
// CHECK-NEXT: ^[[BLOCK]]:
// CHECK: "use"(%[[KERNEL_ARG0]]) : (f32) -> ()
// CHECK-NEXT: "some_op"(%[[IDX0]], %[[IDX1]]) : (index, index) -> ()
// CHECK-NEXT: = load %[[KERNEL_ARG1]][%[[IDX0]]] : memref<?xf32, 1>

// -----

// CHECK: module attributes {soda.container_module}
// CHECK-LABEL: @multiple_launches
func @multiple_launches() {
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
func @extra_constants_not_inlined(%arg0: memref<?xf32>) {
  %cst2 = constant 2 : index
  %c0 = constant 0 : index
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
func @extra_constants(%arg0: memref<?xf32>) {
  %cst = constant 8 : index
  %cst2 = constant 2 : index
  %c0 = constant 0 : index
  %cst3 = dim %arg0, %c0 : memref<?xf32>
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
// CHECK: dim %[[KARG0]]

// -----

// CHECK-LABEL: @extra_constants_noarg
// CHECK-SAME: %[[ARG0:.*]]: memref<?xf32>, %[[ARG1:.*]]: memref<?xf32>
func @extra_constants_noarg(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
  %cst2 = constant 2 : index
  %c0 = constant 0 : index
  // CHECK: dim %[[ARG1]]
  %cst3 = dim %arg1, %c0 : memref<?xf32>
  // CHECK: soda.launch_func @extra_constants_noarg_kernel::@extra_constants_noarg_kernel args(%[[ARG0]] : memref<?xf32>, {{.*}} : index)
  soda.launch {
    "use"(%cst2, %arg0, %cst3) : (index, memref<?xf32>, index) -> ()
    soda.terminator
  }
  return
}

// CHECK-LABEL: func @extra_constants_noarg_kernel(
// CHECK-SAME: %[[KARG0:.*]]: memref<?xf32>, %[[KARG1:.*]]: index
// CHECK: %[[KCST:.*]] = constant 2
// CHECK: "use"(%[[KCST]], %[[KARG0]], %[[KARG1]])

// -----

// CHECK-LABEL: @multiple_uses
func @multiple_uses(%arg0 : memref<?xf32>) {
  %c1 = constant 1 : index
  %c2 = constant 2 : index
  // CHECK: soda.func {{.*}} {
  // CHECK:   %[[C2:.*]] = constant 2 : index
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
func @multiple_uses2(%arg0 : memref<*xf32>) {
  %c1 = constant 1 : index
  %c2 = constant 2 : index
  %d = dim %arg0, %c2 : memref<*xf32>
  // CHECK: soda.func {{.*}} {
  // CHECK:   %[[C2:.*]] = constant 2 : index
  // CHECK:   %[[D:.*]] = dim %[[ARG:.*]], %[[C2]]
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
func @function_call(%arg0 : memref<?xf32>) {
  %cst = constant 8 : index
  soda.launch {
    call @device_function() : () -> ()
    call @device_function() : () -> ()
    %0 = llvm.mlir.addressof @global : !llvm.ptr<i64>
    soda.terminator
  }
  return
}

func @device_function() {
  call @recursive_device_function() : () -> ()
  return
}

func @recursive_device_function() {
  call @recursive_device_function() : () -> ()
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
// CHECK:   func @device_function()
// CHECK:   func @recursive_device_function()
// CHECK-NOT:   func @device_function
