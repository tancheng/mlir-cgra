// RUN: soda-opt -split-input-file -allow-unregistered-dialect -soda-outline-bambu-code -soda-generate-bambu-accelcode %s | FileCheck %s

// CHECK: module attributes {soda.bambu.container_module
func @driver() {
  // CHECK-NOT: "loadA"
  %A = "loadA"() : () -> (memref<512x512xf32>)
  // CHECK-NOT: "loadB"
  %B = "loadB"() : () -> (memref<512x512xf32>)
  // CHECK-NOT: "allocateC"
  %C = "allocateC"() : () -> (memref<512x512xf32>)

  // CHECK-NOT: "soda.func"
  soda.launch  {
    linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                    outs(%C : memref<512x512xf32>)
    soda.terminator
  }
  // CHECK-NOT: "soda.return"

  return
}

// -----

// CHECK: module attributes {soda.bambu.container_module
func @complex() {
  %A = "loadA"() : () -> (memref<512x512xf32>)
  %B = call @init_b(): () -> (memref<512x512xf32>)

  soda.launch  {
    // CHECK call @init_c
    %C = call @init_c(): () -> (memref<512x512xf32>)
    linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                    outs(%C : memref<512x512xf32>)
    soda.terminator
  }
  // CHECK-NOT: "soda.return"
  return
}

// CHECK-NOT: func private @init_b
func private @init_b() -> (memref<512x512xf32>)
// CHECK: func private @init_c
func private @init_c() -> (memref<512x512xf32>)