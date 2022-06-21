// RUN: soda-opt -convert-linalg-conv-to-soda %s | FileCheck  %s

// CHECK: @my_conv
func.func @my_conv(%filter: memref<5x5xf32>, %input: memref<32x32xf32>, %output: memref<28x28xf32>) {
  // CHECK: soda.launch
  // CHECK-NEXT: linalg.conv

  linalg.conv_2d 
  { 
    dilations = dense<1> : tensor<2xi64>,
    strides = dense<1> : tensor<2xi64>,
    padding = dense<0> : tensor<2x2xi64> 
  } 
  ins(%input, %filter : memref<32x32xf32>, memref<5x5xf32> ) 
  outs(%output :  memref<28x28xf32> )
  // CHECK: soda.terminator
  return
}