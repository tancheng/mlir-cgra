// RUN: soda-opt -split-input-file -allow-unregistered-dialect -soda-outline-bambu-code -soda-generate-bambu-accelcode %s | FileCheck %s
// RUN: soda-opt -split-input-file -allow-unregistered-dialect -soda-outline-bambu-code -soda-generate-bambu-accelcode=no-aa %s | FileCheck %s --check-prefixes CHECKNOAA

// CHECK: module attributes {soda.bambu.container_module
func.func @driver() {
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
func.func @complex() {
  %A = "loadA"() : () -> (memref<512x512xf32>)
  %B = func.call @init_b(): () -> (memref<512x512xf32>)

  soda.launch  {
    // CHECK: call @init_c
    %C = func.call @init_c(): () -> (memref<512x512xf32>)
    linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                    outs(%C : memref<512x512xf32>)
    soda.terminator
  }
  // CHECK-NOT: "soda.return"
  return
}

// CHECK-NOT: func.func private @init_b
func.func private @init_b() -> (memref<512x512xf32>)
// CHECK: func.func private @init_c
func.func private @init_c() -> (memref<512x512xf32>)

// -----

// CHECKNOAA: func.func @gemm_4_kernel(%arg0: memref<4x4xf32>, %arg1: f32, %arg2: memref<4x4xf32>, %arg3: memref<4x4xf32>, %arg4: f32) {
// CHECK: func.func @gemm_4_kernel(%arg0: memref<4x4xf32> {llvm.noalias}, %arg1: f32, %arg2: memref<4x4xf32> {llvm.noalias}, %arg3: memref<4x4xf32> {llvm.noalias}, %arg4: f32) {
func.func @gemm_4(%arg0: f32, %arg1: f32, %arg2: memref<4x4xf32>, %arg3: memref<4x4xf32>, %arg4: memref<4x4xf32>) {
  soda.launch {                                                                                                                            
    affine.for %arg5 = 0 to 4 {                                                                                 
      affine.for %arg6 = 0 to 4 {                                                                        
        %0 = affine.load %arg2[%arg5, %arg6] : memref<4x4xf32>                   
        %1 = arith.mulf %arg1, %0 : f32                                                                      
        affine.store %1, %arg2[%arg5, %arg6] : memref<4x4xf32>      
        affine.for %arg7 = 0 to 4 {                           
          %2 = affine.load %arg3[%arg5, %arg7] : memref<4x4xf32>
          %3 = affine.load %arg4[%arg7, %arg6] : memref<4x4xf32>                                                                                     
          %4 = affine.load %arg2[%arg5, %arg6] : memref<4x4xf32>                                                                                                                                  
          %5 = arith.mulf %arg0, %2 : f32
          %6 = arith.mulf %5, %3 : f32                                                                                                                                                                  
          %7 = arith.addf %4, %6 : f32                                                                                                                                                                  
          affine.store %7, %arg2[%arg5, %arg6] : memref<4x4xf32>                                                                                                   
        }                                                                                                                                                                                         
      }                                                                                                                                                                                           
    }                                                                                                                                                                                             
    soda.terminator                             
  }                                                                                                                                                                           
  return                                                                                                                                                                                          
}  