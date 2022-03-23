//===- Passes.h - Conversion Pass Construction and Registration -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef SODA_CONVERSION_PASSES_H
#define SODA_CONVERSION_PASSES_H

#include "soda/Conversion/KernelsToSODA/AllToSODAPass.h"
#include "soda/Conversion/KernelsToSODA/LinalgToSODAPass.h"
#include "soda/Conversion/KernelsToSODA/OperationToSODAPass.h"
#include "soda/Conversion/KernelsToSODA/SCFToSODAPass.h"

namespace mlir {
namespace soda {

/// Generate the code for registering conversion passes.
#define GEN_PASS_REGISTRATION
#include "soda/Conversion/Passes.h.inc"

} // namespace soda
} // namespace mlir

#endif // SODA_CONVERSION_PASSES_H
