// RUN: soda-opt %s -forward-memref-allocations | FileCheck %s

func.func private @do_something1(memref<4x1xf32>) -> ()
func.func private @do_something2(memref<4x2xf32>) -> ()
func.func private @do_something3(memref<4x3xf32>) -> ()
func.func private @do_something4(memref<4x4xf32>) -> ()

func.func @forward_allocations() {
  %0 = memref.alloc() : memref<4x1xf32>
  call @do_something1(%0) : (memref<4x1xf32>) -> ()

  %1 = memref.alloc() : memref<4x2xf32>
  call @do_something2(%1) : (memref<4x2xf32>) -> ()
  
  %3 = memref.alloca() : memref<4x4xf32>
  call @do_something4(%3) : (memref<4x4xf32>) -> ()

  %2 = memref.alloc() : memref<4x3xf32>
  call @do_something3(%2) : (memref<4x3xf32>) -> ()
  
  
  memref.dealloc %3 : memref<4x4xf32>
  memref.dealloc %2 : memref<4x3xf32>
  memref.dealloc %1 : memref<4x2xf32>
  memref.dealloc %0 : memref<4x1xf32>
  return
}

// CHECK-LABEL: func.func @forward_allocations 
// CHECK-NEXT:  %0 = memref.alloc() : memref<4x1xf32>
// CHECK-NEXT:  %1 = memref.alloc() : memref<4x2xf32>
// CHECK-NEXT:  %2 = memref.alloc() : memref<4x3xf32>
// CHECK-NEXT:  %3 = memref.alloca() : memref<4x4xf32>
// CHECK-NEXT:  call @do_something1(%0) : (memref<4x1xf32>) -> ()
// CHECK-NEXT:  call @do_something2(%1) : (memref<4x2xf32>) -> ()
// CHECK-NEXT:  call @do_something4(%3) : (memref<4x4xf32>) -> ()
// CHECK-NEXT:  call @do_something3(%2) : (memref<4x3xf32>) -> ()
