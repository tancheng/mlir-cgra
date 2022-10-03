#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: tensor<16x32xf32>, %arg1: tensor<32x16xf32>, %arg2: tensor<16x16xf32>, %arg3: tensor<16x16xf32>) -> tensor<16x16xf32> attributes {input_names = ["X0", "X1", "X2", "X3"], output_names = ["Z0"]} {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.init_tensor [16, 16] : tensor<16x16xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<16x16xf32>) -> tensor<16x16xf32>
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<16x32xf32>, tensor<32x16xf32>) outs(%1 : tensor<16x16xf32>) -> tensor<16x16xf32>
    %3 = linalg.init_tensor [16, 16] : tensor<16x16xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%2, %arg2, %arg3 : tensor<16x16xf32>, tensor<16x16xf32>, tensor<16x16xf32>) outs(%3 : tensor<16x16xf32>) {
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32, %arg7: f32):
      %5 = arith.addf %arg4, %arg5 : f32
      %6 = arith.maxf %5, %cst : f32
      %7 = arith.addf %6, %arg6 : f32
      linalg.yield %7 : f32
    } -> tensor<16x16xf32>
    return %4 : tensor<16x16xf32>
  }
}

