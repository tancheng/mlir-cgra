// RUN: soda-opt -convert-affine-for-to-soda %s | FileCheck  %s

// CHECK: @one_d_loop
func @one_d_loop(%A : memref<?xf32>, %B : memref<?xf32>) {
  
  // CHECK-NEXT: soda.launch 
  // CHECK-NEXT: affine.for
  // CHECK-NEXT: load
  // CHECK-NEXT: store
  // CHECK: soda.terminator
  affine.for %i = 0 to 42 {
    %0 = load %A[%i] : memref<?xf32>
    store %0, %B[%i] : memref<?xf32>
  }
  return
}


// CHECK: @two_d_loop
func @two_d_loop(%A : memref<?xf32>, %B : memref<?xf32>) {
  
  // CHECK-NEXT: soda.launch 
  // CHECK-NEXT: affine.for
  // CHECK-NEXT: affine.for
  // CHECK-NEXT: load
  // CHECK-NEXT: store
  // CHECK: soda.terminator
  affine.for %i = 0 to 42 {
    affine.for %j = 0 to 42 {
      %0 = load %A[%i] : memref<?xf32>
      store %0, %B[%i] : memref<?xf32>
    }
  }
  return
}
