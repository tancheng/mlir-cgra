 // RUN: soda-opt -allow-unregistered-dialect %s -affine-loop-fusion="fusion-maximal" -split-input-file | FileCheck %s
 
func.func @fusion_with_arith(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) -> memref<4x4xf32> {
  %0 = memref.alloc() : memref<4x4xf32>
  affine.for %arg3 = 0 to 4 {
    affine.for %arg4 = 0 to 4 {
      %3 = affine.load %arg0[%arg3, %arg4] : memref<4x4xf32>
      affine.store %3, %0[%arg3, %arg4] : memref<4x4xf32>
    }
  }
  %1 = memref.alloc() : memref<4x4xf32>
  affine.for %arg3 = 0 to 4 {
    affine.for %arg4 = 0 to 4 {
      %3 = affine.load %arg1[%arg3, %arg4] : memref<4x4xf32>
      affine.store %3, %1[%arg3, %arg4] : memref<4x4xf32>
    }
  }
  %2 = memref.alloc() : memref<4x4xf32>
  affine.for %arg3 = 0 to 4 {
    affine.for %arg4 = 0 to 4 {
      %3 = affine.load %arg2[%arg3, %arg4] : memref<4x4xf32>
      affine.store %3, %2[%arg3, %arg4] : memref<4x4xf32>
    }
  }
  affine.for %arg3 = 0 to 4 {
    affine.for %arg4 = 0 to 4 {
      affine.for %arg5 = 0 to 4 {
        %3 = affine.load %0[%arg3, %arg5] : memref<4x4xf32>
        %4 = affine.load %1[%arg5, %arg4] : memref<4x4xf32>
        %5 = affine.load %2[%arg3, %arg4] : memref<4x4xf32>
        %6 = arith.mulf %3, %4 : f32
        %7 = arith.addf %5, %6 : f32
        affine.store %7, %2[%arg3, %arg4] : memref<4x4xf32>
      }
    }
  }
  affine.for %arg3 = 0 to 4 {
    affine.for %arg4 = 0 to 4 {
      %3 = affine.load %2[%arg3, %arg4] : memref<4x4xf32>
      affine.store %3, %arg2[%arg3, %arg4] : memref<4x4xf32>
    }
  }
  memref.dealloc %2 : memref<4x4xf32>
  memref.dealloc %1 : memref<4x4xf32>
  memref.dealloc %0 : memref<4x4xf32>
  return %arg2 : memref<4x4xf32>
}

// CHECK-LABEL: func.func @fusion_with_arith
// CHECK:       affine.for %{{.*}} = 0 to 4 
// CHECK-NEXT:    affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:      affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:      affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:      affine.for %{{.*}} = 0 to 4
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:        affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:        affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:        affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:        mulf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        addf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:        affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK:           affine.load %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>
// CHECK-NEXT:      affine.store %{{.*}}, %{{.*}}[%{{.*}}, %{{.*}}] : memref<4x4xf32>

// -----

// TODO: This is not fusing...
// But for our goals, it should
// CHECK-LABEL: func.func @fusion_with_memops
func.func @fusion_with_memops(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) {
  %0 = memref.alloc() : memref<4x4xf32>
  %1 = memref.alloc() : memref<4x4xf32>
  affine.for %arg3 = 0 to 4 {
    affine.for %arg4 = 0 to 4 {
      %3 = affine.load %arg0[%arg3, %arg4] : memref<4x4xf32>
      affine.store %3, %0[%arg3, %arg4] : memref<4x4xf32>
    }
  }
  affine.for %arg3 = 0 to 4 {
    affine.for %arg4 = 0 to 4 {
      %4 = affine.load %arg1[%arg3, %arg4] : memref<4x4xf32>
      affine.store %4, %1[%arg3, %arg4] : memref<4x4xf32>
    }
  }
  return
}
