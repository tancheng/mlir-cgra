// RUN: soda-opt %s -test-linalg-codegen-strategy="anchor-op=linalg.matmul tile-sizes=2,4,8" | FileCheck %s --check-prefix=TILE
// RUN: soda-opt %s -test-linalg-codegen-strategy="anchor-op=linalg.matmul tile-sizes=2,4,8 tile-interchange=1,2,0" | FileCheck %s --check-prefix=INTERCHANGE

func.func @matmul(%A: memref<1024x1024xf32>, %B: memref<1024x1024xf32>, %C: memref<1024x1024xf32>) {
  linalg.matmul
   ins(%A, %B: memref<1024x1024xf32>, memref<1024x1024xf32>)
   outs(%C: memref<1024x1024xf32>)
  return
}

// TILE-LABEL:  func.func @matmul
// TILE:         scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c2 {
// TILE-NEXT:      scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c4 {
// TILE-NEXT:        memref.subview
// TILE-NEXT:        scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c8 {
// TILE-NEXT:          memref.subview
// TILE-NEXT:          memref.subview
// TILE-NEXT:          linalg.matmul

// INTERCHANGE-LABEL: func.func @matmul
// INTERCHANGE:         scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c4 {
// INTERCHANGE-NEXT:      scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c8 {
// INTERCHANGE-NEXT:        memref.subview
// INTERCHANGE-NEXT:        scf.for %{{.*}} = %{{.*}} to %{{.*}} step %c2 {
// INTERCHANGE-NEXT:          memref.subview
// INTERCHANGE-NEXT:          memref.subview
// INTERCHANGE-NEXT:          linalg.matmul
