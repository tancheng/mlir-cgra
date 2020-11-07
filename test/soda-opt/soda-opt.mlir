// RUN: soda-opt --show-dialects | FileCheck %s
// RUN: soda-opt --h | FileCheck %s -check-prefix=CHECKHELP
//
// CHECK: affine
// CHECK: linalg
// CHECK: llvm
// CHECK: scf
// CHECK: soda
// CHECK: std
// CHECK: vector
// CHECKHELP: soda-test-opt-pipeline