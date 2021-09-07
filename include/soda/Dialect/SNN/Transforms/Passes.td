//===-- Passes.td - SNN pass definition file --------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines the SNN Passes
// 
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_SNN_PASSES
#define MLIR_DIALECT_SNN_PASSES

include "mlir/Pass/PassBase.td"

def SNNPrint : Pass<"snn-print-ops", "ModuleOp"> {
  let summary = "Print Ops from the SNN dialect";
  let constructor = "mlir::snn::createSNNPrintPass()";
}

#endif // MLIR_DIALECT_SNN_PASSES
