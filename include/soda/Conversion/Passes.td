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

def ConvertAffineForToSODA : FunctionPass<"convert-affine-for-to-soda"> {
  let summary = "Convert top-level AffineFor Ops to SODA kernels";
  let constructor = "mlir::createAffineForToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

//===----------------------------------------------------------------------===//
// SCFToSODA
//===----------------------------------------------------------------------===//

def ConvertSCFForToSODA : FunctionPass<"convert-scf-for-to-soda"> {
  let summary = "Convert top-level scf::for Ops to SODA kernels";
  let constructor = "mlir::createSCFForToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

//===----------------------------------------------------------------------===//
// LinalgToSODA
//===----------------------------------------------------------------------===//

def ConvertLinalgMatmulToSODA : FunctionPass<"convert-linalg-matmul-to-soda"> {
  let summary = "Convert top-level linalg::matmul Ops to SODA kernels";
  let constructor = "mlir::createLinalgMatmulToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

def ConvertLinalgConvToSODA : FunctionPass<"convert-linalg-conv-to-soda"> {
  let summary = "Convert top-level linalg::conv Ops to SODA kernels";
  let constructor = "mlir::createLinalgConvToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

def ConvertLinalgGenericToSODA : FunctionPass<"convert-linalg-generic-to-soda"> {
  let summary = "Convert top-level linalg::generic Ops to SODA kernels";
  let constructor = "mlir::createLinalgGenericToSODAPass()";
  let dependentDialects = ["soda::SODADialect"];
}

#endif // SODA_CONVERSION_PASSES
