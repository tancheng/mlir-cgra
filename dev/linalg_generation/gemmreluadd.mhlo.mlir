module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: tensor<16x32xf32>, %arg1: tensor<32x16xf32>, %arg2: tensor<16x16xf32>, %arg3: tensor<16x16xf32>) -> tensor<16x16xf32> attributes {input_names = ["X0", "X1", "X2", "X3"], output_names = ["Z0"]} {
    %0 = "mhlo.dot"(%arg0, %arg1) : (tensor<16x32xf32>, tensor<32x16xf32>) -> tensor<16x16xf32>
    %1 = mhlo.add %0, %arg2 : tensor<16x16xf32>
    %2 = mhlo.constant dense<0.000000e+00> : tensor<16x16xf32>
    %3 = mhlo.maximum %1, %2 : tensor<16x16xf32>
    %4 = shape.const_shape [16, 16] : tensor<2xindex>
    %5 = shape.const_shape [16, 16] : tensor<2xindex>
    %6 = shape.const_shape [16, 16] : tensor<2xindex>
    %7 = "mhlo.dynamic_broadcast_in_dim"(%3, %6) {broadcast_dimensions = dense<[0, 1]> : tensor<2xi64>} : (tensor<16x16xf32>, tensor<2xindex>) -> tensor<16x16xf32>
    %8 = "mhlo.dynamic_broadcast_in_dim"(%arg3, %6) {broadcast_dimensions = dense<[0, 1]> : tensor<2xi64>} : (tensor<16x16xf32>, tensor<2xindex>) -> tensor<16x16xf32>
    %9 = mhlo.add %7, %8 : tensor<16x16xf32>
    return %9 : tensor<16x16xf32>
  }
//  "onnx.EntryPoint"() {func = @main_graph} : () -> ()
}

