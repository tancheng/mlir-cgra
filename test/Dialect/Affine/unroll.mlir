 // RUN: soda-opt %s -affine-loop-unroll="unroll-full" | FileCheck %s

func.func @unroll_inner(%A: memref<2x2xf32>, %B: memref<2x2xf32>, %C: memref<2x2xf32>) -> memref<2x2xf32> {
  affine.for %i = 0 to 4 {
    affine.for %j = 0 to 4 {
      affine.for %k = 0 to 4 {
        %6 = affine.load %A[%i, %k] : memref<2x2xf32>
        %7 = affine.load %B[%k, %j] : memref<2x2xf32>
        %8 = affine.load %C[%i, %j] : memref<2x2xf32>
        %9 = arith.mulf %6, %7 : f32
        %10 = arith.addf %8, %9 : f32
        affine.store %10, %C[%i, %j] : memref<2x2xf32>
      }
    }
  }
  return %C : memref<2x2xf32>
}

// CHECK-LABEL: func.func @unroll_inner
// CHECK:         affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:      affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %c0] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%c0, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        mulf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        addf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.apply #map0(%c0)
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        mulf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        addf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.apply #map1(%c0)
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        mulf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        addf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.apply #map2(%c0)
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
// CHECK-NEXT:        mulf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        addf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<2x2xf32>
