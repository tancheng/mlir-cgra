// RUN: soda-opt %s --soda-opt-pipeline | FileCheck %s
// RUN: soda-opt %s --soda-opt-pipeline="cache-size=512" | FileCheck %s -check-prefix=CHECKTILE

// Performs AxB accumulating results on C
func.func @matmul_kernel(%A:memref<512x512xf32>, %B:memref<512x512xf32>, %C : memref<512x512xf32>) {
  linalg.matmul ins(%A, %B : memref<512x512xf32>, memref<512x512xf32>)
                outs(%C : memref<512x512xf32>)
  return

}
// Run without tiling is suposed to only have 3 inner loops
// CHECK: llvm.icmp
// CHECK: llvm.icmp
// CHECK: llvm.icmp
// CHECK-NOT: llvm.icmp

// Run with tiling is suposed to have more than 3 inner loops
// CHECKTILE: llvm.icmp
// CHECKTILE: llvm.icmp
// CHECKTILE: llvm.icmp
// CHECKTILE: llvm.icmp
// CHECKTILE: llvm.icmp
// CHECKTILE: llvm.icmp