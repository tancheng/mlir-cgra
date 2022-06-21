// RUN: soda-opt %s -affine-data-copy-generate="generate-dma=false fast-mem-space=0 fast-mem-capacity=1" | FileCheck %s

// Alternativelly the buffer trick can be originated from the linalg dialect.
// Buffer trick from linalg:
// -linalg-promote-subviews="test-use-alloca"

// CHECK-LABEL: func.func @buffer_trick
// CHECK:        memref.alloc() : memref<4x4xf32>
// CHECK-NEXT:   affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:     affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:       affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:       affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>

// CHECK:        memref.alloc() : memref<4x4xf32>
// CHECK-NEXT:   affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:     affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:       affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:       affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>

// CHECK:        memref.alloc() : memref<4x4xf32>
// CHECK-NEXT:   affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:     affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:       affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:       affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>

// CHECK:        affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:     affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:       affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:         affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:         affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:         affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:         mulf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:         addf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:         affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>

// CHECK:        affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:     affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:       affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:       affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>


func.func @buffer_trick(%A: memref<4x4xf32>, %B: memref<4x4xf32>, %C: memref<4x4xf32>) -> memref<4x4xf32> {
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
