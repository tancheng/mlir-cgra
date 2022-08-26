// RUN: soda-opt -allow-unregistered-dialect -soda-outline-bambu-code %s | FileCheck %s

// CHECK: module attributes {soda.container_module}

// CHECK-LABEL: func.func @driver()
func.func @driver() {
  // CHECK: %[[ARG0:.*]] = "loadA"() : () -> memref<512x512xf32>
  %A = "loadA"() : () -> (memref<512x512xf32>)
  // CHECK: %[[ARG1:.*]] = "loadB"() : () -> memref<512x512xf32>
  %B = "loadB"() : () -> (memref<512x512xf32>)
  // CHECK: %[[ARG2:.*]] = "allocateC"() : () -> memref<512x512xf32>
  %C = "allocateC"() : () -> (memref<512x512xf32>)

  // CHECK: soda.launch_func @driver_kernel::@driver_kernel args(%[[ARG0]] : memref<512x512xf32>, %[[ARG1]] : memref<512x512xf32>, %[[ARG2]] : memref<512x512xf32>)
  // CHECK-NOT: soda.launch blocks
  soda.launch  {
    linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                    outs(%C : memref<512x512xf32>)
    soda.terminator
  }

  return
}