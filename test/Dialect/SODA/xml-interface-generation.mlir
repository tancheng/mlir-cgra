// RUN: soda-opt -allow-unregistered-dialect --soda-extract-arguments-to-xml %s
// RUN:   FileCheck %s -input-file=driver_kernel_interface.xml --check-prefixes=CHECK_FILE
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
// CHECK_FILE: <module>
// CHECK_FILE:  <function id="driver_kernel">
// CHECK_FILE:   <arg id="P0" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="28" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P1" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="28" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P2" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P3" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P4" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P5" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P6" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P7" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="21" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P8" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="21" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P9" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P10" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P11" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P12" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P13" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P14" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="12" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P15" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="12" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P16" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P17" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P18" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P19" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:   <arg id="P20" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_FILE:  </function>
// CHECK_FILE: </module>

// CHECK_TERMINAL: <?xml version="1.0"?>
// CHECK_TERMINAL: <module>
// CHECK_TERMINAL:  <function id="driver_kernel">
// CHECK_TERMINAL:   <arg id="P0" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="28" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P1" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="28" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P2" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P3" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P4" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P5" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P6" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P7" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="21" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P8" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="21" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P9" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P10" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P11" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P12" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P13" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P14" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="12" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P15" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="12" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P16" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P17" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P18" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P19" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:   <arg id="P20" interface_type="default" interface_typename="unsigned long long" interface_typename_orig="unsigned long long" interface_typename_include=""/>
// CHECK_TERMINAL:  </function>
// CHECK_TERMINAL: </module>

// CHECK_BARE: <?xml version="1.0"?>
// CHECK_BARE: <module>
// CHECK_BARE:  <function id="driver_kernel">
// CHECK_BARE:   <arg id="P0" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="28" interface_typename_include=""/>
// CHECK_BARE:   <arg id="P1" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="21" interface_typename_include=""/>
// CHECK_BARE:   <arg id="P2" interface_type="array" interface_typename="float*" interface_typename_orig="float (*)" size="12" interface_typename_include=""/>
// CHECK_BARE:  </function>
// CHECK_BARE: </module>