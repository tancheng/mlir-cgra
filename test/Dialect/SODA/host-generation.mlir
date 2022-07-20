// RUN: soda-opt -allow-unregistered-dialect -soda-generate-bambu-hostcode %s -split-input-file | FileCheck %s

module attributes {soda.container_module}  {
  func.func @driver() {
    %0 = "loadA"() : () -> memref<512x512xf32>
    %1 = "loadB"() : () -> memref<512x512xf32>
    %2 = "allocateC"() : () -> memref<512x512xf32>
    soda.launch_func  @acc::@krnl args(%0 : memref<512x512xf32>, %1 : memref<512x512xf32>, %2 : memref<512x512xf32>)
    return
  }
  soda.module @acc {
    soda.func @krnl(%arg0: memref<512x512xf32>, %arg1: memref<512x512xf32>, %arg2: memref<512x512xf32>) kernel {
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<512x512xf32>, memref<512x512xf32>) outs(%arg2 : memref<512x512xf32>)
      soda.return
    }
  }
}

// CHECK:         func.func private @acc_krnl(memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>)
// CHECK-LABEL:   func.func @driver()
// CHECK:             call @acc_krnl(%0, %1, %2)
// CHECK-NOT:     soda.launch_func
// CHECK-NOT:     soda.module
// CHECK-NOT:     soda.func

// -----

module attributes {soda.container_module}  {
  func.func @driver() {
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
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<512x512xf32>, memref<512x512xf32>) outs(%arg2 : memref<512x512xf32>)
      soda.return
    }
  }
}

// CHECK:         func.func private @acc_krnl(memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>)
// CHECK-LABEL:   func.func @driver() {
// CHECK:             call @acc_krnl(%0, %1, %3)
// CHECK-NEXT:        call @acc_krnl(%0, %2, %4)

// CHECK-NOT:     soda.launch_func
// CHECK-NOT:     soda.module
// CHECK-NOT:     soda.func

// -----

module attributes {soda.container_module}  {
  func.func @driver() {
    %0 = "loadA"() : () -> memref<512x512xf32>
    %1 = "loadB"() : () -> memref<512x512xf32>
    %2 = "loadB"() : () -> memref<512x512xf32>
    %3 = "allocateC"() : () -> memref<512x512xf32>
    %4 = "allocateC"() : () -> memref<512x512xf32>
    soda.launch_func  @acc1::@krnl args(%0 : memref<512x512xf32>, %1 : memref<512x512xf32>, %3 : memref<512x512xf32>)
    soda.launch_func  @acc1::@krnl args(%0 : memref<512x512xf32>, %1 : memref<512x512xf32>, %3 : memref<512x512xf32>)
    soda.launch_func  @acc2::@krnl args(%0 : memref<512x512xf32>, %2 : memref<512x512xf32>, %4 : memref<512x512xf32>)
    return
  }
  soda.module @acc1 {
    soda.func @krnl(%arg0: memref<512x512xf32>, %arg1: memref<512x512xf32>, %arg2: memref<512x512xf32>) kernel {
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<512x512xf32>, memref<512x512xf32>) outs(%arg2 : memref<512x512xf32>)
      soda.return
    }
  }
  
  soda.module @acc2 {
    soda.func @krnl(%arg0: memref<512x512xf32>, %arg1: memref<512x512xf32>, %arg2: memref<512x512xf32>) kernel {
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<512x512xf32>, memref<512x512xf32>) outs(%arg2 : memref<512x512xf32>)
      soda.return
    }
  }
}

// CHECK:         func.func private @acc2_krnl(memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>)
// CHECK:         func.func private @acc1_krnl(memref<512x512xf32>, memref<512x512xf32>, memref<512x512xf32>)
// CHECK-LABEL:   func.func @driver() {
// CHECK:             call @acc1_krnl(%0, %1, %3)
// CHECK-NEXT:        call @acc1_krnl(%0, %1, %3)
// CHECK-NEXT:        call @acc2_krnl(%0, %2, %4)

// CHECK-NOT:     soda.launch_func
// CHECK-NOT:     soda.module
// CHECK-NOT:     soda.func
