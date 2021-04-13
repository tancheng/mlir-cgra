// RUN: soda-opt -allow-unregistered-dialect --soda-extract-arguments-to-xml %s
// RUN: FileCheck %s -input-file=driver_kernel_test.xml


module attributes {soda.container_module}  {
  func @driver() {
    %0 = "loadA"() : () -> memref<4x7xf32>
    %1 = "loadB"() : () -> memref<7x3xf32>
    %2 = "allocateC"() : () -> memref<4x3xf32>
    soda.launch_func  @driver_kernel::@driver_kernel args(%0 : memref<4x7xf32>, %1 : memref<7x3xf32>, %2 : memref<4x3xf32>)
    return
  }
  soda.module @driver_kernel {
    soda.func @driver_kernel(%arg0: memref<4x7xf32>, %arg1: memref<7x3xf32>, %arg2: memref<4x3xf32>) kernel {
      br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<4x7xf32>, memref<7x3xf32>) outs(%arg2 : memref<4x3xf32>)
      soda.return
    }
  }
}


// CHECK: <?xml version="1.0"?>
// CHECK: <function>
// CHECK:  <testbench
// CHECK:   P0="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK:   P1="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK:   P2="0" P3="4" P4="7" P5="7" P6="1" 
// CHECK:   P7="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK:   P8="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK:   P9="0" P10="7" P11="3" P12="3" P13="1" 
// CHECK:   P14="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK:   P15="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK:   P16="0" P17="4" P18="3" P19="3" P20="1" 
// CHECK:  />
// CHECK:  </function>