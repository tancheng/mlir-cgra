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

def SodaKernelOutlining : Pass<"soda-outline-bambu-code", "ModuleOp"> {
  let summary = "Outline soda.launch bodies into bambu kernel functions";
  let constructor = "mlir::soda::createSodaKernelOutliningPass()";
}

def SodaKernelGeneration : Pass<"soda-generate-bambu-accelcode", "ModuleOp"> {
  let summary = "Extract bambu kernels into simple mlir modules";
  let constructor = "mlir::soda::createSodaKernelGenerationPass()";
}

def SodaHostGeneration : Pass<"soda-generate-bambu-hostcode", "ModuleOp"> {
  let summary = "Generate host code to call bambu accelerator api";
  let constructor = "mlir::soda::createSodaHostGenerationPass()";
}

def SodaAsyncRegionPass : FunctionPass<"soda-async-region"> {
  let summary = "Make SODA ops async.";
  let constructor = "mlir::soda::createSodaAsyncRegionPass()";
}

#endif // MLIR_DIALECT_SODA_PASSES
