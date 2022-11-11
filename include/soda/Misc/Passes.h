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

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassRegistry.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include <memory>

namespace mlir {
template <typename T>
class OperationPass;
class Pass;
} // namespace mlir

namespace mlir {
class ModuleOp;
namespace memref {
class DeallocOp;
class AllocOp;
class AllocaOp;
class CopyOp;
} // namespace memref
namespace linalg {
class FillOp;
}
namespace scf {
class ForOp;
}
namespace func {
class FuncOp;
}
} // namespace mlir

namespace mlir {
namespace soda {

//===----------------------------------------------------------------------===//
// Misc
//===----------------------------------------------------------------------===//
std::unique_ptr<mlir::Pass> createTestPrintOpNestingPass();
std::unique_ptr<mlir::Pass> createTestArgumentsToXMLPass();

std::unique_ptr<mlir::Pass> createEraseMemrefDeallocPass();
std::unique_ptr<mlir::Pass> createForwardMemrefAllocPass();
std::unique_ptr<mlir::Pass> createForwardLinalgFillPass();
std::unique_ptr<mlir::Pass> createForwardMemrefCopyPass();

std::unique_ptr<OperationPass<func::FuncOp>> createLinalgTilingForCGRAPass();

void populateEraseMemrefDeallocPattern(RewritePatternSet &patterns);

//===----------------------------------------------------------------------===//
// Optimizations
//===----------------------------------------------------------------------===//

/// Performs packing (or explicit copying) of accessed memref regions into
/// buffers in the specified faster memory space through either pointwise copies
/// or DMA operations.
std::unique_ptr<OperationPass<func::FuncOp>> createAffineDataCopyGenPass(
    unsigned slowMemorySpace, unsigned fastMemorySpace,
    unsigned tagMemorySpace = 0, int minDmaTransferSize = 1024,
    uint64_t fastMemCapacityBytes = std::numeric_limits<uint64_t>::max(),
    bool generateDma = false);

/// Expose affine loop tiling creation with explicit tileSize selection
std::unique_ptr<OperationPass<func::FuncOp>>
createAffineLoopTilingPass(unsigned tileSize);

std::unique_ptr<OperationPass<func::FuncOp>>
createAffineLoopPermutationPass(const ArrayRef<unsigned> &permList);

//===----------------------------------------------------------------------===//
// Lowerings
//===----------------------------------------------------------------------===//

// TODO: Move this pass out of the Misc directory into the Conversion directory
/// Perform lowering from std operations to LLVM dialect.
/// Exposing the options of barePtrCallConv or emitCWrappers without the need
/// to know the mlir context during pass (pipeline) creation. MLIR context is
/// obtained at runtime.
///
/// This pass is based on:
///    llvm-project/mlir/lib/Conversion/FuncToLLVM/FuncToLLVM.cpp
std::unique_ptr<OperationPass<ModuleOp>>
createCustomFuncToLLVMPass(bool useBarePtrCallConv);

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
