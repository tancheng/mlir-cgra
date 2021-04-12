//===- Passes.h - soda-opt pass entry points --------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This header file defines prototypes that expose pass constructors.
//
//===----------------------------------------------------------------------===//

#ifndef SODA_MISC_PASSES_H
#define SODA_MISC_PASSES_H

#include "mlir/Pass/PassRegistry.h"
#include <memory>

namespace mlir {
class Pass;
} // namespace mlir

namespace mlir {
namespace soda {

//===----------------------------------------------------------------------===//
// Misc
//===----------------------------------------------------------------------===//
std::unique_ptr<mlir::Pass> createTestPrintOpNestingPass();
std::unique_ptr<mlir::Pass> createTestArgumentsToXMLPass();

//===----------------------------------------------------------------------===//
// Optimizations
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Lowerings
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Register passes
//===----------------------------------------------------------------------===//

/// Include the auto-generated definitions for passes
// TODO: only the registration call is necessary. Move pass class decls to
// another file
#define GEN_PASS_CLASSES
#include "soda/Misc/SODAMiscPasses.h.inc"

#define GEN_PASS_REGISTRATION
#include "soda/Misc/SODAMiscPasses.h.inc"

} // namespace soda
} // namespace mlir

#endif // SODA_MISC_PASSES_H
