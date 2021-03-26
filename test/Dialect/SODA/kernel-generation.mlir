// RUN: soda-opt -allow-unregistered-dialect -soda-outline-bambu-code -soda-generate-bambu-accelcode %s | FileCheck %s

// CHECK: module attributes {soda.container_module}

// CHECK-LABEL: func @driver()
func @driver() {
  // CHECK-NOT: "loadA"
  %A = "loadA"() : () -> (memref<512x512xf32>)
  // CHECK-NOT: "loadB"
  %B = "loadB"() : () -> (memref<512x512xf32>)
  // CHECK-NOT: "allocateC"
  %C = "allocateC"() : () -> (memref<512x512xf32>)

  // CHECK-NOT: soda.launch blocks
  // CHECK-NOT: soda.launch_func blocks
  soda.launch  {
    linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                    outs(%C : memref<512x512xf32>)
    soda.terminator
  }

  return
}