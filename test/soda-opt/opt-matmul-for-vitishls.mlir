// RUN: soda-opt %s --soda-opt-pipeline-for-vitis-hls=use-bare-ptr-memref-call-conv | FileCheck %s

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
