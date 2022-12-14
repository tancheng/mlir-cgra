#map0 = affine_map<(d0, d1)[s0] -> (d0 * 16 + s0 + d1)>
#map1 = affine_map<(d0, d1)[s0] -> (d0 * 32 + s0 + d1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", soda.container_module} {
  func.func @main_graph(%arg0: memref<16x32xf32>, %arg1: memref<32x16xf32>, %arg2: memref<16x16xf32>, %arg3: memref<16x16xf32>, %arg4: memref<16x16xf32>) attributes {input_names = ["X0", "X1", "X2", "X3"], output_names = ["Z0"]} {
    %c4 = arith.constant 4 : index
    %c8 = arith.constant 8 : index
    %c16 = arith.constant 16 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    scf.for %arg5 = %c0 to %c16 step %c4 {
      scf.for %arg6 = %c0 to %c16 step %c8 {
        %3 = memref.subview %0[%arg5, %arg6] [4, 8] [1, 1] : memref<16x16xf32> to memref<4x8xf32, #map0>
        linalg.fill ins(%cst : f32) outs(%3 : memref<4x8xf32, #map0>)
      }
    }
    %1 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    memref.copy %0, %1 : memref<16x16xf32> to memref<16x16xf32>
    memref.dealloc %0 : memref<16x16xf32>
    scf.for %arg5 = %c0 to %c16 step %c4 {
      scf.for %arg6 = %c0 to %c16 step %c8 {
        %3 = memref.subview %arg0[%arg5, 0] [4, 32] [1, 1] : memref<16x32xf32> to memref<4x32xf32, #map1>
        %4 = memref.subview %arg1[0, %arg6] [32, 8] [1, 1] : memref<32x16xf32> to memref<32x8xf32, #map0>
        %5 = memref.subview %1[%arg5, %arg6] [4, 8] [1, 1] : memref<16x16xf32> to memref<4x8xf32, #map0>
        soda.launch_cgra  @matmul::@matmul args(%3 : memref<4x32xf32, #map1>, %4 : memref<32x8xf32, #map0>, %5 : memref<4x8xf32, #map0>)
      }
    }
    %2 = memref.alloc() {alignment = 128 : i64} : memref<16x16xf32>
    scf.for %arg5 = %c0 to %c16 step %c4 {
      scf.for %arg6 = %c0 to %c16 step %c8 {
        %3 = memref.subview %1[%arg5, %arg6] [4, 8] [1, 1] : memref<16x16xf32> to memref<4x8xf32, #map0>
        %4 = memref.subview %arg2[%arg5, %arg6] [4, 8] [1, 1] : memref<16x16xf32> to memref<4x8xf32, #map0>
        %5 = memref.subview %arg3[%arg5, %arg6] [4, 8] [1, 1] : memref<16x16xf32> to memref<4x8xf32, #map0>
        %6 = memref.subview %2[%arg5, %arg6] [4, 8] [1, 1] : memref<16x16xf32> to memref<4x8xf32, #map0>
        soda.launch_cgra  @fusion_add_max_add::@fusion_add_max_add args(%3 : memref<4x8xf32, #map0>, %4 : memref<4x8xf32, #map0>, %5 : memref<4x8xf32, #map0>, %6 : memref<4x8xf32, #map0>)
      }
    }
    memref.dealloc %1 : memref<16x16xf32>
    memref.copy %2, %arg4 : memref<16x16xf32> to memref<16x16xf32>
    return
  }
  soda.module @matmul {
    soda.func @matmul(%arg0: memref<4x32xf32, #map1>, %arg1: memref<32x8xf32, #map0>, %arg2: memref<4x8xf32, #map0>) kernel{
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      soda.cgra.matmul %arg0, %arg1, %arg2 : memref<4x32xf32, #map1>, memref<32x8xf32, #map0>, memref<4x8xf32, #map0>
      soda.return
    }
  }
  soda.module @fusion_add_max_add {
    soda.func @fusion_add_max_add(%arg0: memref<4x8xf32, #map0>, %arg1: memref<4x8xf32, #map0>, %arg2: memref<4x8xf32, #map0>, %arg3: memref<4x8xf32, #map0>) kernel{
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      soda.cgra.fusion {pattern = "add_max_add"} %arg0, %arg1, %arg2, %arg3 : memref<4x8xf32, #map0>, memref<4x8xf32, #map0>, memref<4x8xf32, #map0>, memref<4x8xf32, #map0>
      soda.return
    }
  }
}

