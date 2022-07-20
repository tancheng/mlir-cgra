// RUN: soda-opt -convert-linalg-matmul-to-soda %s | FileCheck  %s

// CHECK: @my_matmul
func.func @my_matmul(%A:memref<?x?xf32>, %B:memref<?x?xf32>, %C : memref<?x?xf32>) {
  // CHECK: soda.launch
  // CHECK-NEXT: linalg.matmul
  linalg.matmul ins(%A, %B : memref<?x?xf32>, memref<?x?xf32>)
                outs(%C : memref<?x?xf32>)
  // CHECK: soda.terminator
  return
}