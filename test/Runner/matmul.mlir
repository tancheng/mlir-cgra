// RUN: soda-opt %s --convert-linalg-to-affine-loops --convert-linalg-to-std \
// RUN: --lower-affine --canonicalize --cse \ 
// RUN: --convert-scf-to-std --convert-std-to-llvm \
// RUN: | mlir-runner -e matmul_driver -entry-point-result=f32 \
// RUN: | FileCheck %s

// This test was modified based on from the llvm project test:
// llvm-project/mlir/test/mlir-cpu-runner/linalg_integration_test.mlir

// Performs AxB accumulating results on C
func @matmul_kernel(%A:memref<?x?xf32>, %B:memref<?x?xf32>, %C : memref<?x?xf32>) {
  linalg.matmul ins(%A, %B : memref<?x?xf32>, memref<?x?xf32>)
                outs(%C : memref<?x?xf32>)
  return
}

// Creates and returns a 1-D buffer of size %s filled with the value %f
func @alloc_filled_f32(%s : index, %f : f32) -> memref<?xi8> {
  %c0 = constant 0 : index
  %c1 = constant 1 : index
  %c4 = constant 4 : index // 4 bytes in one f32 value
  %s4 = muli %s, %c4: index
  %buf = alloc(%s4) {alignment = 256} : memref<?xi8>
  %V = view %buf[%c0][%s] : memref<?xi8> to memref<?xf32>
  linalg.fill(%V, %f) : memref<?xf32>, f32
  return %buf : memref<?xi8>
}

// Test for linalg.matmul
// Implements the following python code:
    // import numpy as np
    // A=np.full((2, 16), 2.)
    // B=np.full((16, 2), 1.)
    // C=np.matmul(A,B)+10.
    // print(C[0,1])
func @matmul_driver() -> f32 {
  // Index of returned value
  %c0 = constant 0 : index    // x, also 0 shift on the memref view
  %c1 = constant 1 : index    // y

  // Matrix dimensions
  %c2 = constant 2 : index    // M and N dimensions
  %c16 = constant 16 : index  // K Dimension

  // Number of elements
  %c32 = constant 32 : index  // Number of elements (not bytes) on A and B
  %c4 = constant 4 : index    // Number of elements (not bytes) on C

  // Values
  %f2 = constant 2.00000e+00 : f32    // A Fill
  %f1 = constant 1.00000e+00 : f32    // B Fill
  %f10 = constant 10.00000e+00 : f32  // C FIll, represents added constant

  // Allocate bytes as an i8 1d array
  %bA = call @alloc_filled_f32(%c32, %f2) : (index, f32) -> (memref<?xi8>)
  %bB = call @alloc_filled_f32(%c32, %f1) : (index, f32) -> (memref<?xi8>)
  %bC = call @alloc_filled_f32(%c4, %f10) : (index, f32) -> (memref<?xi8>)

  // View bytes as a f32 2D array, starting from element 0
  %A = view %bA[%c0][%c2, %c16] : memref<?xi8> to memref<?x?xf32>
  %B = view %bB[%c0][%c16, %c2] : memref<?xi8> to memref<?x?xf32>
  %C = view %bC[%c0][%c2, %c2] : memref<?xi8> to memref<?x?xf32>

  // linalg.matmul ins(%A, %B : memref<?x?xf32>, memref<?x?xf32>)
  //               outs(%C : memref<?x?xf32>)
  call @matmul_kernel(%A, %B, %C) : (memref<?x?xf32>, memref<?x?xf32>,  memref<?x?xf32>)  -> ()

  %res = load %C[%c0, %c1] : memref<?x?xf32>

  dealloc %bC : memref<?xi8>
  dealloc %bB : memref<?xi8>
  dealloc %bA : memref<?xi8>

  return %res : f32
}

// All tests return this value
// CHECK: 4.2{{0+}}e+01