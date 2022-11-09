// RUN: soda-opt %s --linalg-strategy-tile-pass="anchor-op=linalg.matmul" --linalg-tile="tile-sizes=2,4,8" | FileCheck %s --check-prefix=TILE

func.func @matmul(%A: memref<1024x1024xf32>, %B: memref<1024x1024xf32>, %C: memref<1024x1024xf32>) {
  linalg.matmul
   ins(%A, %B: memref<1024x1024xf32>, memref<1024x1024xf32>)
   outs(%C: memref<1024x1024xf32>)
  return
}

// TILE-LABEL:  func.func @matmul
// TILE:         scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c2 {
// TILE-NEXT:      scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c4 {
// TILE-NEXT:        scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c8 {
// TILE-NEXT:          memref.subview
// TILE-NEXT:          memref.subview
// TILE-NEXT:          memref.subview
// TILE-NEXT:          linalg.matmul
