//===-- Passes.td - Conversion pass definition file --------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef SODA_CONVERSION_PASSES
#define SODA_CONVERSION_PASSES

include "mlir/Pass/PassBase.td"

//===----------------------------------------------------------------------===//
// AffineToSODA
//===----------------------------------------------------------------------===//

def ConvertAffineForToSODA : Pass<"convert-affine-for-to-soda", "func::FuncOp"> {
  let summary = "Convert top-level AffineFor Ops to SODA kernels";
  let constructor = "mlir::createAffineForToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

//===----------------------------------------------------------------------===//
// SCFToSODA
//===----------------------------------------------------------------------===//

def ConvertSCFForToSODA : Pass<"convert-scf-for-to-soda", "func::FuncOp"> {
  let summary = "Convert top-level scf::for Ops to SODA kernels";
  let constructor = "mlir::createSCFForToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

//===----------------------------------------------------------------------===//
// LinalgToSODA
//===----------------------------------------------------------------------===//

def ConvertLinalgDotToSODA : Pass<"convert-linalg-dot-to-soda", "func::FuncOp"> {
  let summary = "Convert top-level linalg::dot Ops to SODA kernels";
  let constructor = "mlir::createLinalgDotToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

def ConvertLinalgMatmulToSODA : Pass<"convert-linalg-matmul-to-soda", "func::FuncOp"> {
  let summary = "Convert top-level linalg::matmul Ops to SODA kernels";
  let constructor = "mlir::createLinalgMatmulToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

def ConvertLinalgConvToSODA : Pass<"convert-linalg-conv-to-soda", "func::FuncOp"> {
  let summary = "Convert top-level linalg::conv Ops to SODA kernels";
  let constructor = "mlir::createLinalgConvToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

def ConvertLinalgGenericToSODA : Pass<"convert-linalg-generic-to-soda", "func::FuncOp"> {
  let summary = "Convert top-level linalg::generic Ops to SODA kernels";
  let constructor = "mlir::createLinalgGenericToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

def ConvertOperationToSODA : Pass<"convert-operation-to-soda", "func::FuncOp"> {
  let summary = "Convert top-level selected operation to SODA kernels";
  let constructor = "mlir::createOperationToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
  let options = [
    Option<"anchorFuncName", "anchor-func", "std::string", /*default=*/"",
      "Which func op is the anchor to latch on.">,
    Option<"anchorOpName", "anchor-op", "std::string", /*default=*/"",
      "Which op within the func is the anchor to latch on.">,
  ];
}

def ConvertAllToSODA : Pass<"convert-all-to-soda", "func::FuncOp"> {
  let summary = "Convert all function contents into a SODA kernel";
  let constructor = "mlir::createAllToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
  let options = [
    Option<"anchorFuncName", "anchor-func", "std::string", /*default=*/"",
      "Which func op is the anchor to latch on.">,
  ];
}

#endif // SODA_CONVERSION_PASSES
