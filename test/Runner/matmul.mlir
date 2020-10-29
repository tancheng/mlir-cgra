// RUN: soda-opt %s --convert-linalg-to-affine-loops -convert-linalg-to-std \
// RUN: --lower-affine --convert-scf-to-std -convert-std-to-llvm \
// RUN: | mlir-runner -e matmul -entry-point-result=f32 \
// RUN: | FileCheck %s

// This test was extracted from the llvm project:
// llvm-project/mlir/test/mlir-cpu-runner/linalg_integration_test.mlir

// Creates and returns a 1-D buffer of size %s filled with the value %f
func @alloc_filled_f32(%s : index, %f : f32) -> memref<?xi8> {
  %c0 = constant 0 : index
  %c1 = constant 1 : index
  %c4 = constant 4 : index
  %s4 = muli %s, %c4: index
  %buf = alloc(%s4) {alignment = 256} : memref<?xi8>
  %V = view %buf[%c0][%s] : memref<?xi8> to memref<?xf32>
  linalg.fill(%V, %f) : memref<?xf32>, f32
  return %buf : memref<?xi8>
}

// Test for linalg.matmul.
func @matmul() -> f32 {
  %c0 = constant 0 : index
  %c1 = constant 1 : index
  %c6 = constant 6 : index
  %c7 = constant 7 : index
  %c2 = constant 2 : index
  %c16 = constant 16 : index
  %c4 = constant 4 : index
  %c32 = constant 32 : index
  %f1 = constant 1.00000e+00 : f32
  %f2 = constant 2.00000e+00 : f32
  %f10 = constant 10.00000e+00 : f32

  %bA = call @alloc_filled_f32(%c32, %f2) : (index, f32) -> (memref<?xi8>)
  %bB = call @alloc_filled_f32(%c32, %f1) : (index, f32) -> (memref<?xi8>)
  %bC = call @alloc_filled_f32(%c4, %f10) : (index, f32) -> (memref<?xi8>)

  %A = view %bA[%c0][%c2, %c16] : memref<?xi8> to memref<?x?xf32>
  %B = view %bB[%c0][%c16, %c2] : memref<?xi8> to memref<?x?xf32>
  %C = view %bC[%c0][%c2, %c2] : memref<?xi8> to memref<?x?xf32>

  linalg.matmul ins(%A, %B : memref<?x?xf32>, memref<?x?xf32>)
               outs(%C : memref<?x?xf32>)
  %res = load %C[%c0, %c1] : memref<?x?xf32>

  dealloc %bC : memref<?xi8>
  dealloc %bB : memref<?xi8>
  dealloc %bA : memref<?xi8>

  return %res : f32
}

// All tests return this value
// CHECK: 4.2{{0+}}e+01