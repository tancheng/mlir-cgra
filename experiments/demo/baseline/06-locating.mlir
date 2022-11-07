#map0 = affine_map<(d0, d1)[s0] -> (d0 * 16 + s0 + d1)>
#map1 = affine_map<(d0, d1)[s0] -> (d0 * 32 + s0 + d1)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: memref<16x32xf32>, %arg1: memref<32x16xf32>, %arg2: memref<16x16xf32>, %arg3: memref<16x16xf32>, %arg4: memref<16x16xf32>) attributes {input_names = ["X0", "X1", "X2", "X3"], output_names = ["Z0"]} {
    %c4 = arith.constant 4 : index
    %c16 = arith.constant 16 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    scf.for %arg5 = %c0 to %c16 step %c4 {
      scf.for %arg6 = %c0 to %c16 step %c4 {
        %3 = memref.subview %0[%arg5, %arg6] [4, 4] [1, 1] : memref<16x16xf32> to memref<4x4xf32, #map0>
        linalg.fill ins(%cst : f32) outs(%3 : memref<4x4xf32, #map0>)
      }
    }
    %1 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    memref.copy %0, %1 : memref<16x16xf32> to memref<16x16xf32>
    memref.dealloc %0 : memref<16x16xf32>
    scf.for %arg5 = %c0 to %c16 step %c4 {
      scf.for %arg6 = %c0 to %c16 step %c4 {
        %3 = memref.subview %arg0[%arg5, 0] [4, 32] [1, 1] : memref<16x32xf32> to memref<4x32xf32, #map1>
        %4 = memref.subview %arg1[0, %arg6] [32, 4] [1, 1] : memref<32x16xf32> to memref<32x4xf32, #map0>
        %5 = memref.subview %1[%arg5, %arg6] [4, 4] [1, 1] : memref<16x16xf32> to memref<4x4xf32, #map0>
        soda.launch {
          soda.cgra.matmul %3, %4, %5 : memref<4x32xf32, #map1>, memref<32x4xf32, #map0>, memref<4x4xf32, #map0>
          soda.terminator
        }
      }
    }
    %2 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    scf.for %arg5 = %c0 to %c16 step %c4 {
      scf.for %arg6 = %c0 to %c16 step %c4 {
        %3 = memref.subview %1[%arg5, %arg6] [4, 4] [1, 1] : memref<16x16xf32> to memref<4x4xf32, #map0>
        %4 = memref.subview %arg2[%arg5, %arg6] [4, 4] [1, 1] : memref<16x16xf32> to memref<4x4xf32, #map0>
        %5 = memref.subview %arg3[%arg5, %arg6] [4, 4] [1, 1] : memref<16x16xf32> to memref<4x4xf32, #map0>
        %6 = memref.subview %2[%arg5, %arg6] [4, 4] [1, 1] : memref<16x16xf32> to memref<4x4xf32, #map0>
        soda.launch {
          linalg.generic {indexing_maps = [#map2, #map2, #map2, #map2], iterator_types = ["parallel", "parallel"]} ins(%3, %4, %5 : memref<4x4xf32, #map0>, memref<4x4xf32, #map0>, memref<4x4xf32, #map0>) outs(%6 : memref<4x4xf32, #map0>) {
          ^bb0(%arg7: f32, %arg8: f32, %arg9: f32, %arg10: f32):
            %7 = arith.addf %arg7, %arg8 : f32
            %8 = arith.maxf %7, %cst : f32
            %9 = arith.addf %8, %arg9 : f32
            linalg.yield %9 : f32
          }
          soda.terminator
        }
      }
    }
    memref.dealloc %1 : memref<16x16xf32>
    memref.copy %2, %arg4 : memref<16x16xf32> to memref<16x16xf32>
    return
  }
}

