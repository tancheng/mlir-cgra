// RUN: soda-opt -allow-unregistered-dialect -soda-generate-bambu-hostcode %s -split-input-file | FileCheck %s


module attributes {soda.container_module}  {
  func @driver() {
    %0 = "loadA"() : () -> memref<512x512xf32>
    %1 = "loadB"() : () -> memref<512x512xf32>
    %2 = "allocateC"() : () -> memref<512x512xf32>
    soda.launch_func  @acc::@krnl args(%0 : memref<512x512xf32>, %1 : memref<512x512xf32>, %2 : memref<512x512xf32>)
    return
  }
  soda.module @acc {
    soda.func @krnl(%arg0: memref<512x512xf32>, %arg1: memref<512x512xf32>, %arg2: memref<512x512xf32>) kernel {
      br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<512x512xf32>, memref<512x512xf32>) outs(%arg2 : memref<512x512xf32>)
      soda.return
    }
  }
}

// CHECK: module
// CHECK-NEXT:   func private @acc_krnl(memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>)
// CHECK-LABEL:   func @driver() {
// CHECK:     call @acc_krnl(%0, %1, %2) : (memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>) -> ()
// CHECK-NOT:     soda.launch_func
// CHECK-NOT:     soda.module
// CHECK-NOT:     soda.func

// -----

module attributes {soda.container_module}  {
  func @driver() {
    %0 = "loadA"() : () -> memref<512x512xf32>
    %1 = "loadB"() : () -> memref<512x512xf32>
    %2 = "loadB"() : () -> memref<512x512xf32>
    %3 = "allocateC"() : () -> memref<512x512xf32>
    %4 = "allocateC"() : () -> memref<512x512xf32>
    soda.launch_func  @acc::@krnl args(%0 : memref<512x512xf32>, %1 : memref<512x512xf32>, %3 : memref<512x512xf32>)
    soda.launch_func  @acc::@krnl args(%0 : memref<512x512xf32>, %2 : memref<512x512xf32>, %4 : memref<512x512xf32>)
    return
  }
  soda.module @acc {
    soda.func @krnl(%arg0: memref<512x512xf32>, %arg1: memref<512x512xf32>, %arg2: memref<512x512xf32>) kernel {
      br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<512x512xf32>, memref<512x512xf32>) outs(%arg2 : memref<512x512xf32>)
      soda.return
    }
  }
}

// CHECK: module
// CHECK-NEXT:   func private @acc_krnl(memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>)
// CHECK-LABEL:   func @driver() {
// CHECK:     call @acc_krnl(%0, %1, %2) : (memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>) -> ()
// CHECK-NOT:     soda.launch_func
// CHECK-NOT:     soda.module
// CHECK-NOT:     soda.func

// ---