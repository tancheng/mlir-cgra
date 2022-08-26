// RUN: soda-opt -convert-linalg-generic-to-soda %s | FileCheck  %s

#matmul_accesses = [
  affine_map<(m,n,k)->(m,k)>,
  affine_map<(m,n,k)->(k,n)>,
  affine_map<(m,n,k)->(m,n)>
]

#matmul_trait = {
  indexing_maps = #matmul_accesses,
  iterator_types = ["parallel", "parallel","reduction"]
}

// CHECK: @my_conv
func.func @my_conv(%A: memref<?x?xf32>, %B: memref<?x?xf32>, %C: memref<?x?xf32>){
  // CHECK: soda.launch
  // CHECK-NEXT: linalg.generic
  linalg.generic #matmul_trait
    ins(%A, %B : memref<?x?xf32>, memref<?x?xf32>)
    outs(%C : memref<?x?xf32>) {
  ^bb5(%a: f32, %b: f32, %c: f32):
    %tmp = arith.mulf %a,%b:f32
    %acc = arith.addf %tmp,%c:f32
    linalg.yield %acc : f32
  }
  // CHECK: soda.terminator
  return
}