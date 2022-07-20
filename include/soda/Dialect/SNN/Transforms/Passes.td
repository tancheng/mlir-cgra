//===-- Passes.td - SNN pass definition file --------------*- tablegen -*-===//
//===----------------------------------------------------------------------===//
//
// Defines the SNN Passes
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_SNN_PASSES
#define MLIR_DIALECT_SNN_PASSES

include "mlir/Pass/PassBase.td"

def SNNPrint : Pass<"snn-print-ops", "ModuleOp"> {
  let summary = "Print Ops from the SNN dialect";
  let constructor = "mlir::snn::createSNNPrintPass()";
  let dependentDialects = [
    "func::FuncDialect"
  ];
}

#endif // MLIR_DIALECT_SNN_PASSES
