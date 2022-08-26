#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: tensor<4x4xf32>, %arg1: tensor<4x4xf32>, %arg2: tensor<4x4xf32>) -> tensor<4x4xf32> attributes {input_names = ["X1", "X2", "X3"], output_names = ["Y1"]} {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.init_tensor [4, 4] : tensor<4x4xf32>
    %1 = scf.for %arg3 = %c0 to %c4 step %c2 iter_args(%arg4 = %0) -> (tensor<4x4xf32>) {
      %5 = tensor.extract_slice %arg4[%arg3, 0] [2, 4] [1, 1] : tensor<4x4xf32> to tensor<2x4xf32>
      %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<2x4xf32>) -> tensor<2x4xf32>
      %7 = tensor.insert_slice %6 into %arg4[%arg3, 0] [2, 4] [1, 1] : tensor<2x4xf32> into tensor<4x4xf32>
      scf.yield %7 : tensor<4x4xf32>
    }
    %2 = scf.for %arg3 = %c0 to %c4 step %c2 iter_args(%arg4 = %1) -> (tensor<4x4xf32>) {
      %5 = tensor.extract_slice %arg0[%arg3, 0] [2, 4] [1, 1] : tensor<4x4xf32> to tensor<2x4xf32>
      %6 = tensor.extract_slice %arg4[%arg3, 0] [2, 4] [1, 1] : tensor<4x4xf32> to tensor<2x4xf32>
      %7 = linalg.matmul ins(%5, %arg1 : tensor<2x4xf32>, tensor<4x4xf32>) outs(%6 : tensor<2x4xf32>) -> tensor<2x4xf32>
      %8 = tensor.insert_slice %7 into %arg4[%arg3, 0] [2, 4] [1, 1] : tensor<2x4xf32> into tensor<4x4xf32>
      scf.yield %8 : tensor<4x4xf32>
    }
    %3 = linalg.init_tensor [4, 4] : tensor<4x4xf32>
    %4 = scf.for %arg3 = %c0 to %c4 step %c2 iter_args(%arg4 = %3) -> (tensor<4x4xf32>) {
      %5 = tensor.extract_slice %2[%arg3, 0] [2, 4] [1, 1] : tensor<4x4xf32> to tensor<2x4xf32>
      %6 = tensor.extract_slice %arg2[%arg3, 0] [2, 4] [1, 1] : tensor<4x4xf32> to tensor<2x4xf32>
      %7 = tensor.extract_slice %arg4[%arg3, 0] [2, 4] [1, 1] : tensor<4x4xf32> to tensor<2x4xf32>
      %8 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%5, %6 : tensor<2x4xf32>, tensor<2x4xf32>) outs(%7 : tensor<2x4xf32>) {
      ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
        %10 = arith.addf %arg5, %arg6 : f32
        %11 = arith.maxf %10, %cst : f32
        linalg.yield %11 : f32
      } -> tensor<2x4xf32>
      %9 = tensor.insert_slice %8 into %arg4[%arg3, 0] [2, 4] [1, 1] : tensor<2x4xf32> into tensor<4x4xf32>
      scf.yield %9 : tensor<4x4xf32>
    }
    return %4 : tensor<4x4xf32>
  }
}

