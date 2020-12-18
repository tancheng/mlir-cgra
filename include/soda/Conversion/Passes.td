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

// TODO


#endif // SODA_CONVERSION_PASSES
