// RUN: soda-opt %s -test-loop-permutation="permutation-map=0,1,2" | FileCheck %s --check-prefix=CHECK-012
// RUN: soda-opt %s -test-loop-permutation="permutation-map=0,2,1" | FileCheck %s --check-prefix=CHECK-021
// RUN: soda-opt %s -test-loop-permutation="permutation-map=1,2,0" | FileCheck %s --check-prefix=CHECK-120

func.func @permute(%A: memref<4x4xf32>, %B: memref<4x4xf32>, %C: memref<4x4xf32>) -> memref<4x4xf32> {
  affine.for %i = 0 to 4 {
    affine.for %j = 0 to 4 {
      affine.for %k = 0 to 4 {
        %6 = affine.load %A[%i, %k] : memref<4x4xf32>
        %7 = affine.load %B[%k, %j] : memref<4x4xf32>
        %8 = affine.load %C[%i, %j] : memref<4x4xf32>
        %9 = arith.mulf %6, %7 : f32
        %10 = arith.addf %8, %9 : f32
        affine.store %10, %C[%i, %j] : memref<4x4xf32>
      }
    }
  }
  return %C : memref<4x4xf32>
}

// 0,1,2 is the same as no permutation (M,N,K)
// CHECK-012:        affine.for %[[II:.*]] = 0 to 4
// CHECK-012-NEXT:   affine.for %[[JJ:.*]] = 0 to 4
// CHECK-012-NEXT:   affine.for %[[KK:.*]] = 0 to 4

// CHECK-012:        affine.load %arg0[%[[II]], %[[KK]]] : memref<4x4xf32>
// CHECK-012-NEXT:   affine.load %arg1[%[[KK]], %[[JJ]]] : memref<4x4xf32>
// CHECK-012-NEXT:   affine.load %arg2[%[[II]], %[[JJ]]] : memref<4x4xf32>
// CHECK-012:        affine.store %{{.*}}, %arg2[%[[II]], %[[JJ]]] : memref<4x4xf32>

// 0,2,1 maps 0,1,2 into 0,2,1 bringing KK as second loop
// CHECK-021:        affine.for %[[II:.*]] = 0 to 4
// CHECK-021-NEXT:   affine.for %[[KK:.*]] = 0 to 4
// CHECK-021-NEXT:   affine.for %[[JJ:.*]] = 0 to 4

// CHECK-021:        affine.load %arg0[%[[II]], %[[KK]]] : memref<4x4xf32>
// CHECK-021-NEXT:   affine.load %arg1[%[[KK]], %[[JJ]]] : memref<4x4xf32>
// CHECK-021-NEXT:   affine.load %arg2[%[[II]], %[[JJ]]] : memref<4x4xf32>
// CHECK-021:        affine.store %{{.*}}, %arg2[%[[II]], %[[JJ]]] : memref<4x4xf32>


// 1,2,0 - not sure why this brings K to the first loop
// CHECK-120:        affine.for %[[KK:.*]] = 0 to 4
// CHECK-120-NEXT:   affine.for %[[II:.*]] = 0 to 4
// CHECK-120-NEXT:   affine.for %[[JJ:.*]] = 0 to 4
// CHECK-120:        affine.load %arg0[%[[II]], %[[KK]]] : memref<4x4xf32>
// CHECK-120-NEXT:   affine.load %arg1[%[[KK]], %[[JJ]]] : memref<4x4xf32>
// CHECK-120-NEXT:   affine.load %arg2[%[[II]], %[[JJ]]] : memref<4x4xf32>
// CHECK-120:        affine.store %{{.*}}, %arg2[%[[II]], %[[JJ]]] : memref<4x4xf32>
