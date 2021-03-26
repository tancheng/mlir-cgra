// RUN: soda-opt -convert-linalg-conv-to-soda %s | FileCheck  %s

// CHECK: @my_conv
func @my_conv(%filter: memref<5x5x1x32xf32>, %input: memref<1x28x28x1xf32>, %output: memref<1x28x28x32xf32>) {
  // CHECK: soda.launch
  // CHECK-NEXT: linalg.conv

  linalg.conv(%filter, %input, %output) {
      dilations = [2,3],
      strides = [4,6],
      padding = dense<[[7,8],[9,10]]> : tensor<2x2xi64> 
    } : memref<5x5x1x32xf32>, memref<1x28x28x1xf32>, memref<1x28x28x32xf32>
  // CHECK: soda.terminator
  return
}