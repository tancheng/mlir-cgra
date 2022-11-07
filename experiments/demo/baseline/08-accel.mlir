#map0 = affine_map<(d0, d1)[s0] -> (d0 * 16 + s0 + d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<4x4xf32, #map0>, %arg1: memref<4x4xf32, #map0>, %arg2: memref<4x4xf32, #map0>, %arg3: memref<4x4xf32, #map0>) {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %cst = arith.constant 0.000000e+00 : f32
    linalg.generic {indexing_maps = [#map1, #map1, #map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1, %arg2 : memref<4x4xf32, #map0>, memref<4x4xf32, #map0>, memref<4x4xf32, #map0>) outs(%arg3 : memref<4x4xf32, #map0>) {
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32, %arg7: f32):
      %0 = arith.addf %arg4, %arg5 : f32
      %1 = arith.maxf %0, %cst : f32
      %2 = arith.addf %1, %arg6 : f32
      linalg.yield %2 : f32
    }
    return
  }
}

