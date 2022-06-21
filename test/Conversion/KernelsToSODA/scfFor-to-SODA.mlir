// RUN: soda-opt -convert-scf-for-to-soda %s | FileCheck  %s

// CHECK: @one_d_loop
func.func @one_d_loop(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
  %c0 = arith.constant 0 : index
  %c42 = arith.constant 42 : index
  %c1 = arith.constant 1 : index

  // CHECK: soda.launch
  // CHECK-NEXT: scf.for
  // CHECK-NEXT: memref.load
  // CHECK-NEXT: memref.store
  // CHECK: soda.terminator
  scf.for %arg2 = %c0 to %c42 step %c1 {
    %0 = memref.load %arg0[%arg2] : memref<?xf32>
    memref.store %0, %arg1[%arg2] : memref<?xf32>
  }
  return
}

// CHECK: @two_d_loop
func.func @two_d_loop(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
  %c0 = arith.constant 0 : index
  %c42 = arith.constant 42 : index
  %c1 = arith.constant 1 : index
  // CHECK: soda.launch
  // CHECK-NEXT: scf.for
  scf.for %arg2 = %c0 to %c42 step %c1 {
    %c0_0 = arith.constant 0 : index
    %c42_1 = arith.constant 42 : index
    %c1_2 = arith.constant 1 : index
    // CHECK-NEXT: constant
    // CHECK-NEXT: constant
    // CHECK-NEXT: constant
    // CHECK-NEXT: scf.for
    // CHECK-NEXT: memref.load
    // CHECK-NEXT: memref.store
    scf.for %arg3 = %c0_0 to %c42_1 step %c1_2 {
      %0 = memref.load %arg0[%arg2] : memref<?xf32>
      memref.store %0, %arg1[%arg2] : memref<?xf32>
    }
  }
  // CHECK: soda.terminator
  return
}
