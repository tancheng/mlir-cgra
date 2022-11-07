module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: tensor<16x32xf32>, %arg1: tensor<32x16xf32>, %arg2: tensor<16x16xf32>, %arg3: tensor<16x16xf32>) -> tensor<16x16xf32> attributes {input_names = ["X0", "X1", "X2", "X3"], output_names = ["Z0"]} {
    %0 = "onnx.Gemm"(%arg0, %arg1, %arg2) : (tensor<16x32xf32>, tensor<32x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    %1 = "onnx.Relu"(%0) : (tensor<16x16xf32>) -> tensor<16x16xf32>
    %2 = "onnx.Add"(%1, %arg3) : (tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    return %2 : tensor<16x16xf32>
  }
  "onnx.EntryPoint"() {func = @main_graph} : () -> ()
}
