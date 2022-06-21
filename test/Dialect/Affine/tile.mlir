// RUN: soda-opt %s -affine-loop-tile="tile-size=2" | FileCheck %s

func.func @tile(%A: memref<4x4xf32>, %B: memref<4x4xf32>, %C: memref<4x4xf32>) -> memref<4x4xf32> {
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

// CHECK:       #map0 = affine_map<(d0) -> (d0)>
// CHECK-NEXT:  #map1 = affine_map<(d0) -> (d0 + 2)>
// CHECK:       affine.for %{{.*}} = 0 to 4 step 2
// CHECK-NEXT:    affine.for %{{.*}} = 0 to 4 step 2
// CHECK-NEXT:      affine.for %{{.*}} = 0 to 4 step 2
// CHECK-NEXT:        affine.for %{{.*}} = #map0(%arg3) to #map1(%arg3)
// CHECK-NEXT:          affine.for %{{.*}} = #map0(%arg4) to #map1(%arg4)
// CHECK-NEXT:            affine.for %{{.*}} = #map0(%arg5) to #map1(%arg5)
