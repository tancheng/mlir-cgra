// RUN: soda-opt %s --soda-opt-pipeline-for-bambu | FileCheck %s
// RUN: soda-opt %s \
// RUN:    -convert-linalg-to-affine-loops \
// RUN:    -affine-data-copy-generate="generate-dma=false fast-mem-space=0" \
// RUN:    -erase-buffer-deallocation \
// RUN:    --promote-buffers-to-stack="max-rank-of-allocated-memref=4 max-alloc-size-in-bytes=4096" \
// RUN:    -affine-loop-unroll="unroll-full" \
// RUN:    -affine-loop-unroll="unroll-full" \
// RUN:    -affine-loop-unroll="unroll-full" \
// RUN:    -affine-scalrep -cse \
// RUN:    -lower-affine -convert-scf-to-cf -convert-memref-to-llvm \
// RUN:    --convert-math-to-llvm --convert-math-to-libm \
// RUN:    -arith-expand   \
// RUN:    -memref-expand  \
// RUN:    --convert-arith-to-llvm \
// RUN:    -convert-func-to-llvm  \
// RUN:    -reconcile-unrealized-casts | FileCheck %s

func.func @matmul_kernel(%A:memref<4x4xf32>, %B:memref<4x4xf32>, %C : memref<4x4xf32>) {
  linalg.matmul ins(%A, %B : memref<4x4xf32>, memref<4x4xf32>)
                outs(%C : memref<4x4xf32>)
  return

}

// CHECK:         %{{[0-9]*}} = llvm.fmul %{{[0-9]*}}, %{{[0-9]*}}  : f32        
// CHECK-NEXT:    %{{[0-9]*}} = llvm.fadd %{{[0-9]*}}, %{{[0-9]*}}  : f32        
// CHECK-NEXT:    %{{[0-9]*}} = llvm.fmul %{{[0-9]*}}, %{{[0-9]*}}  : f32
// CHECK-NEXT:    %{{[0-9]*}} = llvm.fadd %{{[0-9]*}}, %{{[0-9]*}}  : f32                                            
// CHECK-NEXT:    %{{[0-9]*}} = llvm.fmul %{{[0-9]*}}, %{{[0-9]*}}  : f32                                            
// CHECK-NEXT:    %{{[0-9]*}} = llvm.fadd %{{[0-9]*}}, %{{[0-9]*}}  : f32                                                                       
// CHECK-NEXT:    %{{[0-9]*}} = llvm.fmul %{{[0-9]*}}, %{{[0-9]*}}  : f32                                                                       
// CHECK-NEXT:    %{{[0-9]*}} = llvm.fadd %{{[0-9]*}}, %{{[0-9]*}}  : f32  
