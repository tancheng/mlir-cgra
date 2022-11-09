#map0 = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (0, 0, 0, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> ()>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map7 = affine_map<(d0, d1, d2) -> (0, d1, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map9 = affine_map<(d0, d1, d2) -> (0, d1, 0)>
#map10 = affine_map<(d0, d1, d2) -> (d2)>
#map11 = affine_map<(d0, d1) -> (d1, d0)>
#map12 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map13 = affine_map<(d0, d1, d2, d3) -> (d0, d2, d1, d3)>
#map14 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3, d2)>
#map15 = affine_map<(d0, d1, d2, d3) -> (0, d1, d2, d3)>
#map16 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
#map17 = affine_map<(d0, d1, d2, d3) -> (0, d1, d2, 0)>
#map18 = affine_map<(d0, d1) -> (d1)>
module attributes {torch.debug_module_name = "OnlyLogitsHuggingFaceModel"} {
  func.func @forward(%arg0: tensor<1x12xi64>) -> tensor<1x2xf32> {
    %cst = arith.constant dense_resource<__elided__> : tensor<2x384xf32>
    %cst_0 = arith.constant dense<[-0.00115577725, 0.00115577038]> : tensor<2xf32>
    %cst_1 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_2 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_3 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_4 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_5 = arith.constant dense_resource<__elided__> : tensor<384x1536xf32>
    %cst_6 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_7 = arith.constant dense_resource<__elided__> : tensor<1536x384xf32>
    %cst_8 = arith.constant dense_resource<__elided__> : tensor<1536xf32>
    %cst_9 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_10 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_11 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_12 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_13 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_14 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_15 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_16 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_17 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_18 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_19 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_20 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_21 = arith.constant dense_resource<__elided__> : tensor<384x1536xf32>
    %cst_22 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_23 = arith.constant dense_resource<__elided__> : tensor<1536x384xf32>
    %cst_24 = arith.constant dense_resource<__elided__> : tensor<1536xf32>
    %cst_25 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_26 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_27 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_28 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_29 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_30 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_31 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_32 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_33 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_34 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_35 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_36 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_37 = arith.constant dense_resource<__elided__> : tensor<384x1536xf32>
    %cst_38 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_39 = arith.constant dense_resource<__elided__> : tensor<1536x384xf32>
    %cst_40 = arith.constant dense_resource<__elided__> : tensor<1536xf32>
    %cst_41 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_42 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_43 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_44 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_45 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_46 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_47 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_48 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_49 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_50 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_51 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_52 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_53 = arith.constant dense_resource<__elided__> : tensor<384x1536xf32>
    %cst_54 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_55 = arith.constant dense_resource<__elided__> : tensor<1536x384xf32>
    %cst_56 = arith.constant dense_resource<__elided__> : tensor<1536xf32>
    %cst_57 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_58 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_59 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_60 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_61 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_62 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_63 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_64 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_65 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_66 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_67 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_68 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_69 = arith.constant dense_resource<__elided__> : tensor<384x1536xf32>
    %cst_70 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_71 = arith.constant dense_resource<__elided__> : tensor<1536x384xf32>
    %cst_72 = arith.constant dense_resource<__elided__> : tensor<1536xf32>
    %cst_73 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_74 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_75 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_76 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_77 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_78 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_79 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_80 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_81 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_82 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_83 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_84 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_85 = arith.constant dense_resource<__elided__> : tensor<384x1536xf32>
    %cst_86 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_87 = arith.constant dense_resource<__elided__> : tensor<1536x384xf32>
    %cst_88 = arith.constant dense_resource<__elided__> : tensor<1536xf32>
    %cst_89 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_90 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_91 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_92 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_93 = arith.constant dense<5.6568542494923806> : tensor<f64>
    %cst_94 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_95 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_96 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_97 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_98 = arith.constant dense_resource<__elided__> : tensor<384x384xf32>
    %cst_99 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_100 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_101 = arith.constant dense_resource<__elided__> : tensor<384xf32>
    %cst_102 = arith.constant dense_resource<__elided__> : tensor<512x384xf32>
    %cst_103 = arith.constant dense_resource<__elided__> : tensor<2x384xf32>
    %cst_104 = arith.constant dense_resource<__elided__> : tensor<30522x384xf32>
    %cst_105 = arith.constant dense_resource<__elided__> : tensor<1x512xi64>
    %cst_106 = arith.constant dense<-3.4028234663852886E+38> : tensor<f64>
    %cst_107 = arith.constant dense<0> : tensor<1x512xi64>
    %cst_108 = arith.constant 1.000000e+00 : f32
    %c512 = arith.constant 512 : index
    %c30522 = arith.constant 30522 : index
    %cst_109 = arith.constant 0.000000e+00 : f32
    %cst_110 = arith.constant -3.40282347E+38 : f32
    %cst_111 = arith.constant 1.41421354 : f32
    %cst_112 = arith.constant 5.000000e-01 : f32
    %c0_i64 = arith.constant 0 : i64
    %cst_113 = arith.constant 9.9999999999999998E-13 : f64
    %cst_114 = arith.constant 3.840000e+02 : f32
    %c2 = arith.constant 2 : index
    %0 = tensor.extract_slice %cst_107[0, 0] [1, 12] [1, 1] : tensor<1x512xi64> to tensor<1x12xi64>
    %1 = linalg.init_tensor [1, 12] : tensor<1x12xi64>
    %2 = linalg.generic {indexing_maps = [#map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%0 : tensor<1x12xi64>) outs(%1 : tensor<1x12xi64>) {
    ^bb0(%arg1: i64, %arg2: i64):
      linalg.yield %arg1 : i64
    } -> tensor<1x12xi64>
    %3 = linalg.init_tensor [1, 1, 1, 12] : tensor<1x1x1x12xf32>
    %4 = linalg.fill ins(%cst_108 : f32) outs(%3 : tensor<1x1x1x12xf32>) -> tensor<1x1x1x12xf32>
    %5 = linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%4 : tensor<1x1x1x12xf32>) outs(%3 : tensor<1x1x1x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.subf %cst_108, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x1x1x12xf32>
    %6 = linalg.generic {indexing_maps = [#map2, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5, %cst_106 : tensor<1x1x1x12xf32>, tensor<f64>) outs(%3 : tensor<1x1x1x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f64, %arg3: f32):
      %670 = arith.truncf %arg2 : f64 to f32
      %671 = arith.mulf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x1x1x12xf32>
    %7 = tensor.extract_slice %cst_105[0, 0] [1, 12] [1, 1] : tensor<1x512xi64> to tensor<1x12xi64>
    %8 = linalg.init_tensor [1, 12, 384] : tensor<1x12x384xf32>
    %9 = linalg.generic {indexing_maps = [#map5, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<1x12xi64>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: i64, %arg2: f32):
      %670 = arith.index_cast %arg1 : i64 to index
      %671 = linalg.index 2 : index
      %672 = arith.cmpi slt, %670, %c30522 : index
      cf.assert %672, "index must be smaller than dim size"
      %673 = arith.cmpi sge, %arg1, %c0_i64 : i64
      cf.assert %673, "index must be larger or equal to 0"
      %674 = tensor.extract %cst_104[%670, %671] : tensor<30522x384xf32>
      linalg.yield %674 : f32
    } -> tensor<1x12x384xf32>
    %10 = linalg.generic {indexing_maps = [#map5, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<1x12xi64>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: i64, %arg2: f32):
      %670 = arith.index_cast %arg1 : i64 to index
      %671 = linalg.index 2 : index
      %672 = arith.cmpi slt, %670, %c2 : index
      cf.assert %672, "index must be smaller than dim size"
      %673 = arith.cmpi sge, %arg1, %c0_i64 : i64
      cf.assert %673, "index must be larger or equal to 0"
      %674 = tensor.extract %cst_103[%670, %671] : tensor<2x384xf32>
      linalg.yield %674 : f32
    } -> tensor<1x12x384xf32>
    %11 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9, %10 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %12 = linalg.generic {indexing_maps = [#map5, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%7 : tensor<1x12xi64>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: i64, %arg2: f32):
      %670 = arith.index_cast %arg1 : i64 to index
      %671 = linalg.index 2 : index
      %672 = arith.cmpi slt, %670, %c512 : index
      cf.assert %672, "index must be smaller than dim size"
      %673 = arith.cmpi sge, %arg1, %c0_i64 : i64
      cf.assert %673, "index must be larger or equal to 0"
      %674 = tensor.extract %cst_102[%670, %671] : tensor<512x384xf32>
      linalg.yield %674 : f32
    } -> tensor<1x12x384xf32>
    %13 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%11, %12 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %14 = linalg.init_tensor [1, 12, 1] : tensor<1x12x1xf32>
    %15 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %16 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%13 : tensor<1x12x384xf32>) outs(%15 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %17 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%16 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %18 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%17 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %19 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13, %18 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %20 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%19 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %21 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %22 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%20 : tensor<1x12x384xf32>) outs(%21 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %23 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%22 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %24 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%23 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %25 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%24 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %26 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%25 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %27 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%19, %26 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %28 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%27, %cst_100 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %29 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%28, %cst_101 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %30 = linalg.init_tensor [384, 384] : tensor<384x384xf32>
    %31 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_98 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %32 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%29 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %33 = linalg.init_tensor [1, 384, 384] : tensor<1x384x384xf32>
    %34 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%31 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %35 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %36 = linalg.batch_matmul ins(%32, %34 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%35 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %37 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%36, %cst_99 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %38 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_96 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %39 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%29 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %40 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%38 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %41 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %42 = linalg.batch_matmul ins(%39, %40 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%41 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %43 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%42, %cst_97 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %44 = tensor.expand_shape %43 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %45 = linalg.init_tensor [1, 12, 12, 32] : tensor<1x12x12x32xf32>
    %46 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%44 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %47 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_94 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %48 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%29 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %49 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%47 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %50 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %51 = linalg.batch_matmul ins(%48, %49 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%50 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %52 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%51, %cst_95 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %53 = tensor.expand_shape %52 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %54 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%53 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %55 = tensor.expand_shape %37 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %56 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%55 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %57 = linalg.init_tensor [1, 12, 32, 12] : tensor<1x12x32x12xf32>
    %58 = linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%46 : tensor<1x12x12x32xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %59 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%56 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %60 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%58 : tensor<1x12x32x12xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %61 = tensor.collapse_shape %59 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %62 = tensor.collapse_shape %60 [[0, 1], [2], [3]] : tensor<1x12x32x12xf32> into tensor<12x32x12xf32>
    %63 = linalg.init_tensor [12, 12, 12] : tensor<12x12x12xf32>
    %64 = linalg.fill ins(%cst_109 : f32) outs(%63 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %65 = linalg.batch_matmul ins(%61, %62 : tensor<12x12x32xf32>, tensor<12x32x12xf32>) outs(%64 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %66 = tensor.expand_shape %65 [[0, 1], [2], [3]] : tensor<12x12x12xf32> into tensor<1x12x12x12xf32>
    %67 = linalg.init_tensor [1, 12, 12, 12] : tensor<1x12x12x12xf32>
    %68 = linalg.generic {indexing_maps = [#map15, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%66, %cst_93 : tensor<1x12x12x12xf32>, tensor<f64>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f64, %arg3: f32):
      %670 = arith.truncf %arg2 : f64 to f32
      %671 = arith.divf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x12x12xf32>
    %69 = linalg.generic {indexing_maps = [#map15, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%68, %6 : tensor<1x12x12x12xf32>, tensor<1x1x1x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %70 = linalg.init_tensor [1, 12, 12, 1] : tensor<1x12x12x1xi64>
    %71 = linalg.fill ins(%c0_i64 : i64) outs(%70 : tensor<1x12x12x1xi64>) -> tensor<1x12x12x1xi64>
    %72 = linalg.init_tensor [1, 12, 12, 1] : tensor<1x12x12x1xf32>
    %73 = linalg.fill ins(%cst_110 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %74:2 = linalg.generic {indexing_maps = [#map3, #map16, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%69 : tensor<1x12x12x12xf32>) outs(%73, %71 : tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: i64):
      %670 = linalg.index 3 : index
      %671 = arith.index_cast %670 : index to i64
      %672 = arith.maxf %arg1, %arg2 : f32
      %673 = arith.cmpf ogt, %arg1, %arg2 : f32
      %674 = arith.select %673, %671, %arg3 : i64
      linalg.yield %672, %674 : f32, i64
    } -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>)
    %75 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%69, %74#0 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %76 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%75 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.exp %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %77 = linalg.fill ins(%cst_109 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %78 = linalg.generic {indexing_maps = [#map3, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%76 : tensor<1x12x12x12xf32>) outs(%77 : tensor<1x12x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x1xf32>
    %79 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%76, %78 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.divf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %80 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%79 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x12xf32>
    %81 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%54 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %82 = tensor.collapse_shape %80 [[0, 1], [2], [3]] : tensor<1x12x12x12xf32> into tensor<12x12x12xf32>
    %83 = tensor.collapse_shape %81 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %84 = linalg.init_tensor [12, 12, 32] : tensor<12x12x32xf32>
    %85 = linalg.fill ins(%cst_109 : f32) outs(%84 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %86 = linalg.batch_matmul ins(%82, %83 : tensor<12x12x12xf32>, tensor<12x12x32xf32>) outs(%85 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %87 = tensor.expand_shape %86 [[0, 1], [2], [3]] : tensor<12x12x32xf32> into tensor<1x12x12x32xf32>
    %88 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%87 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %89 = tensor.collapse_shape %88 [[0], [1], [2, 3]] : tensor<1x12x12x32xf32> into tensor<1x12x384xf32>
    %90 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_91 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %91 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%89 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %92 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%90 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %93 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %94 = linalg.batch_matmul ins(%91, %92 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%93 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %95 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%94, %cst_92 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %96 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%95, %29 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %97 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %98 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%96 : tensor<1x12x384xf32>) outs(%97 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %99 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%98 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %100 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%99 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %101 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%96, %100 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %102 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%101 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %103 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %104 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%102 : tensor<1x12x384xf32>) outs(%103 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %105 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%104 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %106 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%105 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %107 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%106 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %108 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%107 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %109 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%101, %108 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %110 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%109, %cst_89 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %111 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%110, %cst_90 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %112 = linalg.init_tensor [384, 1536] : tensor<384x1536xf32>
    %113 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_87 : tensor<1536x384xf32>) outs(%112 : tensor<384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x1536xf32>
    %114 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%111 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %115 = linalg.init_tensor [1, 384, 1536] : tensor<1x384x1536xf32>
    %116 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%113 : tensor<384x1536xf32>) outs(%115 : tensor<1x384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x1536xf32>
    %117 = linalg.init_tensor [1, 12, 1536] : tensor<1x12x1536xf32>
    %118 = linalg.fill ins(%cst_109 : f32) outs(%117 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %119 = linalg.batch_matmul ins(%114, %116 : tensor<1x12x384xf32>, tensor<1x384x1536xf32>) outs(%118 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %120 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%119, %cst_88 : tensor<1x12x1536xf32>, tensor<1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1536xf32>
    %121 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%120 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_111 : f32
      %671 = math.erf %670 : f32
      %672 = arith.addf %671, %cst_108 : f32
      %673 = arith.mulf %672, %cst_112 : f32
      %674 = arith.mulf %arg1, %673 : f32
      linalg.yield %674 : f32
    } -> tensor<1x12x1536xf32>
    %122 = linalg.init_tensor [1536, 384] : tensor<1536x384xf32>
    %123 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_85 : tensor<384x1536xf32>) outs(%122 : tensor<1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1536x384xf32>
    %124 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%121 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x1536xf32>
    %125 = linalg.init_tensor [1, 1536, 384] : tensor<1x1536x384xf32>
    %126 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%123 : tensor<1536x384xf32>) outs(%125 : tensor<1x1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x1536x384xf32>
    %127 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %128 = linalg.batch_matmul ins(%124, %126 : tensor<1x12x1536xf32>, tensor<1x1536x384xf32>) outs(%127 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %129 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%128, %cst_86 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %130 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%129, %111 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %131 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %132 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%130 : tensor<1x12x384xf32>) outs(%131 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %133 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%132 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %134 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%133 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %135 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%130, %134 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %136 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%135 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %137 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %138 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%136 : tensor<1x12x384xf32>) outs(%137 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %139 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%138 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %140 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%139 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %141 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%140 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %142 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%141 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %143 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%135, %142 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %144 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%143, %cst_83 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %145 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%144, %cst_84 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %146 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_81 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %147 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%145 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %148 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%146 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %149 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %150 = linalg.batch_matmul ins(%147, %148 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%149 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %151 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%150, %cst_82 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %152 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_79 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %153 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%145 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %154 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%152 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %155 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %156 = linalg.batch_matmul ins(%153, %154 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%155 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %157 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%156, %cst_80 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %158 = tensor.expand_shape %157 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %159 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%158 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %160 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_77 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %161 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%145 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %162 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%160 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %163 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %164 = linalg.batch_matmul ins(%161, %162 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%163 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %165 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%164, %cst_78 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %166 = tensor.expand_shape %165 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %167 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%166 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %168 = tensor.expand_shape %151 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %169 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%168 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %170 = linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%159 : tensor<1x12x12x32xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %171 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%169 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %172 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%170 : tensor<1x12x32x12xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %173 = tensor.collapse_shape %171 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %174 = tensor.collapse_shape %172 [[0, 1], [2], [3]] : tensor<1x12x32x12xf32> into tensor<12x32x12xf32>
    %175 = linalg.fill ins(%cst_109 : f32) outs(%63 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %176 = linalg.batch_matmul ins(%173, %174 : tensor<12x12x32xf32>, tensor<12x32x12xf32>) outs(%175 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %177 = tensor.expand_shape %176 [[0, 1], [2], [3]] : tensor<12x12x12xf32> into tensor<1x12x12x12xf32>
    %178 = linalg.generic {indexing_maps = [#map15, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%177, %cst_93 : tensor<1x12x12x12xf32>, tensor<f64>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f64, %arg3: f32):
      %670 = arith.truncf %arg2 : f64 to f32
      %671 = arith.divf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x12x12xf32>
    %179 = linalg.generic {indexing_maps = [#map15, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%178, %6 : tensor<1x12x12x12xf32>, tensor<1x1x1x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %180 = linalg.fill ins(%c0_i64 : i64) outs(%70 : tensor<1x12x12x1xi64>) -> tensor<1x12x12x1xi64>
    %181 = linalg.fill ins(%cst_110 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %182:2 = linalg.generic {indexing_maps = [#map3, #map16, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%179 : tensor<1x12x12x12xf32>) outs(%181, %180 : tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: i64):
      %670 = linalg.index 3 : index
      %671 = arith.index_cast %670 : index to i64
      %672 = arith.maxf %arg1, %arg2 : f32
      %673 = arith.cmpf ogt, %arg1, %arg2 : f32
      %674 = arith.select %673, %671, %arg3 : i64
      linalg.yield %672, %674 : f32, i64
    } -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>)
    %183 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%179, %182#0 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %184 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%183 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.exp %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %185 = linalg.fill ins(%cst_109 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %186 = linalg.generic {indexing_maps = [#map3, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%184 : tensor<1x12x12x12xf32>) outs(%185 : tensor<1x12x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x1xf32>
    %187 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%184, %186 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.divf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %188 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%187 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x12xf32>
    %189 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%167 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %190 = tensor.collapse_shape %188 [[0, 1], [2], [3]] : tensor<1x12x12x12xf32> into tensor<12x12x12xf32>
    %191 = tensor.collapse_shape %189 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %192 = linalg.fill ins(%cst_109 : f32) outs(%84 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %193 = linalg.batch_matmul ins(%190, %191 : tensor<12x12x12xf32>, tensor<12x12x32xf32>) outs(%192 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %194 = tensor.expand_shape %193 [[0, 1], [2], [3]] : tensor<12x12x32xf32> into tensor<1x12x12x32xf32>
    %195 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%194 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %196 = tensor.collapse_shape %195 [[0], [1], [2, 3]] : tensor<1x12x12x32xf32> into tensor<1x12x384xf32>
    %197 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_75 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %198 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%196 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %199 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%197 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %200 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %201 = linalg.batch_matmul ins(%198, %199 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%200 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %202 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%201, %cst_76 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %203 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%202, %145 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %204 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %205 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%203 : tensor<1x12x384xf32>) outs(%204 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %206 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%205 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %207 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%206 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %208 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%203, %207 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %209 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%208 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %210 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %211 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%209 : tensor<1x12x384xf32>) outs(%210 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %212 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%211 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %213 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%212 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %214 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%213 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %215 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%214 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %216 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%208, %215 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %217 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%216, %cst_73 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %218 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%217, %cst_74 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %219 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_71 : tensor<1536x384xf32>) outs(%112 : tensor<384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x1536xf32>
    %220 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%218 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %221 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%219 : tensor<384x1536xf32>) outs(%115 : tensor<1x384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x1536xf32>
    %222 = linalg.fill ins(%cst_109 : f32) outs(%117 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %223 = linalg.batch_matmul ins(%220, %221 : tensor<1x12x384xf32>, tensor<1x384x1536xf32>) outs(%222 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %224 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%223, %cst_72 : tensor<1x12x1536xf32>, tensor<1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1536xf32>
    %225 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%224 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_111 : f32
      %671 = math.erf %670 : f32
      %672 = arith.addf %671, %cst_108 : f32
      %673 = arith.mulf %672, %cst_112 : f32
      %674 = arith.mulf %arg1, %673 : f32
      linalg.yield %674 : f32
    } -> tensor<1x12x1536xf32>
    %226 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_69 : tensor<384x1536xf32>) outs(%122 : tensor<1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1536x384xf32>
    %227 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%225 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x1536xf32>
    %228 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%226 : tensor<1536x384xf32>) outs(%125 : tensor<1x1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x1536x384xf32>
    %229 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %230 = linalg.batch_matmul ins(%227, %228 : tensor<1x12x1536xf32>, tensor<1x1536x384xf32>) outs(%229 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %231 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%230, %cst_70 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %232 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%231, %218 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %233 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %234 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%232 : tensor<1x12x384xf32>) outs(%233 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %235 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%234 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %236 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%235 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %237 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%232, %236 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %238 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%237 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %239 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %240 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%238 : tensor<1x12x384xf32>) outs(%239 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %241 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%240 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %242 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%241 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %243 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%242 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %244 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%243 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %245 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%237, %244 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %246 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%245, %cst_67 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %247 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%246, %cst_68 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %248 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_65 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %249 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%247 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %250 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%248 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %251 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %252 = linalg.batch_matmul ins(%249, %250 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%251 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %253 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%252, %cst_66 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %254 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_63 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %255 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%247 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %256 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%254 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %257 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %258 = linalg.batch_matmul ins(%255, %256 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%257 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %259 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%258, %cst_64 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %260 = tensor.expand_shape %259 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %261 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%260 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %262 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_61 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %263 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%247 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %264 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%262 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %265 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %266 = linalg.batch_matmul ins(%263, %264 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%265 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %267 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%266, %cst_62 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %268 = tensor.expand_shape %267 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %269 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%268 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %270 = tensor.expand_shape %253 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %271 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%270 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %272 = linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%261 : tensor<1x12x12x32xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %273 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%271 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %274 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%272 : tensor<1x12x32x12xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %275 = tensor.collapse_shape %273 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %276 = tensor.collapse_shape %274 [[0, 1], [2], [3]] : tensor<1x12x32x12xf32> into tensor<12x32x12xf32>
    %277 = linalg.fill ins(%cst_109 : f32) outs(%63 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %278 = linalg.batch_matmul ins(%275, %276 : tensor<12x12x32xf32>, tensor<12x32x12xf32>) outs(%277 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %279 = tensor.expand_shape %278 [[0, 1], [2], [3]] : tensor<12x12x12xf32> into tensor<1x12x12x12xf32>
    %280 = linalg.generic {indexing_maps = [#map15, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%279, %cst_93 : tensor<1x12x12x12xf32>, tensor<f64>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f64, %arg3: f32):
      %670 = arith.truncf %arg2 : f64 to f32
      %671 = arith.divf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x12x12xf32>
    %281 = linalg.generic {indexing_maps = [#map15, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%280, %6 : tensor<1x12x12x12xf32>, tensor<1x1x1x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %282 = linalg.fill ins(%c0_i64 : i64) outs(%70 : tensor<1x12x12x1xi64>) -> tensor<1x12x12x1xi64>
    %283 = linalg.fill ins(%cst_110 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %284:2 = linalg.generic {indexing_maps = [#map3, #map16, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%281 : tensor<1x12x12x12xf32>) outs(%283, %282 : tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: i64):
      %670 = linalg.index 3 : index
      %671 = arith.index_cast %670 : index to i64
      %672 = arith.maxf %arg1, %arg2 : f32
      %673 = arith.cmpf ogt, %arg1, %arg2 : f32
      %674 = arith.select %673, %671, %arg3 : i64
      linalg.yield %672, %674 : f32, i64
    } -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>)
    %285 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%281, %284#0 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %286 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%285 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.exp %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %287 = linalg.fill ins(%cst_109 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %288 = linalg.generic {indexing_maps = [#map3, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%286 : tensor<1x12x12x12xf32>) outs(%287 : tensor<1x12x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x1xf32>
    %289 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%286, %288 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.divf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %290 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%289 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x12xf32>
    %291 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%269 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %292 = tensor.collapse_shape %290 [[0, 1], [2], [3]] : tensor<1x12x12x12xf32> into tensor<12x12x12xf32>
    %293 = tensor.collapse_shape %291 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %294 = linalg.fill ins(%cst_109 : f32) outs(%84 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %295 = linalg.batch_matmul ins(%292, %293 : tensor<12x12x12xf32>, tensor<12x12x32xf32>) outs(%294 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %296 = tensor.expand_shape %295 [[0, 1], [2], [3]] : tensor<12x12x32xf32> into tensor<1x12x12x32xf32>
    %297 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%296 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %298 = tensor.collapse_shape %297 [[0], [1], [2, 3]] : tensor<1x12x12x32xf32> into tensor<1x12x384xf32>
    %299 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_59 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %300 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%298 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %301 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%299 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %302 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %303 = linalg.batch_matmul ins(%300, %301 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%302 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %304 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%303, %cst_60 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %305 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%304, %247 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %306 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %307 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%305 : tensor<1x12x384xf32>) outs(%306 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %308 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%307 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %309 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%308 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %310 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%305, %309 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %311 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%310 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %312 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %313 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%311 : tensor<1x12x384xf32>) outs(%312 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %314 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%313 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %315 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%314 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %316 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%315 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %317 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%316 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %318 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%310, %317 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %319 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%318, %cst_57 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %320 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%319, %cst_58 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %321 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_55 : tensor<1536x384xf32>) outs(%112 : tensor<384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x1536xf32>
    %322 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%320 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %323 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%321 : tensor<384x1536xf32>) outs(%115 : tensor<1x384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x1536xf32>
    %324 = linalg.fill ins(%cst_109 : f32) outs(%117 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %325 = linalg.batch_matmul ins(%322, %323 : tensor<1x12x384xf32>, tensor<1x384x1536xf32>) outs(%324 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %326 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%325, %cst_56 : tensor<1x12x1536xf32>, tensor<1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1536xf32>
    %327 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%326 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_111 : f32
      %671 = math.erf %670 : f32
      %672 = arith.addf %671, %cst_108 : f32
      %673 = arith.mulf %672, %cst_112 : f32
      %674 = arith.mulf %arg1, %673 : f32
      linalg.yield %674 : f32
    } -> tensor<1x12x1536xf32>
    %328 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_53 : tensor<384x1536xf32>) outs(%122 : tensor<1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1536x384xf32>
    %329 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%327 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x1536xf32>
    %330 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%328 : tensor<1536x384xf32>) outs(%125 : tensor<1x1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x1536x384xf32>
    %331 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %332 = linalg.batch_matmul ins(%329, %330 : tensor<1x12x1536xf32>, tensor<1x1536x384xf32>) outs(%331 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %333 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%332, %cst_54 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %334 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%333, %320 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %335 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %336 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%334 : tensor<1x12x384xf32>) outs(%335 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %337 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%336 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %338 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%337 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %339 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%334, %338 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %340 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%339 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %341 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %342 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%340 : tensor<1x12x384xf32>) outs(%341 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %343 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%342 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %344 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%343 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %345 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%344 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %346 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%345 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %347 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%339, %346 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %348 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%347, %cst_51 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %349 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%348, %cst_52 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %350 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_49 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %351 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%349 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %352 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%350 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %353 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %354 = linalg.batch_matmul ins(%351, %352 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%353 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %355 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%354, %cst_50 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %356 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_47 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %357 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%349 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %358 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%356 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %359 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %360 = linalg.batch_matmul ins(%357, %358 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%359 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %361 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%360, %cst_48 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %362 = tensor.expand_shape %361 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %363 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%362 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %364 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_45 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %365 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%349 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %366 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%364 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %367 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %368 = linalg.batch_matmul ins(%365, %366 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%367 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %369 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%368, %cst_46 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %370 = tensor.expand_shape %369 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %371 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%370 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %372 = tensor.expand_shape %355 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %373 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%372 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %374 = linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%363 : tensor<1x12x12x32xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %375 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%373 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %376 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%374 : tensor<1x12x32x12xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %377 = tensor.collapse_shape %375 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %378 = tensor.collapse_shape %376 [[0, 1], [2], [3]] : tensor<1x12x32x12xf32> into tensor<12x32x12xf32>
    %379 = linalg.fill ins(%cst_109 : f32) outs(%63 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %380 = linalg.batch_matmul ins(%377, %378 : tensor<12x12x32xf32>, tensor<12x32x12xf32>) outs(%379 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %381 = tensor.expand_shape %380 [[0, 1], [2], [3]] : tensor<12x12x12xf32> into tensor<1x12x12x12xf32>
    %382 = linalg.generic {indexing_maps = [#map15, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%381, %cst_93 : tensor<1x12x12x12xf32>, tensor<f64>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f64, %arg3: f32):
      %670 = arith.truncf %arg2 : f64 to f32
      %671 = arith.divf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x12x12xf32>
    %383 = linalg.generic {indexing_maps = [#map15, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%382, %6 : tensor<1x12x12x12xf32>, tensor<1x1x1x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %384 = linalg.fill ins(%c0_i64 : i64) outs(%70 : tensor<1x12x12x1xi64>) -> tensor<1x12x12x1xi64>
    %385 = linalg.fill ins(%cst_110 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %386:2 = linalg.generic {indexing_maps = [#map3, #map16, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%383 : tensor<1x12x12x12xf32>) outs(%385, %384 : tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: i64):
      %670 = linalg.index 3 : index
      %671 = arith.index_cast %670 : index to i64
      %672 = arith.maxf %arg1, %arg2 : f32
      %673 = arith.cmpf ogt, %arg1, %arg2 : f32
      %674 = arith.select %673, %671, %arg3 : i64
      linalg.yield %672, %674 : f32, i64
    } -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>)
    %387 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%383, %386#0 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %388 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%387 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.exp %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %389 = linalg.fill ins(%cst_109 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %390 = linalg.generic {indexing_maps = [#map3, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%388 : tensor<1x12x12x12xf32>) outs(%389 : tensor<1x12x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x1xf32>
    %391 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%388, %390 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.divf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %392 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%391 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x12xf32>
    %393 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%371 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %394 = tensor.collapse_shape %392 [[0, 1], [2], [3]] : tensor<1x12x12x12xf32> into tensor<12x12x12xf32>
    %395 = tensor.collapse_shape %393 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %396 = linalg.fill ins(%cst_109 : f32) outs(%84 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %397 = linalg.batch_matmul ins(%394, %395 : tensor<12x12x12xf32>, tensor<12x12x32xf32>) outs(%396 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %398 = tensor.expand_shape %397 [[0, 1], [2], [3]] : tensor<12x12x32xf32> into tensor<1x12x12x32xf32>
    %399 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%398 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %400 = tensor.collapse_shape %399 [[0], [1], [2, 3]] : tensor<1x12x12x32xf32> into tensor<1x12x384xf32>
    %401 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_43 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %402 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%400 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %403 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%401 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %404 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %405 = linalg.batch_matmul ins(%402, %403 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%404 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %406 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%405, %cst_44 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %407 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%406, %349 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %408 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %409 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%407 : tensor<1x12x384xf32>) outs(%408 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %410 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%409 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %411 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%410 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %412 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%407, %411 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %413 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%412 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %414 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %415 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%413 : tensor<1x12x384xf32>) outs(%414 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %416 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%415 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %417 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%416 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %418 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%417 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %419 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%418 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %420 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%412, %419 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %421 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%420, %cst_41 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %422 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%421, %cst_42 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %423 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_39 : tensor<1536x384xf32>) outs(%112 : tensor<384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x1536xf32>
    %424 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%422 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %425 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%423 : tensor<384x1536xf32>) outs(%115 : tensor<1x384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x1536xf32>
    %426 = linalg.fill ins(%cst_109 : f32) outs(%117 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %427 = linalg.batch_matmul ins(%424, %425 : tensor<1x12x384xf32>, tensor<1x384x1536xf32>) outs(%426 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %428 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%427, %cst_40 : tensor<1x12x1536xf32>, tensor<1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1536xf32>
    %429 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%428 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_111 : f32
      %671 = math.erf %670 : f32
      %672 = arith.addf %671, %cst_108 : f32
      %673 = arith.mulf %672, %cst_112 : f32
      %674 = arith.mulf %arg1, %673 : f32
      linalg.yield %674 : f32
    } -> tensor<1x12x1536xf32>
    %430 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_37 : tensor<384x1536xf32>) outs(%122 : tensor<1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1536x384xf32>
    %431 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%429 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x1536xf32>
    %432 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%430 : tensor<1536x384xf32>) outs(%125 : tensor<1x1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x1536x384xf32>
    %433 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %434 = linalg.batch_matmul ins(%431, %432 : tensor<1x12x1536xf32>, tensor<1x1536x384xf32>) outs(%433 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %435 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%434, %cst_38 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %436 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%435, %422 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %437 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %438 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%436 : tensor<1x12x384xf32>) outs(%437 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %439 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%438 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %440 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%439 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %441 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%436, %440 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %442 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%441 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %443 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %444 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%442 : tensor<1x12x384xf32>) outs(%443 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %445 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%444 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %446 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%445 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %447 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%446 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %448 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%447 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %449 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%441, %448 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %450 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%449, %cst_35 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %451 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%450, %cst_36 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %452 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_33 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %453 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%451 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %454 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%452 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %455 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %456 = linalg.batch_matmul ins(%453, %454 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%455 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %457 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%456, %cst_34 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %458 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_31 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %459 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%451 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %460 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%458 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %461 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %462 = linalg.batch_matmul ins(%459, %460 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%461 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %463 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%462, %cst_32 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %464 = tensor.expand_shape %463 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %465 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%464 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %466 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_29 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %467 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%451 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %468 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%466 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %469 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %470 = linalg.batch_matmul ins(%467, %468 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%469 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %471 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%470, %cst_30 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %472 = tensor.expand_shape %471 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %473 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%472 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %474 = tensor.expand_shape %457 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %475 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%474 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %476 = linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%465 : tensor<1x12x12x32xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %477 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%475 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %478 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%476 : tensor<1x12x32x12xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %479 = tensor.collapse_shape %477 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %480 = tensor.collapse_shape %478 [[0, 1], [2], [3]] : tensor<1x12x32x12xf32> into tensor<12x32x12xf32>
    %481 = linalg.fill ins(%cst_109 : f32) outs(%63 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %482 = linalg.batch_matmul ins(%479, %480 : tensor<12x12x32xf32>, tensor<12x32x12xf32>) outs(%481 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %483 = tensor.expand_shape %482 [[0, 1], [2], [3]] : tensor<12x12x12xf32> into tensor<1x12x12x12xf32>
    %484 = linalg.generic {indexing_maps = [#map15, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%483, %cst_93 : tensor<1x12x12x12xf32>, tensor<f64>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f64, %arg3: f32):
      %670 = arith.truncf %arg2 : f64 to f32
      %671 = arith.divf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x12x12xf32>
    %485 = linalg.generic {indexing_maps = [#map15, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%484, %6 : tensor<1x12x12x12xf32>, tensor<1x1x1x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %486 = linalg.fill ins(%c0_i64 : i64) outs(%70 : tensor<1x12x12x1xi64>) -> tensor<1x12x12x1xi64>
    %487 = linalg.fill ins(%cst_110 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %488:2 = linalg.generic {indexing_maps = [#map3, #map16, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%485 : tensor<1x12x12x12xf32>) outs(%487, %486 : tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: i64):
      %670 = linalg.index 3 : index
      %671 = arith.index_cast %670 : index to i64
      %672 = arith.maxf %arg1, %arg2 : f32
      %673 = arith.cmpf ogt, %arg1, %arg2 : f32
      %674 = arith.select %673, %671, %arg3 : i64
      linalg.yield %672, %674 : f32, i64
    } -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>)
    %489 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%485, %488#0 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %490 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%489 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.exp %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %491 = linalg.fill ins(%cst_109 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %492 = linalg.generic {indexing_maps = [#map3, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%490 : tensor<1x12x12x12xf32>) outs(%491 : tensor<1x12x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x1xf32>
    %493 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%490, %492 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.divf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %494 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%493 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x12xf32>
    %495 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%473 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %496 = tensor.collapse_shape %494 [[0, 1], [2], [3]] : tensor<1x12x12x12xf32> into tensor<12x12x12xf32>
    %497 = tensor.collapse_shape %495 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %498 = linalg.fill ins(%cst_109 : f32) outs(%84 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %499 = linalg.batch_matmul ins(%496, %497 : tensor<12x12x12xf32>, tensor<12x12x32xf32>) outs(%498 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %500 = tensor.expand_shape %499 [[0, 1], [2], [3]] : tensor<12x12x32xf32> into tensor<1x12x12x32xf32>
    %501 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%500 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %502 = tensor.collapse_shape %501 [[0], [1], [2, 3]] : tensor<1x12x12x32xf32> into tensor<1x12x384xf32>
    %503 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_27 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %504 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%502 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %505 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%503 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %506 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %507 = linalg.batch_matmul ins(%504, %505 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%506 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %508 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%507, %cst_28 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %509 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%508, %451 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %510 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %511 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%509 : tensor<1x12x384xf32>) outs(%510 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %512 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%511 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %513 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%512 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %514 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%509, %513 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %515 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%514 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %516 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %517 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%515 : tensor<1x12x384xf32>) outs(%516 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %518 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%517 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %519 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%518 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %520 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%519 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %521 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%520 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %522 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%514, %521 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %523 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%522, %cst_25 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %524 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%523, %cst_26 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %525 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_23 : tensor<1536x384xf32>) outs(%112 : tensor<384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x1536xf32>
    %526 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%524 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %527 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%525 : tensor<384x1536xf32>) outs(%115 : tensor<1x384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x1536xf32>
    %528 = linalg.fill ins(%cst_109 : f32) outs(%117 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %529 = linalg.batch_matmul ins(%526, %527 : tensor<1x12x384xf32>, tensor<1x384x1536xf32>) outs(%528 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %530 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%529, %cst_24 : tensor<1x12x1536xf32>, tensor<1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1536xf32>
    %531 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%530 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_111 : f32
      %671 = math.erf %670 : f32
      %672 = arith.addf %671, %cst_108 : f32
      %673 = arith.mulf %672, %cst_112 : f32
      %674 = arith.mulf %arg1, %673 : f32
      linalg.yield %674 : f32
    } -> tensor<1x12x1536xf32>
    %532 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_21 : tensor<384x1536xf32>) outs(%122 : tensor<1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1536x384xf32>
    %533 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%531 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x1536xf32>
    %534 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%532 : tensor<1536x384xf32>) outs(%125 : tensor<1x1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x1536x384xf32>
    %535 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %536 = linalg.batch_matmul ins(%533, %534 : tensor<1x12x1536xf32>, tensor<1x1536x384xf32>) outs(%535 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %537 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%536, %cst_22 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %538 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%537, %524 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %539 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %540 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%538 : tensor<1x12x384xf32>) outs(%539 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %541 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%540 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %542 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%541 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %543 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%538, %542 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %544 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%543 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %545 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %546 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%544 : tensor<1x12x384xf32>) outs(%545 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %547 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%546 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %548 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%547 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %549 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%548 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %550 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%549 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %551 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%543, %550 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %552 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%551, %cst_19 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %553 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%552, %cst_20 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %554 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_17 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %555 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%553 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %556 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%554 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %557 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %558 = linalg.batch_matmul ins(%555, %556 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%557 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %559 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%558, %cst_18 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %560 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_15 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %561 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%553 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %562 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%560 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %563 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %564 = linalg.batch_matmul ins(%561, %562 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%563 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %565 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%564, %cst_16 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %566 = tensor.expand_shape %565 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %567 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%566 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %568 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_13 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %569 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%553 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %570 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%568 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %571 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %572 = linalg.batch_matmul ins(%569, %570 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%571 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %573 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%572, %cst_14 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %574 = tensor.expand_shape %573 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %575 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%574 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %576 = tensor.expand_shape %559 [[0], [1], [2, 3]] : tensor<1x12x384xf32> into tensor<1x12x12x32xf32>
    %577 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%576 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %578 = linalg.generic {indexing_maps = [#map3, #map14], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%567 : tensor<1x12x12x32xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %579 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%577 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %580 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%578 : tensor<1x12x32x12xf32>) outs(%57 : tensor<1x12x32x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x32x12xf32>
    %581 = tensor.collapse_shape %579 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %582 = tensor.collapse_shape %580 [[0, 1], [2], [3]] : tensor<1x12x32x12xf32> into tensor<12x32x12xf32>
    %583 = linalg.fill ins(%cst_109 : f32) outs(%63 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %584 = linalg.batch_matmul ins(%581, %582 : tensor<12x12x32xf32>, tensor<12x32x12xf32>) outs(%583 : tensor<12x12x12xf32>) -> tensor<12x12x12xf32>
    %585 = tensor.expand_shape %584 [[0, 1], [2], [3]] : tensor<12x12x12xf32> into tensor<1x12x12x12xf32>
    %586 = linalg.generic {indexing_maps = [#map15, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%585, %cst_93 : tensor<1x12x12x12xf32>, tensor<f64>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f64, %arg3: f32):
      %670 = arith.truncf %arg2 : f64 to f32
      %671 = arith.divf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x12x12xf32>
    %587 = linalg.generic {indexing_maps = [#map15, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%586, %6 : tensor<1x12x12x12xf32>, tensor<1x1x1x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %588 = linalg.fill ins(%c0_i64 : i64) outs(%70 : tensor<1x12x12x1xi64>) -> tensor<1x12x12x1xi64>
    %589 = linalg.fill ins(%cst_110 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %590:2 = linalg.generic {indexing_maps = [#map3, #map16, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%587 : tensor<1x12x12x12xf32>) outs(%589, %588 : tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: i64):
      %670 = linalg.index 3 : index
      %671 = arith.index_cast %670 : index to i64
      %672 = arith.maxf %arg1, %arg2 : f32
      %673 = arith.cmpf ogt, %arg1, %arg2 : f32
      %674 = arith.select %673, %671, %arg3 : i64
      linalg.yield %672, %674 : f32, i64
    } -> (tensor<1x12x12x1xf32>, tensor<1x12x12x1xi64>)
    %591 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%587, %590#0 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %592 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%591 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.exp %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %593 = linalg.fill ins(%cst_109 : f32) outs(%72 : tensor<1x12x12x1xf32>) -> tensor<1x12x12x1xf32>
    %594 = linalg.generic {indexing_maps = [#map3, #map16], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%592 : tensor<1x12x12x12xf32>) outs(%593 : tensor<1x12x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x1xf32>
    %595 = linalg.generic {indexing_maps = [#map15, #map17, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%592, %594 : tensor<1x12x12x12xf32>, tensor<1x12x12x1xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.divf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x12x12xf32>
    %596 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%595 : tensor<1x12x12x12xf32>) outs(%67 : tensor<1x12x12x12xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x12xf32>
    %597 = linalg.generic {indexing_maps = [#map15, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%575 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %598 = tensor.collapse_shape %596 [[0, 1], [2], [3]] : tensor<1x12x12x12xf32> into tensor<12x12x12xf32>
    %599 = tensor.collapse_shape %597 [[0, 1], [2], [3]] : tensor<1x12x12x32xf32> into tensor<12x12x32xf32>
    %600 = linalg.fill ins(%cst_109 : f32) outs(%84 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %601 = linalg.batch_matmul ins(%598, %599 : tensor<12x12x12xf32>, tensor<12x12x32xf32>) outs(%600 : tensor<12x12x32xf32>) -> tensor<12x12x32xf32>
    %602 = tensor.expand_shape %601 [[0, 1], [2], [3]] : tensor<12x12x32xf32> into tensor<1x12x12x32xf32>
    %603 = linalg.generic {indexing_maps = [#map3, #map13], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%602 : tensor<1x12x12x32xf32>) outs(%45 : tensor<1x12x12x32xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x12x32xf32>
    %604 = tensor.collapse_shape %603 [[0], [1], [2, 3]] : tensor<1x12x12x32xf32> into tensor<1x12x384xf32>
    %605 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_11 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %606 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%604 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %607 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%605 : tensor<384x384xf32>) outs(%33 : tensor<1x384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x384xf32>
    %608 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %609 = linalg.batch_matmul ins(%606, %607 : tensor<1x12x384xf32>, tensor<1x384x384xf32>) outs(%608 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %610 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%609, %cst_12 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %611 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%610, %553 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %612 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %613 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%611 : tensor<1x12x384xf32>) outs(%612 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %614 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%613 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %615 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%614 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %616 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%611, %615 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %617 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%616 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %618 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %619 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%617 : tensor<1x12x384xf32>) outs(%618 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %620 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%619 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %621 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%620 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %622 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%621 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %623 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%622 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %624 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%616, %623 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %625 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%624, %cst_9 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %626 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%625, %cst_10 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %627 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_7 : tensor<1536x384xf32>) outs(%112 : tensor<384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x1536xf32>
    %628 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%626 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %629 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%627 : tensor<384x1536xf32>) outs(%115 : tensor<1x384x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x384x1536xf32>
    %630 = linalg.fill ins(%cst_109 : f32) outs(%117 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %631 = linalg.batch_matmul ins(%628, %629 : tensor<1x12x384xf32>, tensor<1x384x1536xf32>) outs(%630 : tensor<1x12x1536xf32>) -> tensor<1x12x1536xf32>
    %632 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%631, %cst_8 : tensor<1x12x1536xf32>, tensor<1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1536xf32>
    %633 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%632 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_111 : f32
      %671 = math.erf %670 : f32
      %672 = arith.addf %671, %cst_108 : f32
      %673 = arith.mulf %672, %cst_112 : f32
      %674 = arith.mulf %arg1, %673 : f32
      linalg.yield %674 : f32
    } -> tensor<1x12x1536xf32>
    %634 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_5 : tensor<384x1536xf32>) outs(%122 : tensor<1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1536x384xf32>
    %635 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%633 : tensor<1x12x1536xf32>) outs(%117 : tensor<1x12x1536xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x1536xf32>
    %636 = linalg.generic {indexing_maps = [#map12, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%634 : tensor<1536x384xf32>) outs(%125 : tensor<1x1536x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x1536x384xf32>
    %637 = linalg.fill ins(%cst_109 : f32) outs(%8 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %638 = linalg.batch_matmul ins(%635, %636 : tensor<1x12x1536xf32>, tensor<1x1536x384xf32>) outs(%637 : tensor<1x12x384xf32>) -> tensor<1x12x384xf32>
    %639 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%638, %cst_6 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %640 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%639, %626 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %641 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %642 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%640 : tensor<1x12x384xf32>) outs(%641 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %643 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%642 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %644 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%643 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %645 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%640, %644 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.subf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %646 = linalg.generic {indexing_maps = [#map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%645 : tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.mulf %arg1, %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %647 = linalg.fill ins(%cst_109 : f32) outs(%14 : tensor<1x12x1xf32>) -> tensor<1x12x1xf32>
    %648 = linalg.generic {indexing_maps = [#map6, #map8], iterator_types = ["parallel", "parallel", "reduction"]} ins(%646 : tensor<1x12x384xf32>) outs(%647 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %649 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%648 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.divf %arg1, %cst_114 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %650 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%649 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = arith.truncf %cst_113 : f64 to f32
      %671 = arith.addf %arg1, %670 : f32
      linalg.yield %671 : f32
    } -> tensor<1x12x1xf32>
    %651 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%650 : tensor<1x12x1xf32>) outs(%14 : tensor<1x12x1xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.rsqrt %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x1xf32>
    %652 = linalg.generic {indexing_maps = [#map9, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%651 : tensor<1x12x1xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x12x384xf32>
    %653 = linalg.generic {indexing_maps = [#map7, #map7, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%645, %652 : tensor<1x12x384xf32>, tensor<1x12x384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %654 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%653, %cst_3 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.mulf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %655 = linalg.generic {indexing_maps = [#map7, #map10, #map6], iterator_types = ["parallel", "parallel", "parallel"]} ins(%654, %cst_4 : tensor<1x12x384xf32>, tensor<384xf32>) outs(%8 : tensor<1x12x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x12x384xf32>
    %656 = tensor.extract_slice %655[0, 0, 0] [1, 1, 384] [1, 1, 1] : tensor<1x12x384xf32> to tensor<1x1x384xf32>
    %657 = tensor.collapse_shape %656 [[0, 1], [2]] : tensor<1x1x384xf32> into tensor<1x384xf32>
    %658 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst_1 : tensor<384x384xf32>) outs(%30 : tensor<384x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x384xf32>
    %659 = linalg.init_tensor [1, 384] : tensor<1x384xf32>
    %660 = linalg.fill ins(%cst_109 : f32) outs(%659 : tensor<1x384xf32>) -> tensor<1x384xf32>
    %661 = linalg.matmul ins(%657, %658 : tensor<1x384xf32>, tensor<384x384xf32>) outs(%660 : tensor<1x384xf32>) -> tensor<1x384xf32>
    %662 = linalg.generic {indexing_maps = [#map0, #map18, #map1], iterator_types = ["parallel", "parallel"]} ins(%661, %cst_2 : tensor<1x384xf32>, tensor<384xf32>) outs(%659 : tensor<1x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x384xf32>
    %663 = linalg.generic {indexing_maps = [#map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%662 : tensor<1x384xf32>) outs(%659 : tensor<1x384xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      %670 = math.tanh %arg1 : f32
      linalg.yield %670 : f32
    } -> tensor<1x384xf32>
    %664 = linalg.init_tensor [384, 2] : tensor<384x2xf32>
    %665 = linalg.generic {indexing_maps = [#map1, #map11], iterator_types = ["parallel", "parallel"]} ins(%cst : tensor<2x384xf32>) outs(%664 : tensor<384x2xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<384x2xf32>
    %666 = linalg.init_tensor [1, 2] : tensor<1x2xf32>
    %667 = linalg.fill ins(%cst_109 : f32) outs(%666 : tensor<1x2xf32>) -> tensor<1x2xf32>
    %668 = linalg.matmul ins(%663, %665 : tensor<1x384xf32>, tensor<384x2xf32>) outs(%667 : tensor<1x2xf32>) -> tensor<1x2xf32>
    %669 = linalg.generic {indexing_maps = [#map0, #map18, #map1], iterator_types = ["parallel", "parallel"]} ins(%668, %cst_0 : tensor<1x2xf32>, tensor<2xf32>) outs(%666 : tensor<1x2xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %670 = arith.addf %arg1, %arg2 : f32
      linalg.yield %670 : f32
    } -> tensor<1x2xf32>
    return %669 : tensor<1x2xf32>
  }
}

