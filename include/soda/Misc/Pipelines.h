//===- Pipelines.h - soda-opt pass pipeline entry points ---------- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef SODA_MISC_PIPELINES_H
#define SODA_MISC_PIPELINES_H

#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "soda/Misc/Passes.h"

// TODO include for soda custom passes
// #include "soda/Misc/Passes.h"

using namespace mlir;

namespace {

struct MyOptions : public PassPipelineOptions<MyOptions> {
  Option<uint64_t> cacheSizeInKiB{
      *this, "cache-size",
      llvm::cl::desc("Set size of cache to tile for in KiB"),
      llvm::cl::init(0)};
};

struct OptForBambuOptions : public PassPipelineOptions<OptForBambuOptions> {
  Option<uint64_t> tileSize{
      *this, "affine-tile-size",
      llvm::cl::desc("Set the unified tiled size, used for all affine.for ops"),
      llvm::cl::init(0)};

  Option<bool> noBufferTrick{
      *this, "no-buffer-trick",
      llvm::cl::desc("Remove the buffer trick optimization"),
      llvm::cl::init(0)};

  // options for the memref.alloc to memref.alloca promotion
  Option<bool> noAllocaPromotion{
      *this, "no-alloca-promotion",
      llvm::cl::desc("Remove alloca promotion optimization"),
      llvm::cl::init(0)};
  Option<unsigned> maxAllocSizeInBytes{
      *this, "max-alloc-size-in-bytes",
      ::llvm::cl::desc("Alloca Promotion - Maximal size in bytes to promote "
                       "allocations to stack. (default 4096)"),
      ::llvm::cl::init(4096)};
  Option<unsigned> bitwidthOfIndexType{
      *this, "bitwidth-of-index-type",
      ::llvm::cl::desc("Alloca Promotion - Bitwidth of the index type. Used "
                       "for size estimation. (default 64)"),
      ::llvm::cl::init(64)};
  Option<unsigned> maxRankOfAllocatedMemRef{
      *this, "max-rank-of-allocated-memref",
      ::llvm::cl::desc("Alloca Promotion - Maximal memref rank to promote "
                       "dynamic buffers. (default 3)"),
      ::llvm::cl::init(3)};

  Option<unsigned> numberOfFullUnrolls{
      *this, "number-of-full-unrolls",
      ::llvm::cl::desc("The number of times to apply "
                       "affine-loop-unrol=unroll-full. (default 3)"),
      ::llvm::cl::init(3)};

  Option<bool> noScalarReplacement{
      *this, "no-scalar-replacement",
      llvm::cl::desc("Remove optimization - scalar replacement of redundant "
                     "affine memory operations."),
      llvm::cl::init(0)};
};
} // end anonymous namespace

namespace mlir {
namespace soda {
void registerPassManagerMiscPass() {
  PassPipelineRegistration<MyOptions> registerOptionsPassPipeline(
      "soda-opt-pipeline",
      "Run the full pass pipeline to optimize previously outlined key "
      "operations",
      [](OpPassManager &pm, const MyOptions &options) {
        pm.addPass(createConvertLinalgToAffineLoopsPass());
        pm.addPass(createConvertLinalgToStandardPass());

        // When given a cache size, tile affine loops
        if (options.cacheSizeInKiB > 0)
          pm.addPass(mlir::createLoopTilingPass(options.cacheSizeInKiB * 1024));

        pm.addPass(createLowerAffinePass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass()); // Only has impact outside linalg ops
        pm.addPass(createLowerToCFGPass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass()); // Only has impact outside linalg ops
        pm.addPass(createMemRefToLLVMPass());
        pm.addPass(createLowerToLLVMPass());
        pm.addPass(createReconcileUnrealizedCastsPass());
      });
}

void registerOptimizedForBambuPass() {
  PassPipelineRegistration<OptForBambuOptions> registerOptionsPassPipeline(
      "soda-opt-pipeline-for-bambu",
      "Run the full pass pipeline to optimize previously outlined key "
      "operations for bambu target",
      [](OpPassManager &pm, const OptForBambuOptions &options) {
        pm.addPass(createConvertLinalgToAffineLoopsPass());
        pm.addPass(createConvertLinalgToStandardPass());

        if (options.tileSize > 0) {
          // -affine-loop-tile="tile-size=2"
          pm.addPass(mlir::soda::createAffineLoopTilingPass(options.tileSize));
        }

        if (!options.noBufferTrick) {
          // -affine-data-copy-generate=
          //   "generate-dma=false fast-mem-space=0"
          // -erase-buffer-deallocation
          pm.addPass(mlir::soda::createAffineDataCopyGenPass(0, 0));
          pm.addPass(mlir::soda::createEraseMemrefDeallocPass());
        }
        pm.addPass(createCSEPass());

        if (!options.noAllocaPromotion) {
          // --promote-buffers-to-stack=
          //   "max-rank-of-allocated-memref=4 max-alloc-size-in-bytes=4096"
          pm.addPass(mlir::createPromoteBuffersToStackPass(
              options.maxAllocSizeInBytes, options.bitwidthOfIndexType,
              options.maxRankOfAllocatedMemRef));
        }

        for (size_t i = 0; i < options.numberOfFullUnrolls; i++) {
          // --affine-loop-unroll="unroll-full"
          pm.addPass(mlir::createLoopUnrollPass(4, false, true, 0));
        }

        if (!options.noScalarReplacement) {
          // --affine-scalrep
          pm.addPass(mlir::createAffineScalarReplacementPass());
          pm.addPass(createCSEPass());
        }

        pm.addPass(createLowerAffinePass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass());
        pm.addPass(createLowerToCFGPass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass());
        pm.addPass(createMemRefToLLVMPass());
        pm.addPass(createLowerToLLVMPass());
        pm.addPass(createReconcileUnrealizedCastsPass());
      });
}

} // namespace soda
} // namespace mlir

#endif // SODA_MISC_PIPELINES_H
