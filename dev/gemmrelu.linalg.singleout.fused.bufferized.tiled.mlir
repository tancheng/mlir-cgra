#map0 = affine_map<(d0, d1)[s0] -> (d0 * 4 + s0 + d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) -> memref<4x4xf32> attributes {input_names = ["X1", "X2", "X3"], output_names = ["Y1"]} {
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<4x4xf32>
    scf.for %arg3 = %c0 to %c4 step %c2 {
      %3 = memref.subview %0[%arg3, 0] [2, 4] [1, 1] : memref<4x4xf32> to memref<2x4xf32, #map0>
      linalg.fill ins(%cst : f32) outs(%3 : memref<2x4xf32, #map0>)
    }
    %1 = memref.alloc() {alignment = 128 : i64} : memref<4x4xf32>
    memref.copy %0, %1 : memref<4x4xf32> to memref<4x4xf32>
    scf.for %arg3 = %c0 to %c4 step %c2 {
      %3 = memref.subview %arg0[%arg3, 0] [2, 4] [1, 1] : memref<4x4xf32> to memref<2x4xf32, #map0>
      %4 = memref.subview %1[%arg3, 0] [2, 4] [1, 1] : memref<4x4xf32> to memref<2x4xf32, #map0>
      linalg.matmul ins(%3, %arg1 : memref<2x4xf32, #map0>, memref<4x4xf32>) outs(%4 : memref<2x4xf32, #map0>)
    }
    %2 = memref.alloc() {alignment = 128 : i64} : memref<4x4xf32>
    scf.for %arg3 = %c0 to %c4 step %c2 {
      %3 = memref.subview %1[%arg3, 0] [2, 4] [1, 1] : memref<4x4xf32> to memref<2x4xf32, #map0>
      %4 = memref.subview %arg2[%arg3, 0] [2, 4] [1, 1] : memref<4x4xf32> to memref<2x4xf32, #map0>
      %5 = memref.subview %2[%arg3, 0] [2, 4] [1, 1] : memref<4x4xf32> to memref<2x4xf32, #map0>
      linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%3, %4 : memref<2x4xf32, #map0>, memref<2x4xf32, #map0>) outs(%5 : memref<2x4xf32, #map0>) {
      ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
        %6 = arith.addf %arg4, %arg5 : f32
        %7 = arith.maxf %6, %cst : f32
        linalg.yield %7 : f32
      }
    }
    return %2 : memref<4x4xf32>
  }
}

