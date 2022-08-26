// RUN: soda-opt -convert-all-to-soda="anchor-func=two_loop" %s | FileCheck  %s

// CHECK: @one_loop
func.func @one_loop(%A : memref<?xf32>, %B : memref<?xf32>) {
  affine.for %i = 0 to 42 {
    %0 = memref.load %A[%i] : memref<?xf32>
    memref.store %0, %B[%i] : memref<?xf32>
  }
  return
}


// CHECK: @two_loop
// FUNCFILTER: @two_loop
func.func @two_loop(%A : memref<?xf32>, %B : memref<?xf32>, %C : memref<?xf32>) {
  
  // CHECK-NEXT: soda.launch 
  // CHECK-NEXT: affine.for
  // CHECK-NEXT: memref.load
  // CHECK-NEXT: memref.store
  
  // CHECK: affine.for
  // CHECK-NEXT: memref.load
  // CHECK-NEXT: memref.store
  // CHECK: soda.terminator

  affine.for %i = 0 to 42 {
    %0 = memref.load %A[%i] : memref<?xf32>
    memref.store %0, %B[%i] : memref<?xf32>
  }
  
  affine.for %i = 0 to 42 {
    %0 = memref.load %B[%i] : memref<?xf32>
    memref.store %0, %C[%i] : memref<?xf32>
  }

  return
}

// Only one function body gets marked
// CHECK-NOT: soda.terminator
