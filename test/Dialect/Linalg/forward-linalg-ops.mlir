// RUN: soda-opt %s -forward-linalg-fill | FileCheck %s --check-prefix=FFILL
// RUN: soda-opt %s -forward-memref-allocations -forward-linalg-fill | FileCheck %s --check-prefix=F_A_F
// RUN: soda-opt %s -forward-memref-allocations -forward-linalg-fill -forward-memref-copy -forward-memref-allocations | FileCheck %s --check-prefix=F_A_F_C_A

func.func private @do_something1(memref<4x1xf32>) -> ()
func.func private @do_something2(memref<4x2xf32>) -> ()
func.func private @do_something3(memref<4x3xf32>) -> ()
func.func private @do_something4(memref<4x4xf32>) -> ()

func.func @forward_allocations() {
  %0 = memref.alloc() : memref<4x1xf32>
  call @do_something1(%0) : (memref<4x1xf32>) -> ()
  %1 = memref.alloc() : memref<4x2xf32>
  call @do_something2(%1) : (memref<4x2xf32>) -> ()
  %2 = memref.alloca() : memref<4x4xf32>
  call @do_something4(%2) : (memref<4x4xf32>) -> ()
  %3 = memref.alloc() : memref<4x3xf32>
  call @do_something3(%3) : (memref<4x3xf32>) -> ()
  %4 = memref.alloc() : memref<1x7x7x32xf32>
  %5 = memref.alloc() : memref<1x7x7x32xf32>
  %cst = arith.constant 1.000000e+00 : f32
  linalg.fill ins(%cst : f32) outs(%4: memref<1x7x7x32xf32> )
  memref.copy %4, %5  : memref<1x7x7x32xf32> to  memref<1x7x7x32xf32> 
  return
}

// FFILL-LABEL: func.func @forward_allocations 
// FFILL-NEXT:  %0 = memref.alloc() : memref<4x1xf32>
// FFILL-NEXT:  %cst = arith.constant 1.000000e+00 : f32
// FFILL-NEXT:  call @do_something1(%0) : (memref<4x1xf32>) -> ()
// FFILL-NEXT:  %1 = memref.alloc() : memref<4x2xf32>
// FFILL-NEXT:  call @do_something2(%1) : (memref<4x2xf32>) -> ()
// FFILL-NEXT:  %2 = memref.alloca() : memref<4x4xf32>
// FFILL-NEXT:  call @do_something4(%2) : (memref<4x4xf32>) -> ()
// FFILL-NEXT:  %3 = memref.alloc() : memref<4x3xf32>
// FFILL-NEXT:  call @do_something3(%3) : (memref<4x3xf32>) -> ()
// FFILL-NEXT:  %4 = memref.alloc() : memref<1x7x7x32xf32>
// FFILL-NEXT:  linalg.fill ins(%cst : f32) outs(%4 : memref<1x7x7x32xf32>) 
// FFILL-NEXT:  %5 = memref.alloc() : memref<1x7x7x32xf32>
// FFILL-NEXT:  memref.copy %4, %5  : memref<1x7x7x32xf32> to memref<1x7x7x32xf32> 


// F_A_F-LABEL: func.func @forward_allocations 
// F_A_F-NEXT:  %0 = memref.alloc() : memref<4x1xf32>
// F_A_F-NEXT:  %cst = arith.constant 1.000000e+00 : f32
// F_A_F-NEXT:  %1 = memref.alloc() : memref<4x2xf32>
// F_A_F-NEXT:  %2 = memref.alloc() : memref<4x3xf32>
// F_A_F-NEXT:  %3 = memref.alloc() : memref<1x7x7x32xf32>
// F_A_F-NEXT:  linalg.fill ins(%cst : f32) outs(%3 : memref<1x7x7x32xf32>) 
// F_A_F-NEXT:  %4 = memref.alloc() : memref<1x7x7x32xf32>
// F_A_F-NEXT:  %5 = memref.alloca() : memref<4x4xf32>
// F_A_F-NEXT:  call @do_something1(%0) : (memref<4x1xf32>) -> ()
// F_A_F-NEXT:  call @do_something2(%1) : (memref<4x2xf32>) -> ()
// F_A_F-NEXT:  call @do_something4(%5) : (memref<4x4xf32>) -> ()
// F_A_F-NEXT:  call @do_something3(%2) : (memref<4x3xf32>) -> ()
// F_A_F-NEXT:  memref.copy %3, %4  : memref<1x7x7x32xf32> to memref<1x7x7x32xf32> 

// F_A_F_C_A-LABEL: func.func @forward_allocations 
// F_A_F_C_A-NEXT:    %0 = memref.alloc() : memref<4x1xf32>
// F_A_F_C_A-NEXT:    %1 = memref.alloc() : memref<4x2xf32>
// F_A_F_C_A-NEXT:    %2 = memref.alloc() : memref<4x3xf32>
// F_A_F_C_A-NEXT:    %3 = memref.alloc() : memref<1x7x7x32xf32>
// F_A_F_C_A-NEXT:    %4 = memref.alloc() : memref<1x7x7x32xf32>
// F_A_F_C_A-NEXT:    %5 = memref.alloca() : memref<4x4xf32>
// F_A_F_C_A-NEXT:    %cst = arith.constant 1.000000e+00 : f32
// F_A_F_C_A-NEXT:    linalg.fill ins(%cst : f32) outs(%3 : memref<1x7x7x32xf32>) 
// F_A_F_C_A-NEXT:    memref.copy %3, %4  : memref<1x7x7x32xf32> to memref<1x7x7x32xf32> 
// F_A_F_C_A-NEXT:    call @do_something1(%0) : (memref<4x1xf32>) -> ()
// F_A_F_C_A-NEXT:    call @do_something2(%1) : (memref<4x2xf32>) -> ()
// F_A_F_C_A-NEXT:    call @do_something4(%5) : (memref<4x4xf32>) -> ()
// CHECK-NEXT:    call @do_something3(%2) : (memref<4x3xf32>) -> ()