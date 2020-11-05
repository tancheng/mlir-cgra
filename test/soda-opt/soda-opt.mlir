// RUN: soda-opt --show-dialects | FileCheck %s
// RUN: soda-opt --h | FileCheck %s -check-prefix=CHECKHELP
//
// CHECK: affine
// CHECK: linalg
// CHECK: llvm
// CHECK: scf
// CHECK: std
// CHECK: vector
// CHECK: soda
// CHECKHELP: soda-test-opt-pipeline