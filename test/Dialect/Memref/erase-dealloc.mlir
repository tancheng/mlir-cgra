// RUN: soda-opt %s -erase-buffer-deallocation | FileCheck %s

func.func private @do_something(memref<4x4xf32>) -> ()

func.func @erase_dealloc() {
  %0 = memref.alloc() : memref<4x4xf32>
  %1 = memref.alloc() : memref<4x4xf32>
  %2 = memref.alloc() : memref<4x4xf32>
  
  call @do_something (%0) : (memref<4x4xf32>) -> ()
  call @do_something (%1) : (memref<4x4xf32>) -> ()
  call @do_something (%2) : (memref<4x4xf32>) -> ()
  
  memref.dealloc %2 : memref<4x4xf32>
  memref.dealloc %1 : memref<4x4xf32>
  memref.dealloc %0 : memref<4x4xf32>
  return
}

// CHECK-NOT: memref.dealloc
