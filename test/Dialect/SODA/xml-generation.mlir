// RUN: soda-opt -allow-unregistered-dialect --soda-extract-arguments-to-xml %s
// RUN:   FileCheck %s -input-file=driver_kernel_test.xml --check-prefixes=CHECK_FILE
// RUN: soda-opt -allow-unregistered-dialect --soda-extract-arguments-to-xml="write-to-terminal" %s | FileCheck %s --check-prefixes=CHECK_TERMINAL
// RUN: soda-opt -allow-unregistered-dialect --soda-extract-arguments-to-xml="write-to-terminal using-bare-ptr" %s | FileCheck %s --check-prefixes=CHECK_BARE

module attributes {soda.container_module}  {
  func.func @driver() {
    %0 = "loadA"() : () -> memref<4x7xf32>
    %1 = "loadB"() : () -> memref<7x3xf32>
    %2 = "allocateC"() : () -> memref<4x3xf32>
    soda.launch_func  @driver_kernel::@driver_kernel args(%0 : memref<4x7xf32>, %1 : memref<7x3xf32>, %2 : memref<4x3xf32>)
    return
  }
  soda.module @driver_kernel {
    soda.func @driver_kernel(%arg0: memref<4x7xf32>, %arg1: memref<7x3xf32>, %arg2: memref<4x3xf32>) kernel {
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<4x7xf32>, memref<7x3xf32>) outs(%arg2 : memref<4x3xf32>)
      soda.return
    }
  }
}

// CHECK_FILE: <?xml version="1.0"?>
// CHECK_FILE: <function>
// CHECK_FILE:  <testbench
// CHECK_FILE:   P0="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_FILE:   P1="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_FILE:   P2="0" P3="4" P4="7" P5="7" P6="1" 
// CHECK_FILE:   P7="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_FILE:   P8="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_FILE:   P9="0" P10="7" P11="3" P12="3" P13="1" 
// CHECK_FILE:   P14="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_FILE:   P15="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_FILE:   P16="0" P17="4" P18="3" P19="3" P20="1" 
// CHECK_FILE:  />
// CHECK_FILE:  </function>

// CHECK_TERMINAL: <?xml version="1.0"?>
// CHECK_TERMINAL: <function>
// CHECK_TERMINAL:  <testbench
// CHECK_TERMINAL:   P0="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_TERMINAL:   P1="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_TERMINAL:   P2="0" P3="4" P4="7" P5="7" P6="1" 
// CHECK_TERMINAL:   P7="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_TERMINAL:   P8="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_TERMINAL:   P9="0" P10="7" P11="3" P12="3" P13="1" 
// CHECK_TERMINAL:   P14="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_TERMINAL:   P15="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_TERMINAL:   P16="0" P17="4" P18="3" P19="3" P20="1" 
// CHECK_TERMINAL:  />
// CHECK_TERMINAL:  </function>

// CHECK_BARE: <?xml version="1.0"?>
// CHECK_BARE: <function>
// CHECK_BARE:  <testbench
// CHECK_BARE:   P0="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_BARE:   P1="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_BARE:   P2="{1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}"
// CHECK_BARE:  />
// CHECK_BARE:  </function>