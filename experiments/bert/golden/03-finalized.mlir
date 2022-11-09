#map0 = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (0, 0, 0, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> ()>
#map5 = affine_map<(d0, d1) -> (d0 * 512 + d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map8 = affine_map<(d0, d1, d2) -> (0, d1, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map10 = affine_map<(d0, d1, d2) -> (0, d1, 0)>
#map11 = affine_map<(d0, d1, d2) -> (d2)>
#map12 = affine_map<(d0, d1) -> (d1, d0)>
#map13 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map14 = affine_map<(d0, d1, d2, d3) -> (d0, d2, d1, d3)>
#map15 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3, d2)>
#map16 = affine_map<(d0, d1, d2, d3) -> (0, d1, d2, d3)>
#map17 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
#map18 = affine_map<(d0, d1, d2, d3) -> (0, d1, d2, 0)>
#map19 = affine_map<(d0, d1, d2) -> (d0 * 4608 + d1 * 384 + d2)>
#map20 = affine_map<(d0, d1) -> (d0 * 4608 + d1)>
#map21 = affine_map<(d0, d1) -> (d1)>
module attributes {torch.debug_module_name = "OnlyLogitsHuggingFaceModel"} {
  memref.global "private" constant @__constant_xf64_0 : memref<f64> = dense<-3.4028234663852886E+38>
  memref.global "private" constant @__constant_1x512xi64 : memref<1x512xi64> = dense_resource<__elided__>
  memref.global "private" constant @__constant_30522x384xf32 : memref<30522x384xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_512x384xf32 : memref<512x384xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_xf64 : memref<f64> = dense<5.6568542494923806>
  memref.global "private" constant @__constant_1536xf32 : memref<1536xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_1536x384xf32 : memref<1536x384xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_384x1536xf32 : memref<384x1536xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_384xf32 : memref<384xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_384x384xf32 : memref<384x384xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_2xf32 : memref<2xf32> = dense<[-0.00115577725, 0.00115577038]>
  memref.global "private" constant @__constant_2x384xf32 : memref<2x384xf32> = dense_resource<__elided__>
  memref.global "private" constant @__constant_1x12xi64 : memref<1x12xi64> = dense<0>
  func.func @forward(%arg0: memref<1x12xi64>, %arg1: memref<1x2xf32>) {
    %c2 = arith.constant 2 : index
    %cst = arith.constant 3.840000e+02 : f32
    %cst_0 = arith.constant 9.9999999999999998E-13 : f64
    %c0_i64 = arith.constant 0 : i64
    %cst_1 = arith.constant 5.000000e-01 : f32
    %cst_2 = arith.constant 1.41421354 : f32
    %cst_3 = arith.constant -3.40282347E+38 : f32
    %cst_4 = arith.constant 0.000000e+00 : f32
    %c30522 = arith.constant 30522 : index
    %c512 = arith.constant 512 : index
    %cst_5 = arith.constant 1.000000e+00 : f32
    %0 = memref.get_global @__constant_1x12xi64 : memref<1x12xi64>
    %1 = memref.get_global @__constant_2x384xf32 : memref<2x384xf32>
    %2 = memref.get_global @__constant_2xf32 : memref<2xf32>
    %3 = memref.get_global @__constant_384x384xf32 : memref<384x384xf32>
    %4 = memref.get_global @__constant_384xf32 : memref<384xf32>
    %5 = memref.get_global @__constant_384x1536xf32 : memref<384x1536xf32>
    %6 = memref.get_global @__constant_1536x384xf32 : memref<1536x384xf32>
    %7 = memref.get_global @__constant_1536xf32 : memref<1536xf32>
    %8 = memref.get_global @__constant_xf64 : memref<f64>
    %9 = memref.get_global @__constant_512x384xf32 : memref<512x384xf32>
    %10 = memref.get_global @__constant_30522x384xf32 : memref<30522x384xf32>
    %11 = memref.get_global @__constant_1x512xi64 : memref<1x512xi64>
    %12 = memref.get_global @__constant_xf64_0 : memref<f64>
    %13 = memref.alloc() {alignment = 128 : i64} : memref<1x12xi64>
    linalg.generic {indexing_maps = [#map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%0 : memref<1x12xi64>) outs(%13 : memref<1x12xi64>) {
    ^bb0(%arg2: i64, %arg3: i64):
      linalg.yield %arg2 : i64
    }
    %14 = memref.alloc() {alignment = 128 : i64} : memref<1x1x1x12xf32>
    linalg.fill ins(%cst_5 : f32) outs(%14 : memref<1x1x1x12xf32>)
    %15 = memref.alloc() {alignment = 128 : i64} : memref<1x1x1x12xf32>
    linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%14 : memref<1x1x1x12xf32>) outs(%15 : memref<1x1x1x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.subf %cst_5, %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %14 : memref<1x1x1x12xf32>
    %16 = memref.alloc() {alignment = 128 : i64} : memref<1x1x1x12xf32>
    linalg.generic {indexing_maps = [#map2, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%15, %12 : memref<1x1x1x12xf32>, memref<f64>) outs(%16 : memref<1x1x1x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f64, %arg4: f32):
      %669 = arith.truncf %arg3 : f64 to f32
      %670 = arith.mulf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %15 : memref<1x1x1x12xf32>
    %17 = memref.subview %11[0, 0] [1, 12] [1, 1] : memref<1x512xi64> to memref<1x12xi64, #map5>
    %18 = memref.alloc() : memref<1x12xi64>
    memref.copy %17, %18 : memref<1x12xi64, #map5> to memref<1x12xi64>
    %19 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map6, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : memref<1x12xi64>) outs(%19 : memref<1x12x384xf32>) {
    ^bb0(%arg2: i64, %arg3: f32):
      %669 = arith.index_cast %arg2 : i64 to index
      %670 = linalg.index 2 : index
      %671 = arith.cmpi slt, %669, %c30522 : index
      cf.assert %671, "index must be smaller than dim size"
      %672 = arith.cmpi sge, %arg2, %c0_i64 : i64
      cf.assert %672, "index must be larger or equal to 0"
      %673 = memref.load %10[%669, %670] : memref<30522x384xf32>
      linalg.yield %673 : f32
    }
    %20 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map6, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13 : memref<1x12xi64>) outs(%20 : memref<1x12x384xf32>) {
    ^bb0(%arg2: i64, %arg3: f32):
      %669 = arith.index_cast %arg2 : i64 to index
      %670 = linalg.index 2 : index
      %671 = arith.cmpi slt, %669, %c2 : index
      cf.assert %671, "index must be smaller than dim size"
      %672 = arith.cmpi sge, %arg2, %c0_i64 : i64
      cf.assert %672, "index must be larger or equal to 0"
      %673 = memref.load %1[%669, %670] : memref<2x384xf32>
      linalg.yield %673 : f32
    }
    memref.dealloc %13 : memref<1x12xi64>
    %21 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%19, %20 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%21 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %20 : memref<1x12x384xf32>
    memref.dealloc %19 : memref<1x12x384xf32>
    %22 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map6, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%18 : memref<1x12xi64>) outs(%22 : memref<1x12x384xf32>) {
    ^bb0(%arg2: i64, %arg3: f32):
      %669 = arith.index_cast %arg2 : i64 to index
      %670 = linalg.index 2 : index
      %671 = arith.cmpi slt, %669, %c512 : index
      cf.assert %671, "index must be smaller than dim size"
      %672 = arith.cmpi sge, %arg2, %c0_i64 : i64
      cf.assert %672, "index must be larger or equal to 0"
      %673 = memref.load %9[%669, %670] : memref<512x384xf32>
      linalg.yield %673 : f32
    }
    memref.dealloc %18 : memref<1x12xi64>
    %23 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%21, %22 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%23 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %22 : memref<1x12x384xf32>
    memref.dealloc %21 : memref<1x12x384xf32>
    %24 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%24 : memref<1x12x1xf32>)
    %25 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %24, %25 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %24 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%23 : memref<1x12x384xf32>) outs(%25 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %26 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%25 : memref<1x12x1xf32>) outs(%26 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %25 : memref<1x12x1xf32>
    %27 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%26 : memref<1x12x1xf32>) outs(%27 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %26 : memref<1x12x1xf32>
    %28 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%23, %27 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%28 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %27 : memref<1x12x384xf32>
    memref.dealloc %23 : memref<1x12x384xf32>
    %29 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%28 : memref<1x12x384xf32>) outs(%29 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %30 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%30 : memref<1x12x1xf32>)
    %31 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %30, %31 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %30 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%29 : memref<1x12x384xf32>) outs(%31 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %29 : memref<1x12x384xf32>
    %32 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%31 : memref<1x12x1xf32>) outs(%32 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %31 : memref<1x12x1xf32>
    %33 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%32 : memref<1x12x1xf32>) outs(%33 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %32 : memref<1x12x1xf32>
    %34 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%33 : memref<1x12x1xf32>) outs(%34 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %33 : memref<1x12x1xf32>
    %35 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%34 : memref<1x12x1xf32>) outs(%35 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %34 : memref<1x12x1xf32>
    %36 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%28, %35 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%36 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %35 : memref<1x12x384xf32>
    memref.dealloc %28 : memref<1x12x384xf32>
    %37 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%36, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%37 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %36 : memref<1x12x384xf32>
    %38 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%37, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%38 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %37 : memref<1x12x384xf32>
    %39 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%39 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %40 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%38 : memref<1x12x384xf32>) outs(%40 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %41 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%39 : memref<384x384xf32>) outs(%41 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %39 : memref<384x384xf32>
    %42 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%42 : memref<1x12x384xf32>)
    %43 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %42, %43 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %42 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%40, %41 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%43 : memref<1x12x384xf32>)
    memref.dealloc %41 : memref<1x384x384xf32>
    memref.dealloc %40 : memref<1x12x384xf32>
    %44 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%43, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%44 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %43 : memref<1x12x384xf32>
    %45 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%45 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %46 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%38 : memref<1x12x384xf32>) outs(%46 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %47 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%45 : memref<384x384xf32>) outs(%47 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %45 : memref<384x384xf32>
    %48 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%48 : memref<1x12x384xf32>)
    %49 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %48, %49 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %48 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%46, %47 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%49 : memref<1x12x384xf32>)
    memref.dealloc %47 : memref<1x384x384xf32>
    memref.dealloc %46 : memref<1x12x384xf32>
    %50 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%49, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%50 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %49 : memref<1x12x384xf32>
    %51 = memref.expand_shape %50 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %52 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%51 : memref<1x12x12x32xf32>) outs(%52 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %50 : memref<1x12x384xf32>
    %53 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%53 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %54 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%38 : memref<1x12x384xf32>) outs(%54 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %55 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53 : memref<384x384xf32>) outs(%55 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %53 : memref<384x384xf32>
    %56 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%56 : memref<1x12x384xf32>)
    %57 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %56, %57 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %56 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%54, %55 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%57 : memref<1x12x384xf32>)
    memref.dealloc %55 : memref<1x384x384xf32>
    memref.dealloc %54 : memref<1x12x384xf32>
    %58 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%57, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%58 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %57 : memref<1x12x384xf32>
    %59 = memref.expand_shape %58 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %60 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%59 : memref<1x12x12x32xf32>) outs(%60 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %58 : memref<1x12x384xf32>
    %61 = memref.expand_shape %44 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %62 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%61 : memref<1x12x12x32xf32>) outs(%62 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %44 : memref<1x12x384xf32>
    %63 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map3, #map15], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%52 : memref<1x12x12x32xf32>) outs(%63 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %52 : memref<1x12x12x32xf32>
    %64 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%62 : memref<1x12x12x32xf32>) outs(%64 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %62 : memref<1x12x12x32xf32>
    %65 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%63 : memref<1x12x32x12xf32>) outs(%65 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %63 : memref<1x12x32x12xf32>
    %66 = memref.collapse_shape %64 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %67 = memref.collapse_shape %65 [[0, 1], [2], [3]] : memref<1x12x32x12xf32> into memref<12x32x12xf32>
    %68 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    linalg.fill ins(%cst_4 : f32) outs(%68 : memref<12x12x12xf32>)
    %69 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    memref.copy %68, %69 : memref<12x12x12xf32> to memref<12x12x12xf32>
    memref.dealloc %68 : memref<12x12x12xf32>
    linalg.batch_matmul ins(%66, %67 : memref<12x12x32xf32>, memref<12x32x12xf32>) outs(%69 : memref<12x12x12xf32>)
    memref.dealloc %65 : memref<1x12x32x12xf32>
    memref.dealloc %64 : memref<1x12x12x32xf32>
    %70 = memref.expand_shape %69 [[0, 1], [2], [3]] : memref<12x12x12xf32> into memref<1x12x12x12xf32>
    %71 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%70, %8 : memref<1x12x12x12xf32>, memref<f64>) outs(%71 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f64, %arg4: f32):
      %669 = arith.truncf %arg3 : f64 to f32
      %670 = arith.divf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %69 : memref<12x12x12xf32>
    %72 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%71, %16 : memref<1x12x12x12xf32>, memref<1x1x1x12xf32>) outs(%72 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %71 : memref<1x12x12x12xf32>
    %73 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%73 : memref<1x12x12x1xi64>)
    %74 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_3 : f32) outs(%74 : memref<1x12x12x1xf32>)
    %75 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %74, %75 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %74 : memref<1x12x12x1xf32>
    %76 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    memref.copy %73, %76 : memref<1x12x12x1xi64> to memref<1x12x12x1xi64>
    memref.dealloc %73 : memref<1x12x12x1xi64>
    linalg.generic {indexing_maps = [#map3, #map17, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%72 : memref<1x12x12x12xf32>) outs(%75, %76 : memref<1x12x12x1xf32>, memref<1x12x12x1xi64>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i64):
      %669 = linalg.index 3 : index
      %670 = arith.index_cast %669 : index to i64
      %671 = arith.maxf %arg2, %arg3 : f32
      %672 = arith.cmpf ogt, %arg2, %arg3 : f32
      %673 = arith.select %672, %670, %arg4 : i64
      linalg.yield %671, %673 : f32, i64
    }
    memref.dealloc %76 : memref<1x12x12x1xi64>
    %77 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%72, %75 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%77 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %75 : memref<1x12x12x1xf32>
    memref.dealloc %72 : memref<1x12x12x12xf32>
    %78 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%77 : memref<1x12x12x12xf32>) outs(%78 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.exp %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %77 : memref<1x12x12x12xf32>
    %79 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%79 : memref<1x12x12x1xf32>)
    %80 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %79, %80 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %79 : memref<1x12x12x1xf32>
    linalg.generic {indexing_maps = [#map3, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%78 : memref<1x12x12x12xf32>) outs(%80 : memref<1x12x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %81 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%78, %80 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%81 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.divf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %80 : memref<1x12x12x1xf32>
    memref.dealloc %78 : memref<1x12x12x12xf32>
    %82 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%81 : memref<1x12x12x12xf32>) outs(%82 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %81 : memref<1x12x12x12xf32>
    %83 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%60 : memref<1x12x12x32xf32>) outs(%83 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %60 : memref<1x12x12x32xf32>
    %84 = memref.collapse_shape %82 [[0, 1], [2], [3]] : memref<1x12x12x12xf32> into memref<12x12x12xf32>
    %85 = memref.collapse_shape %83 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %86 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    linalg.fill ins(%cst_4 : f32) outs(%86 : memref<12x12x32xf32>)
    %87 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    memref.copy %86, %87 : memref<12x12x32xf32> to memref<12x12x32xf32>
    memref.dealloc %86 : memref<12x12x32xf32>
    linalg.batch_matmul ins(%84, %85 : memref<12x12x12xf32>, memref<12x12x32xf32>) outs(%87 : memref<12x12x32xf32>)
    memref.dealloc %83 : memref<1x12x12x32xf32>
    memref.dealloc %82 : memref<1x12x12x12xf32>
    %88 = memref.expand_shape %87 [[0, 1], [2], [3]] : memref<12x12x32xf32> into memref<1x12x12x32xf32>
    %89 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%88 : memref<1x12x12x32xf32>) outs(%89 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %87 : memref<12x12x32xf32>
    %90 = memref.collapse_shape %89 [[0], [1], [2, 3]] : memref<1x12x12x32xf32> into memref<1x12x384xf32>
    %91 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%91 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %92 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%90 : memref<1x12x384xf32>) outs(%92 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %89 : memref<1x12x12x32xf32>
    %93 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%91 : memref<384x384xf32>) outs(%93 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %91 : memref<384x384xf32>
    %94 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%94 : memref<1x12x384xf32>)
    %95 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %94, %95 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %94 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%92, %93 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%95 : memref<1x12x384xf32>)
    memref.dealloc %93 : memref<1x384x384xf32>
    memref.dealloc %92 : memref<1x12x384xf32>
    %96 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%95, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%96 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %95 : memref<1x12x384xf32>
    %97 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%96, %38 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%97 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %96 : memref<1x12x384xf32>
    memref.dealloc %38 : memref<1x12x384xf32>
    %98 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%98 : memref<1x12x1xf32>)
    %99 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %98, %99 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %98 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%97 : memref<1x12x384xf32>) outs(%99 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %100 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%99 : memref<1x12x1xf32>) outs(%100 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %99 : memref<1x12x1xf32>
    %101 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%100 : memref<1x12x1xf32>) outs(%101 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %100 : memref<1x12x1xf32>
    %102 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%97, %101 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%102 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %101 : memref<1x12x384xf32>
    memref.dealloc %97 : memref<1x12x384xf32>
    %103 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%102 : memref<1x12x384xf32>) outs(%103 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %104 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%104 : memref<1x12x1xf32>)
    %105 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %104, %105 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %104 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%103 : memref<1x12x384xf32>) outs(%105 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %103 : memref<1x12x384xf32>
    %106 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%105 : memref<1x12x1xf32>) outs(%106 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %105 : memref<1x12x1xf32>
    %107 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%106 : memref<1x12x1xf32>) outs(%107 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %106 : memref<1x12x1xf32>
    %108 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%107 : memref<1x12x1xf32>) outs(%108 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %107 : memref<1x12x1xf32>
    %109 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%108 : memref<1x12x1xf32>) outs(%109 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %108 : memref<1x12x1xf32>
    %110 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%102, %109 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%110 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %109 : memref<1x12x384xf32>
    memref.dealloc %102 : memref<1x12x384xf32>
    %111 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%110, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%111 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %110 : memref<1x12x384xf32>
    %112 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%111, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%112 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %111 : memref<1x12x384xf32>
    %113 = memref.alloc() {alignment = 128 : i64} : memref<384x1536xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%6 : memref<1536x384xf32>) outs(%113 : memref<384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %114 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%112 : memref<1x12x384xf32>) outs(%114 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %115 = memref.alloc() {alignment = 128 : i64} : memref<1x384x1536xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%113 : memref<384x1536xf32>) outs(%115 : memref<1x384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %113 : memref<384x1536xf32>
    %116 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.fill ins(%cst_4 : f32) outs(%116 : memref<1x12x1536xf32>)
    %117 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    memref.copy %116, %117 : memref<1x12x1536xf32> to memref<1x12x1536xf32>
    memref.dealloc %116 : memref<1x12x1536xf32>
    linalg.batch_matmul ins(%114, %115 : memref<1x12x384xf32>, memref<1x384x1536xf32>) outs(%117 : memref<1x12x1536xf32>)
    memref.dealloc %115 : memref<1x384x1536xf32>
    memref.dealloc %114 : memref<1x12x384xf32>
    %118 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%117, %7 : memref<1x12x1536xf32>, memref<1536xf32>) outs(%118 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %117 : memref<1x12x1536xf32>
    %119 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%118 : memref<1x12x1536xf32>) outs(%119 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst_2 : f32
      %670 = math.erf %669 : f32
      %671 = arith.addf %670, %cst_5 : f32
      %672 = arith.mulf %671, %cst_1 : f32
      %673 = arith.mulf %arg2, %672 : f32
      linalg.yield %673 : f32
    }
    memref.dealloc %118 : memref<1x12x1536xf32>
    %120 = memref.alloc() {alignment = 128 : i64} : memref<1536x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%5 : memref<384x1536xf32>) outs(%120 : memref<1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %121 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%119 : memref<1x12x1536xf32>) outs(%121 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %119 : memref<1x12x1536xf32>
    %122 = memref.alloc() {alignment = 128 : i64} : memref<1x1536x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%120 : memref<1536x384xf32>) outs(%122 : memref<1x1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %120 : memref<1536x384xf32>
    %123 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%123 : memref<1x12x384xf32>)
    %124 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %123, %124 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %123 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%121, %122 : memref<1x12x1536xf32>, memref<1x1536x384xf32>) outs(%124 : memref<1x12x384xf32>)
    memref.dealloc %122 : memref<1x1536x384xf32>
    memref.dealloc %121 : memref<1x12x1536xf32>
    %125 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%124, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%125 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %124 : memref<1x12x384xf32>
    %126 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%125, %112 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%126 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %125 : memref<1x12x384xf32>
    memref.dealloc %112 : memref<1x12x384xf32>
    %127 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%127 : memref<1x12x1xf32>)
    %128 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %127, %128 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %127 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%126 : memref<1x12x384xf32>) outs(%128 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %129 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%128 : memref<1x12x1xf32>) outs(%129 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %128 : memref<1x12x1xf32>
    %130 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%129 : memref<1x12x1xf32>) outs(%130 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %129 : memref<1x12x1xf32>
    %131 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%126, %130 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%131 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %130 : memref<1x12x384xf32>
    memref.dealloc %126 : memref<1x12x384xf32>
    %132 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%131 : memref<1x12x384xf32>) outs(%132 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %133 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%133 : memref<1x12x1xf32>)
    %134 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %133, %134 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %133 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%132 : memref<1x12x384xf32>) outs(%134 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %132 : memref<1x12x384xf32>
    %135 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%134 : memref<1x12x1xf32>) outs(%135 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %134 : memref<1x12x1xf32>
    %136 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%135 : memref<1x12x1xf32>) outs(%136 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %135 : memref<1x12x1xf32>
    %137 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%136 : memref<1x12x1xf32>) outs(%137 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %136 : memref<1x12x1xf32>
    %138 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%137 : memref<1x12x1xf32>) outs(%138 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %137 : memref<1x12x1xf32>
    %139 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%131, %138 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%139 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %138 : memref<1x12x384xf32>
    memref.dealloc %131 : memref<1x12x384xf32>
    %140 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%139, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%140 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %139 : memref<1x12x384xf32>
    %141 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%140, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%141 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %140 : memref<1x12x384xf32>
    %142 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%142 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %143 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%141 : memref<1x12x384xf32>) outs(%143 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %144 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%142 : memref<384x384xf32>) outs(%144 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %142 : memref<384x384xf32>
    %145 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%145 : memref<1x12x384xf32>)
    %146 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %145, %146 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %145 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%143, %144 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%146 : memref<1x12x384xf32>)
    memref.dealloc %144 : memref<1x384x384xf32>
    memref.dealloc %143 : memref<1x12x384xf32>
    %147 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%146, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%147 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %146 : memref<1x12x384xf32>
    %148 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%148 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %149 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%141 : memref<1x12x384xf32>) outs(%149 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %150 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%148 : memref<384x384xf32>) outs(%150 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %148 : memref<384x384xf32>
    %151 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%151 : memref<1x12x384xf32>)
    %152 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %151, %152 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %151 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%149, %150 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%152 : memref<1x12x384xf32>)
    memref.dealloc %150 : memref<1x384x384xf32>
    memref.dealloc %149 : memref<1x12x384xf32>
    %153 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%152, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%153 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %152 : memref<1x12x384xf32>
    %154 = memref.expand_shape %153 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %155 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%154 : memref<1x12x12x32xf32>) outs(%155 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %153 : memref<1x12x384xf32>
    %156 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%156 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %157 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%141 : memref<1x12x384xf32>) outs(%157 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %158 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%156 : memref<384x384xf32>) outs(%158 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %156 : memref<384x384xf32>
    %159 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%159 : memref<1x12x384xf32>)
    %160 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %159, %160 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %159 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%157, %158 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%160 : memref<1x12x384xf32>)
    memref.dealloc %158 : memref<1x384x384xf32>
    memref.dealloc %157 : memref<1x12x384xf32>
    %161 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%160, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%161 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %160 : memref<1x12x384xf32>
    %162 = memref.expand_shape %161 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %163 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%162 : memref<1x12x12x32xf32>) outs(%163 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %161 : memref<1x12x384xf32>
    %164 = memref.expand_shape %147 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %165 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%164 : memref<1x12x12x32xf32>) outs(%165 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %147 : memref<1x12x384xf32>
    %166 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map3, #map15], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%155 : memref<1x12x12x32xf32>) outs(%166 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %155 : memref<1x12x12x32xf32>
    %167 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%165 : memref<1x12x12x32xf32>) outs(%167 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %165 : memref<1x12x12x32xf32>
    %168 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%166 : memref<1x12x32x12xf32>) outs(%168 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %166 : memref<1x12x32x12xf32>
    %169 = memref.collapse_shape %167 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %170 = memref.collapse_shape %168 [[0, 1], [2], [3]] : memref<1x12x32x12xf32> into memref<12x32x12xf32>
    %171 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    linalg.fill ins(%cst_4 : f32) outs(%171 : memref<12x12x12xf32>)
    %172 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    memref.copy %171, %172 : memref<12x12x12xf32> to memref<12x12x12xf32>
    memref.dealloc %171 : memref<12x12x12xf32>
    linalg.batch_matmul ins(%169, %170 : memref<12x12x32xf32>, memref<12x32x12xf32>) outs(%172 : memref<12x12x12xf32>)
    memref.dealloc %168 : memref<1x12x32x12xf32>
    memref.dealloc %167 : memref<1x12x12x32xf32>
    %173 = memref.expand_shape %172 [[0, 1], [2], [3]] : memref<12x12x12xf32> into memref<1x12x12x12xf32>
    %174 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%173, %8 : memref<1x12x12x12xf32>, memref<f64>) outs(%174 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f64, %arg4: f32):
      %669 = arith.truncf %arg3 : f64 to f32
      %670 = arith.divf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %172 : memref<12x12x12xf32>
    %175 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%174, %16 : memref<1x12x12x12xf32>, memref<1x1x1x12xf32>) outs(%175 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %174 : memref<1x12x12x12xf32>
    %176 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%176 : memref<1x12x12x1xi64>)
    %177 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_3 : f32) outs(%177 : memref<1x12x12x1xf32>)
    %178 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %177, %178 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %177 : memref<1x12x12x1xf32>
    %179 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    memref.copy %176, %179 : memref<1x12x12x1xi64> to memref<1x12x12x1xi64>
    memref.dealloc %176 : memref<1x12x12x1xi64>
    linalg.generic {indexing_maps = [#map3, #map17, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%175 : memref<1x12x12x12xf32>) outs(%178, %179 : memref<1x12x12x1xf32>, memref<1x12x12x1xi64>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i64):
      %669 = linalg.index 3 : index
      %670 = arith.index_cast %669 : index to i64
      %671 = arith.maxf %arg2, %arg3 : f32
      %672 = arith.cmpf ogt, %arg2, %arg3 : f32
      %673 = arith.select %672, %670, %arg4 : i64
      linalg.yield %671, %673 : f32, i64
    }
    memref.dealloc %179 : memref<1x12x12x1xi64>
    %180 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%175, %178 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%180 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %178 : memref<1x12x12x1xf32>
    memref.dealloc %175 : memref<1x12x12x12xf32>
    %181 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%180 : memref<1x12x12x12xf32>) outs(%181 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.exp %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %180 : memref<1x12x12x12xf32>
    %182 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%182 : memref<1x12x12x1xf32>)
    %183 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %182, %183 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %182 : memref<1x12x12x1xf32>
    linalg.generic {indexing_maps = [#map3, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%181 : memref<1x12x12x12xf32>) outs(%183 : memref<1x12x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %184 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%181, %183 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%184 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.divf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %183 : memref<1x12x12x1xf32>
    memref.dealloc %181 : memref<1x12x12x12xf32>
    %185 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%184 : memref<1x12x12x12xf32>) outs(%185 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %184 : memref<1x12x12x12xf32>
    %186 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%163 : memref<1x12x12x32xf32>) outs(%186 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %163 : memref<1x12x12x32xf32>
    %187 = memref.collapse_shape %185 [[0, 1], [2], [3]] : memref<1x12x12x12xf32> into memref<12x12x12xf32>
    %188 = memref.collapse_shape %186 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %189 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    linalg.fill ins(%cst_4 : f32) outs(%189 : memref<12x12x32xf32>)
    %190 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    memref.copy %189, %190 : memref<12x12x32xf32> to memref<12x12x32xf32>
    memref.dealloc %189 : memref<12x12x32xf32>
    linalg.batch_matmul ins(%187, %188 : memref<12x12x12xf32>, memref<12x12x32xf32>) outs(%190 : memref<12x12x32xf32>)
    memref.dealloc %186 : memref<1x12x12x32xf32>
    memref.dealloc %185 : memref<1x12x12x12xf32>
    %191 = memref.expand_shape %190 [[0, 1], [2], [3]] : memref<12x12x32xf32> into memref<1x12x12x32xf32>
    %192 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%191 : memref<1x12x12x32xf32>) outs(%192 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %190 : memref<12x12x32xf32>
    %193 = memref.collapse_shape %192 [[0], [1], [2, 3]] : memref<1x12x12x32xf32> into memref<1x12x384xf32>
    %194 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%194 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %195 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%193 : memref<1x12x384xf32>) outs(%195 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %192 : memref<1x12x12x32xf32>
    %196 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%194 : memref<384x384xf32>) outs(%196 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %194 : memref<384x384xf32>
    %197 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%197 : memref<1x12x384xf32>)
    %198 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %197, %198 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %197 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%195, %196 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%198 : memref<1x12x384xf32>)
    memref.dealloc %196 : memref<1x384x384xf32>
    memref.dealloc %195 : memref<1x12x384xf32>
    %199 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%198, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%199 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %198 : memref<1x12x384xf32>
    %200 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%199, %141 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%200 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %199 : memref<1x12x384xf32>
    memref.dealloc %141 : memref<1x12x384xf32>
    %201 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%201 : memref<1x12x1xf32>)
    %202 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %201, %202 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %201 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%200 : memref<1x12x384xf32>) outs(%202 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %203 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%202 : memref<1x12x1xf32>) outs(%203 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %202 : memref<1x12x1xf32>
    %204 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%203 : memref<1x12x1xf32>) outs(%204 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %203 : memref<1x12x1xf32>
    %205 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%200, %204 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%205 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %204 : memref<1x12x384xf32>
    memref.dealloc %200 : memref<1x12x384xf32>
    %206 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%205 : memref<1x12x384xf32>) outs(%206 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %207 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%207 : memref<1x12x1xf32>)
    %208 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %207, %208 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %207 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%206 : memref<1x12x384xf32>) outs(%208 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %206 : memref<1x12x384xf32>
    %209 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%208 : memref<1x12x1xf32>) outs(%209 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %208 : memref<1x12x1xf32>
    %210 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%209 : memref<1x12x1xf32>) outs(%210 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %209 : memref<1x12x1xf32>
    %211 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%210 : memref<1x12x1xf32>) outs(%211 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %210 : memref<1x12x1xf32>
    %212 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%211 : memref<1x12x1xf32>) outs(%212 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %211 : memref<1x12x1xf32>
    %213 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%205, %212 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%213 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %212 : memref<1x12x384xf32>
    memref.dealloc %205 : memref<1x12x384xf32>
    %214 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%213, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%214 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %213 : memref<1x12x384xf32>
    %215 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%214, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%215 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %214 : memref<1x12x384xf32>
    %216 = memref.alloc() {alignment = 128 : i64} : memref<384x1536xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%6 : memref<1536x384xf32>) outs(%216 : memref<384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %217 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%215 : memref<1x12x384xf32>) outs(%217 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %218 = memref.alloc() {alignment = 128 : i64} : memref<1x384x1536xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%216 : memref<384x1536xf32>) outs(%218 : memref<1x384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %216 : memref<384x1536xf32>
    %219 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.fill ins(%cst_4 : f32) outs(%219 : memref<1x12x1536xf32>)
    %220 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    memref.copy %219, %220 : memref<1x12x1536xf32> to memref<1x12x1536xf32>
    memref.dealloc %219 : memref<1x12x1536xf32>
    linalg.batch_matmul ins(%217, %218 : memref<1x12x384xf32>, memref<1x384x1536xf32>) outs(%220 : memref<1x12x1536xf32>)
    memref.dealloc %218 : memref<1x384x1536xf32>
    memref.dealloc %217 : memref<1x12x384xf32>
    %221 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%220, %7 : memref<1x12x1536xf32>, memref<1536xf32>) outs(%221 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %220 : memref<1x12x1536xf32>
    %222 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%221 : memref<1x12x1536xf32>) outs(%222 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst_2 : f32
      %670 = math.erf %669 : f32
      %671 = arith.addf %670, %cst_5 : f32
      %672 = arith.mulf %671, %cst_1 : f32
      %673 = arith.mulf %arg2, %672 : f32
      linalg.yield %673 : f32
    }
    memref.dealloc %221 : memref<1x12x1536xf32>
    %223 = memref.alloc() {alignment = 128 : i64} : memref<1536x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%5 : memref<384x1536xf32>) outs(%223 : memref<1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %224 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%222 : memref<1x12x1536xf32>) outs(%224 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %222 : memref<1x12x1536xf32>
    %225 = memref.alloc() {alignment = 128 : i64} : memref<1x1536x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%223 : memref<1536x384xf32>) outs(%225 : memref<1x1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %223 : memref<1536x384xf32>
    %226 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%226 : memref<1x12x384xf32>)
    %227 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %226, %227 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %226 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%224, %225 : memref<1x12x1536xf32>, memref<1x1536x384xf32>) outs(%227 : memref<1x12x384xf32>)
    memref.dealloc %225 : memref<1x1536x384xf32>
    memref.dealloc %224 : memref<1x12x1536xf32>
    %228 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%227, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%228 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %227 : memref<1x12x384xf32>
    %229 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%228, %215 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%229 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %228 : memref<1x12x384xf32>
    memref.dealloc %215 : memref<1x12x384xf32>
    %230 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%230 : memref<1x12x1xf32>)
    %231 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %230, %231 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %230 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%229 : memref<1x12x384xf32>) outs(%231 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %232 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%231 : memref<1x12x1xf32>) outs(%232 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %231 : memref<1x12x1xf32>
    %233 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%232 : memref<1x12x1xf32>) outs(%233 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %232 : memref<1x12x1xf32>
    %234 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%229, %233 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%234 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %233 : memref<1x12x384xf32>
    memref.dealloc %229 : memref<1x12x384xf32>
    %235 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%234 : memref<1x12x384xf32>) outs(%235 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %236 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%236 : memref<1x12x1xf32>)
    %237 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %236, %237 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %236 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%235 : memref<1x12x384xf32>) outs(%237 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %235 : memref<1x12x384xf32>
    %238 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%237 : memref<1x12x1xf32>) outs(%238 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %237 : memref<1x12x1xf32>
    %239 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%238 : memref<1x12x1xf32>) outs(%239 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %238 : memref<1x12x1xf32>
    %240 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%239 : memref<1x12x1xf32>) outs(%240 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %239 : memref<1x12x1xf32>
    %241 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%240 : memref<1x12x1xf32>) outs(%241 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %240 : memref<1x12x1xf32>
    %242 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%234, %241 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%242 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %241 : memref<1x12x384xf32>
    memref.dealloc %234 : memref<1x12x384xf32>
    %243 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%242, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%243 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %242 : memref<1x12x384xf32>
    %244 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%243, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%244 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %243 : memref<1x12x384xf32>
    %245 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%245 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %246 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%244 : memref<1x12x384xf32>) outs(%246 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %247 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%245 : memref<384x384xf32>) outs(%247 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %245 : memref<384x384xf32>
    %248 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%248 : memref<1x12x384xf32>)
    %249 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %248, %249 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %248 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%246, %247 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%249 : memref<1x12x384xf32>)
    memref.dealloc %247 : memref<1x384x384xf32>
    memref.dealloc %246 : memref<1x12x384xf32>
    %250 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%249, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%250 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %249 : memref<1x12x384xf32>
    %251 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%251 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %252 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%244 : memref<1x12x384xf32>) outs(%252 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %253 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%251 : memref<384x384xf32>) outs(%253 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %251 : memref<384x384xf32>
    %254 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%254 : memref<1x12x384xf32>)
    %255 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %254, %255 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %254 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%252, %253 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%255 : memref<1x12x384xf32>)
    memref.dealloc %253 : memref<1x384x384xf32>
    memref.dealloc %252 : memref<1x12x384xf32>
    %256 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%255, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%256 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %255 : memref<1x12x384xf32>
    %257 = memref.expand_shape %256 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %258 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%257 : memref<1x12x12x32xf32>) outs(%258 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %256 : memref<1x12x384xf32>
    %259 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%259 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %260 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%244 : memref<1x12x384xf32>) outs(%260 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %261 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%259 : memref<384x384xf32>) outs(%261 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %259 : memref<384x384xf32>
    %262 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%262 : memref<1x12x384xf32>)
    %263 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %262, %263 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %262 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%260, %261 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%263 : memref<1x12x384xf32>)
    memref.dealloc %261 : memref<1x384x384xf32>
    memref.dealloc %260 : memref<1x12x384xf32>
    %264 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%263, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%264 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %263 : memref<1x12x384xf32>
    %265 = memref.expand_shape %264 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %266 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%265 : memref<1x12x12x32xf32>) outs(%266 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %264 : memref<1x12x384xf32>
    %267 = memref.expand_shape %250 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %268 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%267 : memref<1x12x12x32xf32>) outs(%268 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %250 : memref<1x12x384xf32>
    %269 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map3, #map15], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%258 : memref<1x12x12x32xf32>) outs(%269 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %258 : memref<1x12x12x32xf32>
    %270 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%268 : memref<1x12x12x32xf32>) outs(%270 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %268 : memref<1x12x12x32xf32>
    %271 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%269 : memref<1x12x32x12xf32>) outs(%271 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %269 : memref<1x12x32x12xf32>
    %272 = memref.collapse_shape %270 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %273 = memref.collapse_shape %271 [[0, 1], [2], [3]] : memref<1x12x32x12xf32> into memref<12x32x12xf32>
    %274 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    linalg.fill ins(%cst_4 : f32) outs(%274 : memref<12x12x12xf32>)
    %275 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    memref.copy %274, %275 : memref<12x12x12xf32> to memref<12x12x12xf32>
    memref.dealloc %274 : memref<12x12x12xf32>
    linalg.batch_matmul ins(%272, %273 : memref<12x12x32xf32>, memref<12x32x12xf32>) outs(%275 : memref<12x12x12xf32>)
    memref.dealloc %271 : memref<1x12x32x12xf32>
    memref.dealloc %270 : memref<1x12x12x32xf32>
    %276 = memref.expand_shape %275 [[0, 1], [2], [3]] : memref<12x12x12xf32> into memref<1x12x12x12xf32>
    %277 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%276, %8 : memref<1x12x12x12xf32>, memref<f64>) outs(%277 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f64, %arg4: f32):
      %669 = arith.truncf %arg3 : f64 to f32
      %670 = arith.divf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %275 : memref<12x12x12xf32>
    %278 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%277, %16 : memref<1x12x12x12xf32>, memref<1x1x1x12xf32>) outs(%278 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %277 : memref<1x12x12x12xf32>
    %279 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%279 : memref<1x12x12x1xi64>)
    %280 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_3 : f32) outs(%280 : memref<1x12x12x1xf32>)
    %281 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %280, %281 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %280 : memref<1x12x12x1xf32>
    %282 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    memref.copy %279, %282 : memref<1x12x12x1xi64> to memref<1x12x12x1xi64>
    memref.dealloc %279 : memref<1x12x12x1xi64>
    linalg.generic {indexing_maps = [#map3, #map17, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%278 : memref<1x12x12x12xf32>) outs(%281, %282 : memref<1x12x12x1xf32>, memref<1x12x12x1xi64>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i64):
      %669 = linalg.index 3 : index
      %670 = arith.index_cast %669 : index to i64
      %671 = arith.maxf %arg2, %arg3 : f32
      %672 = arith.cmpf ogt, %arg2, %arg3 : f32
      %673 = arith.select %672, %670, %arg4 : i64
      linalg.yield %671, %673 : f32, i64
    }
    memref.dealloc %282 : memref<1x12x12x1xi64>
    %283 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%278, %281 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%283 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %281 : memref<1x12x12x1xf32>
    memref.dealloc %278 : memref<1x12x12x12xf32>
    %284 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%283 : memref<1x12x12x12xf32>) outs(%284 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.exp %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %283 : memref<1x12x12x12xf32>
    %285 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%285 : memref<1x12x12x1xf32>)
    %286 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %285, %286 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %285 : memref<1x12x12x1xf32>
    linalg.generic {indexing_maps = [#map3, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%284 : memref<1x12x12x12xf32>) outs(%286 : memref<1x12x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %287 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%284, %286 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%287 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.divf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %286 : memref<1x12x12x1xf32>
    memref.dealloc %284 : memref<1x12x12x12xf32>
    %288 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%287 : memref<1x12x12x12xf32>) outs(%288 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %287 : memref<1x12x12x12xf32>
    %289 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%266 : memref<1x12x12x32xf32>) outs(%289 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %266 : memref<1x12x12x32xf32>
    %290 = memref.collapse_shape %288 [[0, 1], [2], [3]] : memref<1x12x12x12xf32> into memref<12x12x12xf32>
    %291 = memref.collapse_shape %289 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %292 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    linalg.fill ins(%cst_4 : f32) outs(%292 : memref<12x12x32xf32>)
    %293 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    memref.copy %292, %293 : memref<12x12x32xf32> to memref<12x12x32xf32>
    memref.dealloc %292 : memref<12x12x32xf32>
    linalg.batch_matmul ins(%290, %291 : memref<12x12x12xf32>, memref<12x12x32xf32>) outs(%293 : memref<12x12x32xf32>)
    memref.dealloc %289 : memref<1x12x12x32xf32>
    memref.dealloc %288 : memref<1x12x12x12xf32>
    %294 = memref.expand_shape %293 [[0, 1], [2], [3]] : memref<12x12x32xf32> into memref<1x12x12x32xf32>
    %295 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%294 : memref<1x12x12x32xf32>) outs(%295 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %293 : memref<12x12x32xf32>
    %296 = memref.collapse_shape %295 [[0], [1], [2, 3]] : memref<1x12x12x32xf32> into memref<1x12x384xf32>
    %297 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%297 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %298 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%296 : memref<1x12x384xf32>) outs(%298 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %295 : memref<1x12x12x32xf32>
    %299 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%297 : memref<384x384xf32>) outs(%299 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %297 : memref<384x384xf32>
    %300 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%300 : memref<1x12x384xf32>)
    %301 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %300, %301 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %300 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%298, %299 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%301 : memref<1x12x384xf32>)
    memref.dealloc %299 : memref<1x384x384xf32>
    memref.dealloc %298 : memref<1x12x384xf32>
    %302 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%301, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%302 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %301 : memref<1x12x384xf32>
    %303 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%302, %244 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%303 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %302 : memref<1x12x384xf32>
    memref.dealloc %244 : memref<1x12x384xf32>
    %304 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%304 : memref<1x12x1xf32>)
    %305 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %304, %305 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %304 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%303 : memref<1x12x384xf32>) outs(%305 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %306 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%305 : memref<1x12x1xf32>) outs(%306 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %305 : memref<1x12x1xf32>
    %307 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%306 : memref<1x12x1xf32>) outs(%307 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %306 : memref<1x12x1xf32>
    %308 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%303, %307 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%308 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %307 : memref<1x12x384xf32>
    memref.dealloc %303 : memref<1x12x384xf32>
    %309 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%308 : memref<1x12x384xf32>) outs(%309 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %310 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%310 : memref<1x12x1xf32>)
    %311 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %310, %311 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %310 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%309 : memref<1x12x384xf32>) outs(%311 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %309 : memref<1x12x384xf32>
    %312 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%311 : memref<1x12x1xf32>) outs(%312 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %311 : memref<1x12x1xf32>
    %313 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%312 : memref<1x12x1xf32>) outs(%313 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %312 : memref<1x12x1xf32>
    %314 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%313 : memref<1x12x1xf32>) outs(%314 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %313 : memref<1x12x1xf32>
    %315 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%314 : memref<1x12x1xf32>) outs(%315 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %314 : memref<1x12x1xf32>
    %316 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%308, %315 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%316 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %315 : memref<1x12x384xf32>
    memref.dealloc %308 : memref<1x12x384xf32>
    %317 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%316, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%317 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %316 : memref<1x12x384xf32>
    %318 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%317, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%318 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %317 : memref<1x12x384xf32>
    %319 = memref.alloc() {alignment = 128 : i64} : memref<384x1536xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%6 : memref<1536x384xf32>) outs(%319 : memref<384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %320 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%318 : memref<1x12x384xf32>) outs(%320 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %321 = memref.alloc() {alignment = 128 : i64} : memref<1x384x1536xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%319 : memref<384x1536xf32>) outs(%321 : memref<1x384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %319 : memref<384x1536xf32>
    %322 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.fill ins(%cst_4 : f32) outs(%322 : memref<1x12x1536xf32>)
    %323 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    memref.copy %322, %323 : memref<1x12x1536xf32> to memref<1x12x1536xf32>
    memref.dealloc %322 : memref<1x12x1536xf32>
    linalg.batch_matmul ins(%320, %321 : memref<1x12x384xf32>, memref<1x384x1536xf32>) outs(%323 : memref<1x12x1536xf32>)
    memref.dealloc %321 : memref<1x384x1536xf32>
    memref.dealloc %320 : memref<1x12x384xf32>
    %324 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%323, %7 : memref<1x12x1536xf32>, memref<1536xf32>) outs(%324 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %323 : memref<1x12x1536xf32>
    %325 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%324 : memref<1x12x1536xf32>) outs(%325 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst_2 : f32
      %670 = math.erf %669 : f32
      %671 = arith.addf %670, %cst_5 : f32
      %672 = arith.mulf %671, %cst_1 : f32
      %673 = arith.mulf %arg2, %672 : f32
      linalg.yield %673 : f32
    }
    memref.dealloc %324 : memref<1x12x1536xf32>
    %326 = memref.alloc() {alignment = 128 : i64} : memref<1536x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%5 : memref<384x1536xf32>) outs(%326 : memref<1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %327 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%325 : memref<1x12x1536xf32>) outs(%327 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %325 : memref<1x12x1536xf32>
    %328 = memref.alloc() {alignment = 128 : i64} : memref<1x1536x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%326 : memref<1536x384xf32>) outs(%328 : memref<1x1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %326 : memref<1536x384xf32>
    %329 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%329 : memref<1x12x384xf32>)
    %330 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %329, %330 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %329 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%327, %328 : memref<1x12x1536xf32>, memref<1x1536x384xf32>) outs(%330 : memref<1x12x384xf32>)
    memref.dealloc %328 : memref<1x1536x384xf32>
    memref.dealloc %327 : memref<1x12x1536xf32>
    %331 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%330, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%331 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %330 : memref<1x12x384xf32>
    %332 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%331, %318 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%332 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %331 : memref<1x12x384xf32>
    memref.dealloc %318 : memref<1x12x384xf32>
    %333 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%333 : memref<1x12x1xf32>)
    %334 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %333, %334 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %333 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%332 : memref<1x12x384xf32>) outs(%334 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %335 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%334 : memref<1x12x1xf32>) outs(%335 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %334 : memref<1x12x1xf32>
    %336 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%335 : memref<1x12x1xf32>) outs(%336 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %335 : memref<1x12x1xf32>
    %337 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%332, %336 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%337 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %336 : memref<1x12x384xf32>
    memref.dealloc %332 : memref<1x12x384xf32>
    %338 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%337 : memref<1x12x384xf32>) outs(%338 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %339 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%339 : memref<1x12x1xf32>)
    %340 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %339, %340 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %339 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%338 : memref<1x12x384xf32>) outs(%340 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %338 : memref<1x12x384xf32>
    %341 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%340 : memref<1x12x1xf32>) outs(%341 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %340 : memref<1x12x1xf32>
    %342 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%341 : memref<1x12x1xf32>) outs(%342 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %341 : memref<1x12x1xf32>
    %343 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%342 : memref<1x12x1xf32>) outs(%343 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %342 : memref<1x12x1xf32>
    %344 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%343 : memref<1x12x1xf32>) outs(%344 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %343 : memref<1x12x1xf32>
    %345 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%337, %344 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%345 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %344 : memref<1x12x384xf32>
    memref.dealloc %337 : memref<1x12x384xf32>
    %346 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%345, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%346 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %345 : memref<1x12x384xf32>
    %347 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%346, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%347 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %346 : memref<1x12x384xf32>
    %348 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%348 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %349 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%347 : memref<1x12x384xf32>) outs(%349 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %350 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%348 : memref<384x384xf32>) outs(%350 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %348 : memref<384x384xf32>
    %351 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%351 : memref<1x12x384xf32>)
    %352 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %351, %352 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %351 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%349, %350 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%352 : memref<1x12x384xf32>)
    memref.dealloc %350 : memref<1x384x384xf32>
    memref.dealloc %349 : memref<1x12x384xf32>
    %353 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%352, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%353 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %352 : memref<1x12x384xf32>
    %354 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%354 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %355 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%347 : memref<1x12x384xf32>) outs(%355 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %356 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%354 : memref<384x384xf32>) outs(%356 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %354 : memref<384x384xf32>
    %357 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%357 : memref<1x12x384xf32>)
    %358 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %357, %358 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %357 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%355, %356 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%358 : memref<1x12x384xf32>)
    memref.dealloc %356 : memref<1x384x384xf32>
    memref.dealloc %355 : memref<1x12x384xf32>
    %359 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%358, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%359 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %358 : memref<1x12x384xf32>
    %360 = memref.expand_shape %359 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %361 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%360 : memref<1x12x12x32xf32>) outs(%361 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %359 : memref<1x12x384xf32>
    %362 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%362 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %363 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%347 : memref<1x12x384xf32>) outs(%363 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %364 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%362 : memref<384x384xf32>) outs(%364 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %362 : memref<384x384xf32>
    %365 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%365 : memref<1x12x384xf32>)
    %366 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %365, %366 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %365 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%363, %364 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%366 : memref<1x12x384xf32>)
    memref.dealloc %364 : memref<1x384x384xf32>
    memref.dealloc %363 : memref<1x12x384xf32>
    %367 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%366, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%367 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %366 : memref<1x12x384xf32>
    %368 = memref.expand_shape %367 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %369 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%368 : memref<1x12x12x32xf32>) outs(%369 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %367 : memref<1x12x384xf32>
    %370 = memref.expand_shape %353 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %371 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%370 : memref<1x12x12x32xf32>) outs(%371 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %353 : memref<1x12x384xf32>
    %372 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map3, #map15], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%361 : memref<1x12x12x32xf32>) outs(%372 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %361 : memref<1x12x12x32xf32>
    %373 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%371 : memref<1x12x12x32xf32>) outs(%373 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %371 : memref<1x12x12x32xf32>
    %374 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%372 : memref<1x12x32x12xf32>) outs(%374 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %372 : memref<1x12x32x12xf32>
    %375 = memref.collapse_shape %373 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %376 = memref.collapse_shape %374 [[0, 1], [2], [3]] : memref<1x12x32x12xf32> into memref<12x32x12xf32>
    %377 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    linalg.fill ins(%cst_4 : f32) outs(%377 : memref<12x12x12xf32>)
    %378 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    memref.copy %377, %378 : memref<12x12x12xf32> to memref<12x12x12xf32>
    memref.dealloc %377 : memref<12x12x12xf32>
    linalg.batch_matmul ins(%375, %376 : memref<12x12x32xf32>, memref<12x32x12xf32>) outs(%378 : memref<12x12x12xf32>)
    memref.dealloc %374 : memref<1x12x32x12xf32>
    memref.dealloc %373 : memref<1x12x12x32xf32>
    %379 = memref.expand_shape %378 [[0, 1], [2], [3]] : memref<12x12x12xf32> into memref<1x12x12x12xf32>
    %380 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%379, %8 : memref<1x12x12x12xf32>, memref<f64>) outs(%380 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f64, %arg4: f32):
      %669 = arith.truncf %arg3 : f64 to f32
      %670 = arith.divf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %378 : memref<12x12x12xf32>
    %381 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%380, %16 : memref<1x12x12x12xf32>, memref<1x1x1x12xf32>) outs(%381 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %380 : memref<1x12x12x12xf32>
    %382 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%382 : memref<1x12x12x1xi64>)
    %383 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_3 : f32) outs(%383 : memref<1x12x12x1xf32>)
    %384 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %383, %384 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %383 : memref<1x12x12x1xf32>
    %385 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    memref.copy %382, %385 : memref<1x12x12x1xi64> to memref<1x12x12x1xi64>
    memref.dealloc %382 : memref<1x12x12x1xi64>
    linalg.generic {indexing_maps = [#map3, #map17, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%381 : memref<1x12x12x12xf32>) outs(%384, %385 : memref<1x12x12x1xf32>, memref<1x12x12x1xi64>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i64):
      %669 = linalg.index 3 : index
      %670 = arith.index_cast %669 : index to i64
      %671 = arith.maxf %arg2, %arg3 : f32
      %672 = arith.cmpf ogt, %arg2, %arg3 : f32
      %673 = arith.select %672, %670, %arg4 : i64
      linalg.yield %671, %673 : f32, i64
    }
    memref.dealloc %385 : memref<1x12x12x1xi64>
    %386 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%381, %384 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%386 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %384 : memref<1x12x12x1xf32>
    memref.dealloc %381 : memref<1x12x12x12xf32>
    %387 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%386 : memref<1x12x12x12xf32>) outs(%387 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.exp %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %386 : memref<1x12x12x12xf32>
    %388 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%388 : memref<1x12x12x1xf32>)
    %389 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %388, %389 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %388 : memref<1x12x12x1xf32>
    linalg.generic {indexing_maps = [#map3, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%387 : memref<1x12x12x12xf32>) outs(%389 : memref<1x12x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %390 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%387, %389 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%390 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.divf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %389 : memref<1x12x12x1xf32>
    memref.dealloc %387 : memref<1x12x12x12xf32>
    %391 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%390 : memref<1x12x12x12xf32>) outs(%391 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %390 : memref<1x12x12x12xf32>
    %392 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%369 : memref<1x12x12x32xf32>) outs(%392 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %369 : memref<1x12x12x32xf32>
    %393 = memref.collapse_shape %391 [[0, 1], [2], [3]] : memref<1x12x12x12xf32> into memref<12x12x12xf32>
    %394 = memref.collapse_shape %392 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %395 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    linalg.fill ins(%cst_4 : f32) outs(%395 : memref<12x12x32xf32>)
    %396 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    memref.copy %395, %396 : memref<12x12x32xf32> to memref<12x12x32xf32>
    memref.dealloc %395 : memref<12x12x32xf32>
    linalg.batch_matmul ins(%393, %394 : memref<12x12x12xf32>, memref<12x12x32xf32>) outs(%396 : memref<12x12x32xf32>)
    memref.dealloc %392 : memref<1x12x12x32xf32>
    memref.dealloc %391 : memref<1x12x12x12xf32>
    %397 = memref.expand_shape %396 [[0, 1], [2], [3]] : memref<12x12x32xf32> into memref<1x12x12x32xf32>
    %398 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%397 : memref<1x12x12x32xf32>) outs(%398 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %396 : memref<12x12x32xf32>
    %399 = memref.collapse_shape %398 [[0], [1], [2, 3]] : memref<1x12x12x32xf32> into memref<1x12x384xf32>
    %400 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%400 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %401 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%399 : memref<1x12x384xf32>) outs(%401 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %398 : memref<1x12x12x32xf32>
    %402 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%400 : memref<384x384xf32>) outs(%402 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %400 : memref<384x384xf32>
    %403 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%403 : memref<1x12x384xf32>)
    %404 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %403, %404 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %403 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%401, %402 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%404 : memref<1x12x384xf32>)
    memref.dealloc %402 : memref<1x384x384xf32>
    memref.dealloc %401 : memref<1x12x384xf32>
    %405 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%404, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%405 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %404 : memref<1x12x384xf32>
    %406 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%405, %347 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%406 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %405 : memref<1x12x384xf32>
    memref.dealloc %347 : memref<1x12x384xf32>
    %407 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%407 : memref<1x12x1xf32>)
    %408 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %407, %408 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %407 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%406 : memref<1x12x384xf32>) outs(%408 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %409 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%408 : memref<1x12x1xf32>) outs(%409 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %408 : memref<1x12x1xf32>
    %410 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%409 : memref<1x12x1xf32>) outs(%410 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %409 : memref<1x12x1xf32>
    %411 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%406, %410 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%411 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %410 : memref<1x12x384xf32>
    memref.dealloc %406 : memref<1x12x384xf32>
    %412 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%411 : memref<1x12x384xf32>) outs(%412 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %413 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%413 : memref<1x12x1xf32>)
    %414 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %413, %414 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %413 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%412 : memref<1x12x384xf32>) outs(%414 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %412 : memref<1x12x384xf32>
    %415 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%414 : memref<1x12x1xf32>) outs(%415 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %414 : memref<1x12x1xf32>
    %416 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%415 : memref<1x12x1xf32>) outs(%416 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %415 : memref<1x12x1xf32>
    %417 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%416 : memref<1x12x1xf32>) outs(%417 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %416 : memref<1x12x1xf32>
    %418 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%417 : memref<1x12x1xf32>) outs(%418 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %417 : memref<1x12x1xf32>
    %419 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%411, %418 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%419 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %418 : memref<1x12x384xf32>
    memref.dealloc %411 : memref<1x12x384xf32>
    %420 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%419, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%420 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %419 : memref<1x12x384xf32>
    %421 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%420, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%421 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %420 : memref<1x12x384xf32>
    %422 = memref.alloc() {alignment = 128 : i64} : memref<384x1536xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%6 : memref<1536x384xf32>) outs(%422 : memref<384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %423 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%421 : memref<1x12x384xf32>) outs(%423 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %424 = memref.alloc() {alignment = 128 : i64} : memref<1x384x1536xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%422 : memref<384x1536xf32>) outs(%424 : memref<1x384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %422 : memref<384x1536xf32>
    %425 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.fill ins(%cst_4 : f32) outs(%425 : memref<1x12x1536xf32>)
    %426 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    memref.copy %425, %426 : memref<1x12x1536xf32> to memref<1x12x1536xf32>
    memref.dealloc %425 : memref<1x12x1536xf32>
    linalg.batch_matmul ins(%423, %424 : memref<1x12x384xf32>, memref<1x384x1536xf32>) outs(%426 : memref<1x12x1536xf32>)
    memref.dealloc %424 : memref<1x384x1536xf32>
    memref.dealloc %423 : memref<1x12x384xf32>
    %427 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%426, %7 : memref<1x12x1536xf32>, memref<1536xf32>) outs(%427 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %426 : memref<1x12x1536xf32>
    %428 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%427 : memref<1x12x1536xf32>) outs(%428 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst_2 : f32
      %670 = math.erf %669 : f32
      %671 = arith.addf %670, %cst_5 : f32
      %672 = arith.mulf %671, %cst_1 : f32
      %673 = arith.mulf %arg2, %672 : f32
      linalg.yield %673 : f32
    }
    memref.dealloc %427 : memref<1x12x1536xf32>
    %429 = memref.alloc() {alignment = 128 : i64} : memref<1536x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%5 : memref<384x1536xf32>) outs(%429 : memref<1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %430 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%428 : memref<1x12x1536xf32>) outs(%430 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %428 : memref<1x12x1536xf32>
    %431 = memref.alloc() {alignment = 128 : i64} : memref<1x1536x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%429 : memref<1536x384xf32>) outs(%431 : memref<1x1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %429 : memref<1536x384xf32>
    %432 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%432 : memref<1x12x384xf32>)
    %433 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %432, %433 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %432 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%430, %431 : memref<1x12x1536xf32>, memref<1x1536x384xf32>) outs(%433 : memref<1x12x384xf32>)
    memref.dealloc %431 : memref<1x1536x384xf32>
    memref.dealloc %430 : memref<1x12x1536xf32>
    %434 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%433, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%434 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %433 : memref<1x12x384xf32>
    %435 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%434, %421 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%435 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %434 : memref<1x12x384xf32>
    memref.dealloc %421 : memref<1x12x384xf32>
    %436 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%436 : memref<1x12x1xf32>)
    %437 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %436, %437 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %436 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%435 : memref<1x12x384xf32>) outs(%437 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %438 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%437 : memref<1x12x1xf32>) outs(%438 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %437 : memref<1x12x1xf32>
    %439 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%438 : memref<1x12x1xf32>) outs(%439 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %438 : memref<1x12x1xf32>
    %440 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%435, %439 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%440 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %439 : memref<1x12x384xf32>
    memref.dealloc %435 : memref<1x12x384xf32>
    %441 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%440 : memref<1x12x384xf32>) outs(%441 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %442 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%442 : memref<1x12x1xf32>)
    %443 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %442, %443 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %442 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%441 : memref<1x12x384xf32>) outs(%443 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %441 : memref<1x12x384xf32>
    %444 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%443 : memref<1x12x1xf32>) outs(%444 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %443 : memref<1x12x1xf32>
    %445 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%444 : memref<1x12x1xf32>) outs(%445 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %444 : memref<1x12x1xf32>
    %446 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%445 : memref<1x12x1xf32>) outs(%446 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %445 : memref<1x12x1xf32>
    %447 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%446 : memref<1x12x1xf32>) outs(%447 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %446 : memref<1x12x1xf32>
    %448 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%440, %447 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%448 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %447 : memref<1x12x384xf32>
    memref.dealloc %440 : memref<1x12x384xf32>
    %449 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%448, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%449 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %448 : memref<1x12x384xf32>
    %450 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%449, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%450 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %449 : memref<1x12x384xf32>
    %451 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%451 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %452 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%450 : memref<1x12x384xf32>) outs(%452 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %453 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%451 : memref<384x384xf32>) outs(%453 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %451 : memref<384x384xf32>
    %454 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%454 : memref<1x12x384xf32>)
    %455 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %454, %455 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %454 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%452, %453 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%455 : memref<1x12x384xf32>)
    memref.dealloc %453 : memref<1x384x384xf32>
    memref.dealloc %452 : memref<1x12x384xf32>
    %456 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%455, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%456 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %455 : memref<1x12x384xf32>
    %457 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%457 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %458 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%450 : memref<1x12x384xf32>) outs(%458 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %459 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%457 : memref<384x384xf32>) outs(%459 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %457 : memref<384x384xf32>
    %460 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%460 : memref<1x12x384xf32>)
    %461 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %460, %461 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %460 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%458, %459 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%461 : memref<1x12x384xf32>)
    memref.dealloc %459 : memref<1x384x384xf32>
    memref.dealloc %458 : memref<1x12x384xf32>
    %462 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%461, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%462 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %461 : memref<1x12x384xf32>
    %463 = memref.expand_shape %462 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %464 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%463 : memref<1x12x12x32xf32>) outs(%464 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %462 : memref<1x12x384xf32>
    %465 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%465 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %466 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%450 : memref<1x12x384xf32>) outs(%466 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %467 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%465 : memref<384x384xf32>) outs(%467 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %465 : memref<384x384xf32>
    %468 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%468 : memref<1x12x384xf32>)
    %469 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %468, %469 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %468 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%466, %467 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%469 : memref<1x12x384xf32>)
    memref.dealloc %467 : memref<1x384x384xf32>
    memref.dealloc %466 : memref<1x12x384xf32>
    %470 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%469, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%470 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %469 : memref<1x12x384xf32>
    %471 = memref.expand_shape %470 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %472 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%471 : memref<1x12x12x32xf32>) outs(%472 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %470 : memref<1x12x384xf32>
    %473 = memref.expand_shape %456 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %474 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%473 : memref<1x12x12x32xf32>) outs(%474 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %456 : memref<1x12x384xf32>
    %475 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map3, #map15], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%464 : memref<1x12x12x32xf32>) outs(%475 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %464 : memref<1x12x12x32xf32>
    %476 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%474 : memref<1x12x12x32xf32>) outs(%476 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %474 : memref<1x12x12x32xf32>
    %477 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%475 : memref<1x12x32x12xf32>) outs(%477 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %475 : memref<1x12x32x12xf32>
    %478 = memref.collapse_shape %476 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %479 = memref.collapse_shape %477 [[0, 1], [2], [3]] : memref<1x12x32x12xf32> into memref<12x32x12xf32>
    %480 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    linalg.fill ins(%cst_4 : f32) outs(%480 : memref<12x12x12xf32>)
    %481 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    memref.copy %480, %481 : memref<12x12x12xf32> to memref<12x12x12xf32>
    memref.dealloc %480 : memref<12x12x12xf32>
    linalg.batch_matmul ins(%478, %479 : memref<12x12x32xf32>, memref<12x32x12xf32>) outs(%481 : memref<12x12x12xf32>)
    memref.dealloc %477 : memref<1x12x32x12xf32>
    memref.dealloc %476 : memref<1x12x12x32xf32>
    %482 = memref.expand_shape %481 [[0, 1], [2], [3]] : memref<12x12x12xf32> into memref<1x12x12x12xf32>
    %483 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%482, %8 : memref<1x12x12x12xf32>, memref<f64>) outs(%483 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f64, %arg4: f32):
      %669 = arith.truncf %arg3 : f64 to f32
      %670 = arith.divf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %481 : memref<12x12x12xf32>
    %484 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%483, %16 : memref<1x12x12x12xf32>, memref<1x1x1x12xf32>) outs(%484 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %483 : memref<1x12x12x12xf32>
    %485 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%485 : memref<1x12x12x1xi64>)
    %486 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_3 : f32) outs(%486 : memref<1x12x12x1xf32>)
    %487 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %486, %487 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %486 : memref<1x12x12x1xf32>
    %488 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    memref.copy %485, %488 : memref<1x12x12x1xi64> to memref<1x12x12x1xi64>
    memref.dealloc %485 : memref<1x12x12x1xi64>
    linalg.generic {indexing_maps = [#map3, #map17, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%484 : memref<1x12x12x12xf32>) outs(%487, %488 : memref<1x12x12x1xf32>, memref<1x12x12x1xi64>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i64):
      %669 = linalg.index 3 : index
      %670 = arith.index_cast %669 : index to i64
      %671 = arith.maxf %arg2, %arg3 : f32
      %672 = arith.cmpf ogt, %arg2, %arg3 : f32
      %673 = arith.select %672, %670, %arg4 : i64
      linalg.yield %671, %673 : f32, i64
    }
    memref.dealloc %488 : memref<1x12x12x1xi64>
    %489 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%484, %487 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%489 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %487 : memref<1x12x12x1xf32>
    memref.dealloc %484 : memref<1x12x12x12xf32>
    %490 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%489 : memref<1x12x12x12xf32>) outs(%490 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.exp %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %489 : memref<1x12x12x12xf32>
    %491 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%491 : memref<1x12x12x1xf32>)
    %492 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %491, %492 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %491 : memref<1x12x12x1xf32>
    linalg.generic {indexing_maps = [#map3, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%490 : memref<1x12x12x12xf32>) outs(%492 : memref<1x12x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %493 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%490, %492 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%493 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.divf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %492 : memref<1x12x12x1xf32>
    memref.dealloc %490 : memref<1x12x12x12xf32>
    %494 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%493 : memref<1x12x12x12xf32>) outs(%494 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %493 : memref<1x12x12x12xf32>
    %495 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%472 : memref<1x12x12x32xf32>) outs(%495 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %472 : memref<1x12x12x32xf32>
    %496 = memref.collapse_shape %494 [[0, 1], [2], [3]] : memref<1x12x12x12xf32> into memref<12x12x12xf32>
    %497 = memref.collapse_shape %495 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %498 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    linalg.fill ins(%cst_4 : f32) outs(%498 : memref<12x12x32xf32>)
    %499 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    memref.copy %498, %499 : memref<12x12x32xf32> to memref<12x12x32xf32>
    memref.dealloc %498 : memref<12x12x32xf32>
    linalg.batch_matmul ins(%496, %497 : memref<12x12x12xf32>, memref<12x12x32xf32>) outs(%499 : memref<12x12x32xf32>)
    memref.dealloc %495 : memref<1x12x12x32xf32>
    memref.dealloc %494 : memref<1x12x12x12xf32>
    %500 = memref.expand_shape %499 [[0, 1], [2], [3]] : memref<12x12x32xf32> into memref<1x12x12x32xf32>
    %501 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%500 : memref<1x12x12x32xf32>) outs(%501 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %499 : memref<12x12x32xf32>
    %502 = memref.collapse_shape %501 [[0], [1], [2, 3]] : memref<1x12x12x32xf32> into memref<1x12x384xf32>
    %503 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%503 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %504 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%502 : memref<1x12x384xf32>) outs(%504 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %501 : memref<1x12x12x32xf32>
    %505 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%503 : memref<384x384xf32>) outs(%505 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %503 : memref<384x384xf32>
    %506 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%506 : memref<1x12x384xf32>)
    %507 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %506, %507 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %506 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%504, %505 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%507 : memref<1x12x384xf32>)
    memref.dealloc %505 : memref<1x384x384xf32>
    memref.dealloc %504 : memref<1x12x384xf32>
    %508 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%507, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%508 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %507 : memref<1x12x384xf32>
    %509 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%508, %450 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%509 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %508 : memref<1x12x384xf32>
    memref.dealloc %450 : memref<1x12x384xf32>
    %510 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%510 : memref<1x12x1xf32>)
    %511 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %510, %511 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %510 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%509 : memref<1x12x384xf32>) outs(%511 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %512 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%511 : memref<1x12x1xf32>) outs(%512 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %511 : memref<1x12x1xf32>
    %513 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%512 : memref<1x12x1xf32>) outs(%513 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %512 : memref<1x12x1xf32>
    %514 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%509, %513 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%514 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %513 : memref<1x12x384xf32>
    memref.dealloc %509 : memref<1x12x384xf32>
    %515 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%514 : memref<1x12x384xf32>) outs(%515 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %516 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%516 : memref<1x12x1xf32>)
    %517 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %516, %517 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %516 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%515 : memref<1x12x384xf32>) outs(%517 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %515 : memref<1x12x384xf32>
    %518 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%517 : memref<1x12x1xf32>) outs(%518 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %517 : memref<1x12x1xf32>
    %519 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%518 : memref<1x12x1xf32>) outs(%519 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %518 : memref<1x12x1xf32>
    %520 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%519 : memref<1x12x1xf32>) outs(%520 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %519 : memref<1x12x1xf32>
    %521 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%520 : memref<1x12x1xf32>) outs(%521 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %520 : memref<1x12x1xf32>
    %522 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%514, %521 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%522 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %521 : memref<1x12x384xf32>
    memref.dealloc %514 : memref<1x12x384xf32>
    %523 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%522, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%523 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %522 : memref<1x12x384xf32>
    %524 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%523, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%524 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %523 : memref<1x12x384xf32>
    %525 = memref.alloc() {alignment = 128 : i64} : memref<384x1536xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%6 : memref<1536x384xf32>) outs(%525 : memref<384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %526 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%524 : memref<1x12x384xf32>) outs(%526 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %527 = memref.alloc() {alignment = 128 : i64} : memref<1x384x1536xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%525 : memref<384x1536xf32>) outs(%527 : memref<1x384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %525 : memref<384x1536xf32>
    %528 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.fill ins(%cst_4 : f32) outs(%528 : memref<1x12x1536xf32>)
    %529 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    memref.copy %528, %529 : memref<1x12x1536xf32> to memref<1x12x1536xf32>
    memref.dealloc %528 : memref<1x12x1536xf32>
    linalg.batch_matmul ins(%526, %527 : memref<1x12x384xf32>, memref<1x384x1536xf32>) outs(%529 : memref<1x12x1536xf32>)
    memref.dealloc %527 : memref<1x384x1536xf32>
    memref.dealloc %526 : memref<1x12x384xf32>
    %530 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%529, %7 : memref<1x12x1536xf32>, memref<1536xf32>) outs(%530 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %529 : memref<1x12x1536xf32>
    %531 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%530 : memref<1x12x1536xf32>) outs(%531 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst_2 : f32
      %670 = math.erf %669 : f32
      %671 = arith.addf %670, %cst_5 : f32
      %672 = arith.mulf %671, %cst_1 : f32
      %673 = arith.mulf %arg2, %672 : f32
      linalg.yield %673 : f32
    }
    memref.dealloc %530 : memref<1x12x1536xf32>
    %532 = memref.alloc() {alignment = 128 : i64} : memref<1536x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%5 : memref<384x1536xf32>) outs(%532 : memref<1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %533 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%531 : memref<1x12x1536xf32>) outs(%533 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %531 : memref<1x12x1536xf32>
    %534 = memref.alloc() {alignment = 128 : i64} : memref<1x1536x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%532 : memref<1536x384xf32>) outs(%534 : memref<1x1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %532 : memref<1536x384xf32>
    %535 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%535 : memref<1x12x384xf32>)
    %536 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %535, %536 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %535 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%533, %534 : memref<1x12x1536xf32>, memref<1x1536x384xf32>) outs(%536 : memref<1x12x384xf32>)
    memref.dealloc %534 : memref<1x1536x384xf32>
    memref.dealloc %533 : memref<1x12x1536xf32>
    %537 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%536, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%537 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %536 : memref<1x12x384xf32>
    %538 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%537, %524 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%538 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %537 : memref<1x12x384xf32>
    memref.dealloc %524 : memref<1x12x384xf32>
    %539 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%539 : memref<1x12x1xf32>)
    %540 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %539, %540 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %539 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%538 : memref<1x12x384xf32>) outs(%540 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %541 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%540 : memref<1x12x1xf32>) outs(%541 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %540 : memref<1x12x1xf32>
    %542 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%541 : memref<1x12x1xf32>) outs(%542 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %541 : memref<1x12x1xf32>
    %543 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%538, %542 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%543 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %542 : memref<1x12x384xf32>
    memref.dealloc %538 : memref<1x12x384xf32>
    %544 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%543 : memref<1x12x384xf32>) outs(%544 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %545 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%545 : memref<1x12x1xf32>)
    %546 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %545, %546 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %545 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%544 : memref<1x12x384xf32>) outs(%546 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %544 : memref<1x12x384xf32>
    %547 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%546 : memref<1x12x1xf32>) outs(%547 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %546 : memref<1x12x1xf32>
    %548 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%547 : memref<1x12x1xf32>) outs(%548 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %547 : memref<1x12x1xf32>
    %549 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%548 : memref<1x12x1xf32>) outs(%549 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %548 : memref<1x12x1xf32>
    %550 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%549 : memref<1x12x1xf32>) outs(%550 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %549 : memref<1x12x1xf32>
    %551 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%543, %550 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%551 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %550 : memref<1x12x384xf32>
    memref.dealloc %543 : memref<1x12x384xf32>
    %552 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%551, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%552 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %551 : memref<1x12x384xf32>
    %553 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%552, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%553 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %552 : memref<1x12x384xf32>
    %554 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%554 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %555 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%553 : memref<1x12x384xf32>) outs(%555 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %556 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%554 : memref<384x384xf32>) outs(%556 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %554 : memref<384x384xf32>
    %557 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%557 : memref<1x12x384xf32>)
    %558 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %557, %558 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %557 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%555, %556 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%558 : memref<1x12x384xf32>)
    memref.dealloc %556 : memref<1x384x384xf32>
    memref.dealloc %555 : memref<1x12x384xf32>
    %559 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%558, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%559 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %558 : memref<1x12x384xf32>
    %560 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%560 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %561 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%553 : memref<1x12x384xf32>) outs(%561 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %562 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%560 : memref<384x384xf32>) outs(%562 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %560 : memref<384x384xf32>
    %563 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%563 : memref<1x12x384xf32>)
    %564 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %563, %564 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %563 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%561, %562 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%564 : memref<1x12x384xf32>)
    memref.dealloc %562 : memref<1x384x384xf32>
    memref.dealloc %561 : memref<1x12x384xf32>
    %565 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%564, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%565 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %564 : memref<1x12x384xf32>
    %566 = memref.expand_shape %565 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %567 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%566 : memref<1x12x12x32xf32>) outs(%567 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %565 : memref<1x12x384xf32>
    %568 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%568 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %569 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%553 : memref<1x12x384xf32>) outs(%569 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %570 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%568 : memref<384x384xf32>) outs(%570 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %568 : memref<384x384xf32>
    %571 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%571 : memref<1x12x384xf32>)
    %572 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %571, %572 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %571 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%569, %570 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%572 : memref<1x12x384xf32>)
    memref.dealloc %570 : memref<1x384x384xf32>
    memref.dealloc %569 : memref<1x12x384xf32>
    %573 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%572, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%573 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %572 : memref<1x12x384xf32>
    %574 = memref.expand_shape %573 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %575 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%574 : memref<1x12x12x32xf32>) outs(%575 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %573 : memref<1x12x384xf32>
    %576 = memref.expand_shape %559 [[0], [1], [2, 3]] : memref<1x12x384xf32> into memref<1x12x12x32xf32>
    %577 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%576 : memref<1x12x12x32xf32>) outs(%577 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %559 : memref<1x12x384xf32>
    %578 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map3, #map15], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%567 : memref<1x12x12x32xf32>) outs(%578 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %567 : memref<1x12x12x32xf32>
    %579 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%577 : memref<1x12x12x32xf32>) outs(%579 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %577 : memref<1x12x12x32xf32>
    %580 = memref.alloc() {alignment = 128 : i64} : memref<1x12x32x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%578 : memref<1x12x32x12xf32>) outs(%580 : memref<1x12x32x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %578 : memref<1x12x32x12xf32>
    %581 = memref.collapse_shape %579 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %582 = memref.collapse_shape %580 [[0, 1], [2], [3]] : memref<1x12x32x12xf32> into memref<12x32x12xf32>
    %583 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    linalg.fill ins(%cst_4 : f32) outs(%583 : memref<12x12x12xf32>)
    %584 = memref.alloc() {alignment = 128 : i64} : memref<12x12x12xf32>
    memref.copy %583, %584 : memref<12x12x12xf32> to memref<12x12x12xf32>
    memref.dealloc %583 : memref<12x12x12xf32>
    linalg.batch_matmul ins(%581, %582 : memref<12x12x32xf32>, memref<12x32x12xf32>) outs(%584 : memref<12x12x12xf32>)
    memref.dealloc %580 : memref<1x12x32x12xf32>
    memref.dealloc %579 : memref<1x12x12x32xf32>
    %585 = memref.expand_shape %584 [[0, 1], [2], [3]] : memref<12x12x12xf32> into memref<1x12x12x12xf32>
    %586 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%585, %8 : memref<1x12x12x12xf32>, memref<f64>) outs(%586 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f64, %arg4: f32):
      %669 = arith.truncf %arg3 : f64 to f32
      %670 = arith.divf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %584 : memref<12x12x12xf32>
    %587 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%586, %16 : memref<1x12x12x12xf32>, memref<1x1x1x12xf32>) outs(%587 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %586 : memref<1x12x12x12xf32>
    memref.dealloc %16 : memref<1x1x1x12xf32>
    %588 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%588 : memref<1x12x12x1xi64>)
    %589 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_3 : f32) outs(%589 : memref<1x12x12x1xf32>)
    %590 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %589, %590 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %589 : memref<1x12x12x1xf32>
    %591 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xi64>
    memref.copy %588, %591 : memref<1x12x12x1xi64> to memref<1x12x12x1xi64>
    memref.dealloc %588 : memref<1x12x12x1xi64>
    linalg.generic {indexing_maps = [#map3, #map17, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%587 : memref<1x12x12x12xf32>) outs(%590, %591 : memref<1x12x12x1xf32>, memref<1x12x12x1xi64>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i64):
      %669 = linalg.index 3 : index
      %670 = arith.index_cast %669 : index to i64
      %671 = arith.maxf %arg2, %arg3 : f32
      %672 = arith.cmpf ogt, %arg2, %arg3 : f32
      %673 = arith.select %672, %670, %arg4 : i64
      linalg.yield %671, %673 : f32, i64
    }
    memref.dealloc %591 : memref<1x12x12x1xi64>
    %592 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%587, %590 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%592 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %590 : memref<1x12x12x1xf32>
    memref.dealloc %587 : memref<1x12x12x12xf32>
    %593 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%592 : memref<1x12x12x12xf32>) outs(%593 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.exp %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %592 : memref<1x12x12x12xf32>
    %594 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%594 : memref<1x12x12x1xf32>)
    %595 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x1xf32>
    memref.copy %594, %595 : memref<1x12x12x1xf32> to memref<1x12x12x1xf32>
    memref.dealloc %594 : memref<1x12x12x1xf32>
    linalg.generic {indexing_maps = [#map3, #map17], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%593 : memref<1x12x12x12xf32>) outs(%595 : memref<1x12x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %596 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map18, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%593, %595 : memref<1x12x12x12xf32>, memref<1x12x12x1xf32>) outs(%596 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.divf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %595 : memref<1x12x12x1xf32>
    memref.dealloc %593 : memref<1x12x12x12xf32>
    %597 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x12xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%596 : memref<1x12x12x12xf32>) outs(%597 : memref<1x12x12x12xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %596 : memref<1x12x12x12xf32>
    %598 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map16, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%575 : memref<1x12x12x32xf32>) outs(%598 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %575 : memref<1x12x12x32xf32>
    %599 = memref.collapse_shape %597 [[0, 1], [2], [3]] : memref<1x12x12x12xf32> into memref<12x12x12xf32>
    %600 = memref.collapse_shape %598 [[0, 1], [2], [3]] : memref<1x12x12x32xf32> into memref<12x12x32xf32>
    %601 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    linalg.fill ins(%cst_4 : f32) outs(%601 : memref<12x12x32xf32>)
    %602 = memref.alloc() {alignment = 128 : i64} : memref<12x12x32xf32>
    memref.copy %601, %602 : memref<12x12x32xf32> to memref<12x12x32xf32>
    memref.dealloc %601 : memref<12x12x32xf32>
    linalg.batch_matmul ins(%599, %600 : memref<12x12x12xf32>, memref<12x12x32xf32>) outs(%602 : memref<12x12x32xf32>)
    memref.dealloc %598 : memref<1x12x12x32xf32>
    memref.dealloc %597 : memref<1x12x12x12xf32>
    %603 = memref.expand_shape %602 [[0, 1], [2], [3]] : memref<12x12x32xf32> into memref<1x12x12x32xf32>
    %604 = memref.alloc() {alignment = 128 : i64} : memref<1x12x12x32xf32>
    linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%603 : memref<1x12x12x32xf32>) outs(%604 : memref<1x12x12x32xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %602 : memref<12x12x32xf32>
    %605 = memref.collapse_shape %604 [[0], [1], [2, 3]] : memref<1x12x12x32xf32> into memref<1x12x384xf32>
    %606 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%606 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %607 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%605 : memref<1x12x384xf32>) outs(%607 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %604 : memref<1x12x12x32xf32>
    %608 = memref.alloc() {alignment = 128 : i64} : memref<1x384x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%606 : memref<384x384xf32>) outs(%608 : memref<1x384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %606 : memref<384x384xf32>
    %609 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%609 : memref<1x12x384xf32>)
    %610 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %609, %610 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %609 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%607, %608 : memref<1x12x384xf32>, memref<1x384x384xf32>) outs(%610 : memref<1x12x384xf32>)
    memref.dealloc %608 : memref<1x384x384xf32>
    memref.dealloc %607 : memref<1x12x384xf32>
    %611 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%610, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%611 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %610 : memref<1x12x384xf32>
    %612 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%611, %553 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%612 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %611 : memref<1x12x384xf32>
    memref.dealloc %553 : memref<1x12x384xf32>
    %613 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%613 : memref<1x12x1xf32>)
    %614 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %613, %614 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %613 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%612 : memref<1x12x384xf32>) outs(%614 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %615 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%614 : memref<1x12x1xf32>) outs(%615 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %614 : memref<1x12x1xf32>
    %616 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%615 : memref<1x12x1xf32>) outs(%616 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %615 : memref<1x12x1xf32>
    %617 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%612, %616 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%617 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %616 : memref<1x12x384xf32>
    memref.dealloc %612 : memref<1x12x384xf32>
    %618 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%617 : memref<1x12x384xf32>) outs(%618 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %619 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%619 : memref<1x12x1xf32>)
    %620 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %619, %620 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %619 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%618 : memref<1x12x384xf32>) outs(%620 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %618 : memref<1x12x384xf32>
    %621 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%620 : memref<1x12x1xf32>) outs(%621 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %620 : memref<1x12x1xf32>
    %622 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%621 : memref<1x12x1xf32>) outs(%622 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %621 : memref<1x12x1xf32>
    %623 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%622 : memref<1x12x1xf32>) outs(%623 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %622 : memref<1x12x1xf32>
    %624 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%623 : memref<1x12x1xf32>) outs(%624 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %623 : memref<1x12x1xf32>
    %625 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%617, %624 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%625 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %624 : memref<1x12x384xf32>
    memref.dealloc %617 : memref<1x12x384xf32>
    %626 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%625, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%626 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %625 : memref<1x12x384xf32>
    %627 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%626, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%627 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %626 : memref<1x12x384xf32>
    %628 = memref.alloc() {alignment = 128 : i64} : memref<384x1536xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%6 : memref<1536x384xf32>) outs(%628 : memref<384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %629 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%627 : memref<1x12x384xf32>) outs(%629 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %630 = memref.alloc() {alignment = 128 : i64} : memref<1x384x1536xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%628 : memref<384x1536xf32>) outs(%630 : memref<1x384x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %628 : memref<384x1536xf32>
    %631 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.fill ins(%cst_4 : f32) outs(%631 : memref<1x12x1536xf32>)
    %632 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    memref.copy %631, %632 : memref<1x12x1536xf32> to memref<1x12x1536xf32>
    memref.dealloc %631 : memref<1x12x1536xf32>
    linalg.batch_matmul ins(%629, %630 : memref<1x12x384xf32>, memref<1x384x1536xf32>) outs(%632 : memref<1x12x1536xf32>)
    memref.dealloc %630 : memref<1x384x1536xf32>
    memref.dealloc %629 : memref<1x12x384xf32>
    %633 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%632, %7 : memref<1x12x1536xf32>, memref<1536xf32>) outs(%633 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %632 : memref<1x12x1536xf32>
    %634 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%633 : memref<1x12x1536xf32>) outs(%634 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst_2 : f32
      %670 = math.erf %669 : f32
      %671 = arith.addf %670, %cst_5 : f32
      %672 = arith.mulf %671, %cst_1 : f32
      %673 = arith.mulf %arg2, %672 : f32
      linalg.yield %673 : f32
    }
    memref.dealloc %633 : memref<1x12x1536xf32>
    %635 = memref.alloc() {alignment = 128 : i64} : memref<1536x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%5 : memref<384x1536xf32>) outs(%635 : memref<1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %636 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1536xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%634 : memref<1x12x1536xf32>) outs(%636 : memref<1x12x1536xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %634 : memref<1x12x1536xf32>
    %637 = memref.alloc() {alignment = 128 : i64} : memref<1x1536x384xf32>
    linalg.generic {indexing_maps = [#map13, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%635 : memref<1536x384xf32>) outs(%637 : memref<1x1536x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %635 : memref<1536x384xf32>
    %638 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%638 : memref<1x12x384xf32>)
    %639 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    memref.copy %638, %639 : memref<1x12x384xf32> to memref<1x12x384xf32>
    memref.dealloc %638 : memref<1x12x384xf32>
    linalg.batch_matmul ins(%636, %637 : memref<1x12x1536xf32>, memref<1x1536x384xf32>) outs(%639 : memref<1x12x384xf32>)
    memref.dealloc %637 : memref<1x1536x384xf32>
    memref.dealloc %636 : memref<1x12x1536xf32>
    %640 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%639, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%640 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %639 : memref<1x12x384xf32>
    %641 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%640, %627 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%641 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %640 : memref<1x12x384xf32>
    memref.dealloc %627 : memref<1x12x384xf32>
    %642 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%642 : memref<1x12x1xf32>)
    %643 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %642, %643 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %642 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%641 : memref<1x12x384xf32>) outs(%643 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    %644 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%643 : memref<1x12x1xf32>) outs(%644 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %643 : memref<1x12x1xf32>
    %645 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%644 : memref<1x12x1xf32>) outs(%645 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %644 : memref<1x12x1xf32>
    %646 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%641, %645 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%646 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.subf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %645 : memref<1x12x384xf32>
    memref.dealloc %641 : memref<1x12x384xf32>
    %647 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%646 : memref<1x12x384xf32>) outs(%647 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.mulf %arg2, %arg2 : f32
      linalg.yield %669 : f32
    }
    %648 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.fill ins(%cst_4 : f32) outs(%648 : memref<1x12x1xf32>)
    %649 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    memref.copy %648, %649 : memref<1x12x1xf32> to memref<1x12x1xf32>
    memref.dealloc %648 : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map7, #map9], iterator_types = ["parallel", "parallel", "reduction"]} ins(%647 : memref<1x12x384xf32>) outs(%649 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %647 : memref<1x12x384xf32>
    %650 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%649 : memref<1x12x1xf32>) outs(%650 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.divf %arg2, %cst : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %649 : memref<1x12x1xf32>
    %651 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%650 : memref<1x12x1xf32>) outs(%651 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = arith.truncf %cst_0 : f64 to f32
      %670 = arith.addf %arg2, %669 : f32
      linalg.yield %670 : f32
    }
    memref.dealloc %650 : memref<1x12x1xf32>
    %652 = memref.alloc() {alignment = 128 : i64} : memref<1x12x1xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%651 : memref<1x12x1xf32>) outs(%652 : memref<1x12x1xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.rsqrt %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %651 : memref<1x12x1xf32>
    %653 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map10, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%652 : memref<1x12x1xf32>) outs(%653 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    memref.dealloc %652 : memref<1x12x1xf32>
    %654 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map8, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%646, %653 : memref<1x12x384xf32>, memref<1x12x384xf32>) outs(%654 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %653 : memref<1x12x384xf32>
    memref.dealloc %646 : memref<1x12x384xf32>
    %655 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%654, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%655 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.mulf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %654 : memref<1x12x384xf32>
    %656 = memref.alloc() {alignment = 128 : i64} : memref<1x12x384xf32>
    linalg.generic {indexing_maps = [#map8, #map11, #map7], iterator_types = ["parallel", "parallel", "parallel"]} ins(%655, %4 : memref<1x12x384xf32>, memref<384xf32>) outs(%656 : memref<1x12x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %655 : memref<1x12x384xf32>
    %657 = memref.subview %656[0, 0, 0] [1, 1, 384] [1, 1, 1] : memref<1x12x384xf32> to memref<1x1x384xf32, #map19>
    %658 = memref.collapse_shape %657 [[0, 1], [2]] : memref<1x1x384xf32, #map19> into memref<1x384xf32, #map20>
    %659 = memref.alloc() : memref<1x384xf32>
    memref.copy %658, %659 : memref<1x384xf32, #map20> to memref<1x384xf32>
    memref.dealloc %656 : memref<1x12x384xf32>
    %660 = memref.alloc() {alignment = 128 : i64} : memref<384x384xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%3 : memref<384x384xf32>) outs(%660 : memref<384x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %661 = memref.alloc() {alignment = 128 : i64} : memref<1x384xf32>
    linalg.fill ins(%cst_4 : f32) outs(%661 : memref<1x384xf32>)
    %662 = memref.alloc() {alignment = 128 : i64} : memref<1x384xf32>
    memref.copy %661, %662 : memref<1x384xf32> to memref<1x384xf32>
    memref.dealloc %661 : memref<1x384xf32>
    linalg.matmul ins(%659, %660 : memref<1x384xf32>, memref<384x384xf32>) outs(%662 : memref<1x384xf32>)
    memref.dealloc %660 : memref<384x384xf32>
    memref.dealloc %659 : memref<1x384xf32>
    %663 = memref.alloc() {alignment = 128 : i64} : memref<1x384xf32>
    linalg.generic {indexing_maps = [#map0, #map21, #map1], iterator_types = ["parallel", "parallel"]} ins(%662, %4 : memref<1x384xf32>, memref<384xf32>) outs(%663 : memref<1x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %662 : memref<1x384xf32>
    %664 = memref.alloc() {alignment = 128 : i64} : memref<1x384xf32>
    linalg.generic {indexing_maps = [#map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%663 : memref<1x384xf32>) outs(%664 : memref<1x384xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      %669 = math.tanh %arg2 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %663 : memref<1x384xf32>
    %665 = memref.alloc() {alignment = 128 : i64} : memref<384x2xf32>
    linalg.generic {indexing_maps = [#map1, #map12], iterator_types = ["parallel", "parallel"]} ins(%1 : memref<2x384xf32>) outs(%665 : memref<384x2xf32>) {
    ^bb0(%arg2: f32, %arg3: f32):
      linalg.yield %arg2 : f32
    }
    %666 = memref.alloc() {alignment = 128 : i64} : memref<1x2xf32>
    linalg.fill ins(%cst_4 : f32) outs(%666 : memref<1x2xf32>)
    %667 = memref.alloc() {alignment = 128 : i64} : memref<1x2xf32>
    memref.copy %666, %667 : memref<1x2xf32> to memref<1x2xf32>
    memref.dealloc %666 : memref<1x2xf32>
    linalg.matmul ins(%664, %665 : memref<1x384xf32>, memref<384x2xf32>) outs(%667 : memref<1x2xf32>)
    memref.dealloc %665 : memref<384x2xf32>
    memref.dealloc %664 : memref<1x384xf32>
    %668 = memref.alloc() {alignment = 128 : i64} : memref<1x2xf32>
    linalg.generic {indexing_maps = [#map0, #map21, #map1], iterator_types = ["parallel", "parallel"]} ins(%667, %2 : memref<1x2xf32>, memref<2xf32>) outs(%668 : memref<1x2xf32>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %669 = arith.addf %arg2, %arg3 : f32
      linalg.yield %669 : f32
    }
    memref.dealloc %667 : memref<1x2xf32>
    memref.copy %668, %arg1 : memref<1x2xf32> to memref<1x2xf32>
    return
  }
}

