// RUN: soda-opt --show-dialects | FileCheck %s
//
// CHECK: affine
// CHECK: linalg
// CHECK: llvm
// CHECK: scf
// CHECK: std
// CHECK: vector