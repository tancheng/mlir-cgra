// RUN: soda-opt -convert-scf-for-to-soda %s | FileCheck  %s

// CHECK: @one_d_loop
func @one_d_loop(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
  %c0 = constant 0 : index
  %c42 = constant 42 : index
  %c1 = constant 1 : index

  // CHECK: soda.launch
  // CHECK-NEXT: scf.for
  // CHECK-NEXT: load
  // CHECK-NEXT: store
  // CHECK: soda.terminator
  scf.for %arg2 = %c0 to %c42 step %c1 {
    %0 = load %arg0[%arg2] : memref<?xf32>
    store %0, %arg1[%arg2] : memref<?xf32>
  }
  return
}

// CHECK: @two_d_loop
func @two_d_loop(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
  %c0 = constant 0 : index
  %c42 = constant 42 : index
  %c1 = constant 1 : index
  // CHECK: soda.launch
  // CHECK-NEXT: scf.for
  scf.for %arg2 = %c0 to %c42 step %c1 {
    %c0_0 = constant 0 : index
    %c42_1 = constant 42 : index
    %c1_2 = constant 1 : index
    // CHECK-NEXT: constant
    // CHECK-NEXT: constant
    // CHECK-NEXT: constant
    // CHECK-NEXT: scf.for
    // CHECK-NEXT: load
    // CHECK-NEXT: store
    scf.for %arg3 = %c0_0 to %c42_1 step %c1_2 {
      %0 = load %arg0[%arg2] : memref<?xf32>
      store %0, %arg1[%arg2] : memref<?xf32>
    }
  }
  // CHECK: soda.terminator
  return
}
