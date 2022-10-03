#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: memref<16x32xf32>, %arg1: memref<32x16xf32>, %arg2: memref<16x16xf32>, %arg3: memref<16x16xf32>, %arg4: memref<16x16xf32>) attributes {input_names = ["X0", "X1", "X2", "X3"], output_names = ["Z0"]} {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    linalg.fill ins(%cst : f32) outs(%0 : memref<16x16xf32>)
    %1 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    memref.copy %0, %1 : memref<16x16xf32> to memref<16x16xf32>
    memref.dealloc %0 : memref<16x16xf32>
    linalg.matmul ins(%arg0, %arg1 : memref<16x32xf32>, memref<32x16xf32>) outs(%1 : memref<16x16xf32>)
    %2 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%1, %arg2, %arg3 : memref<16x16xf32>, memref<16x16xf32>, memref<16x16xf32>) outs(%2 : memref<16x16xf32>) {
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f32, %arg8: f32):
      %3 = arith.addf %arg5, %arg6 : f32
      %4 = arith.maxf %3, %cst : f32
      %5 = arith.addf %4, %arg7 : f32
      linalg.yield %5 : f32
    }
    memref.dealloc %1 : memref<16x16xf32>
    memref.copy %2, %arg4 : memref<16x16xf32> to memref<16x16xf32>
    return
  }
}

