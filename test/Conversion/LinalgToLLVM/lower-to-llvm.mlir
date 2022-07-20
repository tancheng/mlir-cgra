// RUN: soda-opt %s --soda-opt-pipeline-for-bambu="no-buffer-trick no-scalar-replacement no-alloca-promotion number-of-full-unrolls=0" | FileCheck %s -check-prefix=CHECK-DEFAULT
// RUN: soda-opt %s --soda-opt-pipeline-for-bambu="no-buffer-trick no-scalar-replacement no-alloca-promotion number-of-full-unrolls=0 emit-c-wrappers" | FileCheck %s -check-prefix=CHECK-WRAPPERS
// RUN: soda-opt %s --soda-opt-pipeline-for-bambu="no-buffer-trick no-scalar-replacement no-alloca-promotion number-of-full-unrolls=0 use-bare-ptr-memref-call-conv" | FileCheck %s -check-prefix=CHECK-BARE

func.func @matmul_kernel(%A:memref<4x4xf32>, %B:memref<4x4xf32>, %C : memref<4x4xf32>) {
  linalg.matmul ins(%A, %B : memref<4x4xf32>, memref<4x4xf32>)
                outs(%C : memref<4x4xf32>)
  return

}

// CHECK-DEFAULT:   llvm.func @matmul_kernel(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: i64, %arg3
// CHECK-WRAPPERS:  llvm.func @_mlir_ciface_matmul_kernel(%arg0: !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>>,
// CHECK-BARE:      llvm.func @matmul_kernel(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>) {
