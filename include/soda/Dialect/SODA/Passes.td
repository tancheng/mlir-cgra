//===-- Passes.td - SODA pass definition file --------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines the SODA Passes
// 
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_SODA_PASSES
#define MLIR_DIALECT_SODA_PASSES

include "mlir/Pass/PassBase.td"

def SodaKernelOutlining : Pass<"soda-kernel-outlining", "ModuleOp"> {
  let summary = "Outline soda.launch bodies to kernel functions";
  let constructor = "mlir::createSodaKernelOutliningPass()";
}

#endif // MLIR_DIALECT_SODA_PASSES
