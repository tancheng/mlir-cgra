// RUN: soda-opt -convert-linalg-dot-to-soda %s | FileCheck  %s
// RUN: soda-opt -convert-operation-to-soda=anchor-op="linalg.dot" %s | FileCheck  %s

// CHECK: @my_dot
func.func @my_dot(%A:memref<?xf32>, %B:memref<?xf32>, %C : memref<f32>) {
  // CHECK: soda.launch
  // CHECK-NEXT: linalg.dot
  linalg.dot ins(%A, %B : memref<?xf32>, memref<?xf32>)
                outs(%C : memref<f32>)
  // CHECK: soda.terminator
  return
}
