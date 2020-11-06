// RUN: soda-opt -allow-unregistered-dialect -soda-kernel-outlining %s | FileCheck %s

// CHECK: module attributes {soda.container_module}

// CHECK-LABEL: func @driver()
func @driver() {
  // CHECK: %[[ARG0:.*]] = "loadA"() : () -> memref<512x512xf32>
  %A = "loadA"() : () -> (memref<512x512xf32>)
  // CHECK: %[[ARG1:.*]] = "loadB"() : () -> memref<512x512xf32>
  %B = "loadB"() : () -> (memref<512x512xf32>)
  // CHECK: %[[ARG2:.*]] = "allocateC"() : () -> memref<512x512xf32>
  %C = "allocateC"() : () -> (memref<512x512xf32>)

  // CHECK: %[[GDIMX:.*]] = constant 8
  %gDimX = constant 8 : index
  // CHECK: %[[GDIMY:.*]] = constant 12
  %gDimY = constant 12 : index
  // CHECK: %[[GDIMZ:.*]] = constant 16
  %gDimZ = constant 16 : index
  // CHECK: %[[BDIMX:.*]] = constant 20
  %bDimX = constant 20 : index
  // CHECK: %[[BDIMY:.*]] = constant 24
  %bDimY = constant 24 : index
  // CHECK: %[[BDIMZ:.*]] = constant 28
  %bDimZ = constant 28 : index

  // CHECK: soda.launch_func @driver_kernel::@driver_kernel blocks in (%[[GDIMX]], %[[GDIMY]], %[[GDIMZ]]) threads in (%[[BDIMX]], %[[BDIMY]], %[[BDIMZ]]) args(%[[ARG0]] : memref<512x512xf32>, %[[ARG1]] : memref<512x512xf32>, %[[ARG2]] : memref<512x512xf32>)
  // CHECK-NOT: soda.launch blocks
  soda.launch blocks(%bx, %by, %bz) in (%grid_x = %gDimX, %grid_y = %gDimY,
                                       %grid_z = %gDimZ)
             threads(%tx, %ty, %tz) in (%block_x = %bDimX, %block_y = %bDimY,
                                        %block_z = %bDimZ) {
    linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                    outs(%C : memref<512x512xf32>)
    soda.terminator
  }

  return
}

// Performs AxB accumulating results on C
func @matmul_kernel(%A:memref<512x512xf32>, %B:memref<512x512xf32>, %C : memref<512x512xf32>) {
  linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                outs(%C : memref<512x512xf32>)
  return
}
