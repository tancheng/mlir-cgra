//===- Pipelines.h - soda-opt pass pipeline entry points ---------- C++ -*-===//
//===----------------------------------------------------------------------===//
//
// This file defines optimization pipelines that pre-optimize code for the
// target architectures.
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

struct SimpleOptions : public PassPipelineOptions<SimpleOptions> {
  Option<bool> useBarePtrCallConv{
      *this, "use-bare-ptr-memref-call-conv",
      llvm::cl::desc("Replace FuncOp's MemRef arguments with bare pointers "
                     "to the MemRef element types. Cannot be used with "
                     "-emit-c-wrappers. (default false)"),
      ::llvm::cl::init(false)};

  Option<bool> emitCWrappers{
      *this, "emit-c-wrappers",
      llvm::cl::desc("Emit wrappers for C-compatible pointer-to-struct "
                     "memref descriptors. Cannot be used with "
                     "-use-bare-ptr-memref-call-conv. (default false)"),
      llvm::cl::init(false)};
};

struct MyOptions : public PassPipelineOptions<MyOptions> {
  Option<uint64_t> cacheSizeInKiB{
      *this, "cache-size",
      llvm::cl::desc("Set size of cache to tile for in KiB"),
      llvm::cl::init(0)};

  Option<bool> useBarePtrCallConv{
      *this, "use-bare-ptr-memref-call-conv",
      llvm::cl::desc("Replace FuncOp's MemRef arguments with bare pointers "
                     "to the MemRef element types. Cannot be used with "
                     "-emit-c-wrappers. (default false)"),
      ::llvm::cl::init(false)};

  Option<bool> emitCWrappers{
      *this, "emit-c-wrappers",
      llvm::cl::desc("Emit wrappers for C-compatible pointer-to-struct "
                     "memref descriptors. Cannot be used with "
                     "-use-bare-ptr-memref-call-conv. (default false)"),
      llvm::cl::init(false)};
};

struct OptForBambuOptions : public PassPipelineOptions<OptForBambuOptions> {
  Option<uint64_t> tileSize{
      *this, "affine-tile-size",
      llvm::cl::desc("Set the unified tiled size, used for all affine.for ops. "
                     "(default 0 - don't tile)"),
      llvm::cl::init(0)};

  ListOption<unsigned> permList{
      *this, "permutation-map",
      llvm::cl::desc("Specify the loop permutation. List size must match "
                     "number of affine.for loops."),
      llvm::cl::OneOrMore};

  Option<bool> noBufferTrick{
      *this, "no-buffer-trick",
      llvm::cl::desc("Remove optimization - the buffer trick "),
      llvm::cl::init(0)};

  // options for the memref.alloc to memref.alloca promotion
  Option<bool> noAllocaPromotion{
      *this, "no-alloca-promotion",
      llvm::cl::desc("Remove optimization - alloca promotion"),
      llvm::cl::init(0)};
  Option<unsigned> maxAllocSizeInBytes{
      *this, "max-alloc-size-in-bytes",
      ::llvm::cl::desc("Alloca Promotion - Maximal size in bytes to promote "
                       "allocations to stack. No effect if "
                       "-no-alloca-promotion is used. (default 4096)"),
      ::llvm::cl::init(4096)};
  Option<unsigned> bitwidthOfIndexType{
      *this, "bitwidth-of-index-type",
      ::llvm::cl::desc("Alloca Promotion - Bitwidth of the index type. Used "
                       "for size estimation. No effect if -no-alloca-promotion "
                       "is used. (default 64)"),
      ::llvm::cl::init(64)};
  Option<unsigned> maxRankOfAllocatedMemRef{
      *this, "max-rank-of-allocated-memref",
      ::llvm::cl::desc("Alloca Promotion - Max memref rank to promote "
                       "dynamic buffers. No effect if -no-alloca-promotion is "
                       "used. (default 3)"),
      ::llvm::cl::init(3)};

  Option<unsigned> numberOfFullUnrolls{
      *this, "number-of-full-unrolls",
      ::llvm::cl::desc("The number of times to apply "
                       "affine-loop-unrol=unroll-full. (default 3)"),
      ::llvm::cl::init(3)};

  Option<bool> noScalarReplacement{
      *this, "no-scalar-replacement",
      llvm::cl::desc("Remove optimization - scalar replacement of redundant "
                     "affine memory operations"),
      llvm::cl::init(0)};

  Option<bool> useBarePtrCallConv{
      *this, "use-bare-ptr-memref-call-conv",
      llvm::cl::desc("Replace FuncOp's MemRef arguments with bare pointers "
                     "to the MemRef element types. Cannot be used with "
                     "-emit-c-wrappers. (default false)"),
      ::llvm::cl::init(false)};
  Option<bool> emitCWrappers{
      *this, "emit-c-wrappers",
      llvm::cl::desc("Emit wrappers for C-compatible pointer-to-struct "
                     "memref descriptors. Cannot be used with "
                     "-use-bare-ptr-memref-call-conv. (default false)"),
      llvm::cl::init(false)};
};

struct OptForVitisHLSOptions : public PassPipelineOptions<OptForVitisHLSOptions> {
  Option<uint64_t> tileSize{
      *this, "affine-tile-size",
      llvm::cl::desc("Set the unified tiled size, used for all affine.for ops. "
                     "(default 0 - don't tile)"),
      llvm::cl::init(0)};

  ListOption<unsigned> permList{
      *this, "permutation-map",
      llvm::cl::desc("Specify the loop permutation. List size must match "
                     "number of affine.for loops."),
      llvm::cl::OneOrMore};

  Option<bool> noBufferTrick{
      *this, "no-buffer-trick",
      llvm::cl::desc("Remove optimization - the buffer trick "),
      llvm::cl::init(0)};

  // options for the memref.alloc to memref.alloca promotion
  Option<bool> noAllocaPromotion{
      *this, "no-alloca-promotion",
      llvm::cl::desc("Remove optimization - alloca promotion"),
      llvm::cl::init(0)};
  Option<unsigned> maxAllocSizeInBytes{
      *this, "max-alloc-size-in-bytes",
      ::llvm::cl::desc("Alloca Promotion - Maximal size in bytes to promote "
                       "allocations to stack. No effect if "
                       "-no-alloca-promotion is used. (default 4096)"),
      ::llvm::cl::init(4096)};
  Option<unsigned> bitwidthOfIndexType{
      *this, "bitwidth-of-index-type",
      ::llvm::cl::desc("Alloca Promotion - Bitwidth of the index type. Used "
                       "for size estimation. No effect if -no-alloca-promotion "
                       "is used. (default 64)"),
      ::llvm::cl::init(64)};
  Option<unsigned> maxRankOfAllocatedMemRef{
      *this, "max-rank-of-allocated-memref",
      ::llvm::cl::desc("Alloca Promotion - Max memref rank to promote "
                       "dynamic buffers. No effect if -no-alloca-promotion is "
                       "used. (default 3)"),
      ::llvm::cl::init(3)};

  Option<unsigned> numberOfFullUnrolls{
      *this, "number-of-full-unrolls",
      ::llvm::cl::desc("The number of times to apply "
                       "affine-loop-unrol=unroll-full. (default 3)"),
      ::llvm::cl::init(3)};

  Option<bool> noScalarReplacement{
      *this, "no-scalar-replacement",
      llvm::cl::desc("Remove optimization - scalar replacement of redundant "
                     "affine memory operations"),
      llvm::cl::init(0)};

  Option<bool> useBarePtrCallConv{
      *this, "use-bare-ptr-memref-call-conv",
      llvm::cl::desc("Replace FuncOp's MemRef arguments with bare pointers "
                     "to the MemRef element types. Cannot be used with "
                     "-emit-c-wrappers. (default false)"),
      ::llvm::cl::init(false)};
  Option<bool> emitCWrappers{
      *this, "emit-c-wrappers",
      llvm::cl::desc("Emit wrappers for C-compatible pointer-to-struct "
                     "memref descriptors. Cannot be used with "
                     "-use-bare-ptr-memref-call-conv. (default false)"),
      llvm::cl::init(false)};
};
} // end anonymous namespace

namespace mlir {
namespace soda {
void registerPassManagerMiscPass() {
  PassPipelineRegistration<MyOptions> registerOptionsPassPipeline(
      "soda-opt-pipeline",
      "Run a generic pass pipeline to optimize previously outlined key "
      "operations",
      [](OpPassManager &pm, const MyOptions &options) {
        pm.addPass(createConvertLinalgToAffineLoopsPass());

        // When given a cache size, tile affine loops
        if (options.cacheSizeInKiB > 0)
          pm.addPass(mlir::createLoopTilingPass(options.cacheSizeInKiB * 1024));

        pm.addPass(createLowerAffinePass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass()); // Only has impact outside linalg ops
        pm.addPass(createConvertSCFToCFPass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass()); // Only has impact outside linalg ops
        pm.addPass(createMemRefToLLVMPass());
        pm.addPass(createConvertMathToLLVMPass());
        pm.addPass(createConvertMathToLibmPass());
        pm.addPass(arith::createArithmeticExpandOpsPass());
        pm.addPass(arith::createConvertArithmeticToLLVMPass());
        pm.addPass(memref::createExpandOpsPass());
        if (options.useBarePtrCallConv) {
          pm.addPass(createCustomFuncToLLVMPass(options.useBarePtrCallConv));
        } else {
          if (options.emitCWrappers)
            pm.addPass(LLVM::createRequestCWrappersPass());
          pm.addPass(createConvertFuncToLLVMPass());
        }
        pm.addPass(createReconcileUnrealizedCastsPass());
        pm.addPass(createCanonicalizerPass());
      });
}

void registerSimpleLoweringPass() {
  PassPipelineRegistration<SimpleOptions> registerOptionsPassPipeline(
      "lower-all-to-llvm",
      "Run a pipeline of lowering steps until the llvm dialect without "
      "optimizations",
      [](OpPassManager &pm, const SimpleOptions &options) {
        pm.addPass(createConvertLinalgToAffineLoopsPass());
        pm.addPass(createLowerAffinePass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass()); // Only has impact outside linalg ops
        pm.addPass(createConvertSCFToCFPass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass()); // Only has impact outside linalg ops
        pm.addPass(createConvertMathToLLVMPass());
        pm.addPass(createConvertMathToLibmPass());
        pm.addPass(arith::createArithmeticExpandOpsPass());
        pm.addPass(arith::createConvertArithmeticToLLVMPass());
        pm.addPass(memref::createExpandOpsPass());
        pm.addPass(createMemRefToLLVMPass());
        if (options.useBarePtrCallConv) {
          pm.addPass(createCustomFuncToLLVMPass(options.useBarePtrCallConv));
        } else {
          if (options.emitCWrappers)
            pm.addPass(LLVM::createRequestCWrappersPass());
          pm.addPass(createConvertFuncToLLVMPass());
        }
        pm.addPass(cf::createConvertControlFlowToLLVMPass());
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

        if (options.tileSize > 0) {
          // -affine-loop-tile="tile-size=2"
          pm.addPass(mlir::soda::createAffineLoopTilingPass(options.tileSize));
        }

        if (options.permList.hasValue()) {
          // TODO: Permute list must match number of affine.for loops.
          //       Add logic to break away from these restrictions.
          // --test-loop-permutation=permutation-map=1,2,0
          // --test-loop-permutation=permutation-map=1,2,0,3,4,5 if tiled
          pm.addPass(createAffineLoopPermutationPass(options.permList));
        }

        if (!options.noBufferTrick) {
          // -affine-data-copy-generate="generate-dma=false fast-mem-space=0"
          // -erase-buffer-deallocation
          pm.addPass(mlir::soda::createAffineDataCopyGenPass(0, 0));
          pm.addPass(mlir::soda::createEraseMemrefDeallocPass());
        }
        // pm.addPass(createCSEPass());

        if (!options.noAllocaPromotion) {
          // --promote-buffers-to-stack=
          //   "max-rank-of-allocated-memref=4 max-alloc-size-in-bytes=4096"
          pm.addPass(mlir::bufferization::createPromoteBuffersToStackPass(
              options.maxAllocSizeInBytes, options.maxRankOfAllocatedMemRef));
        }

        for (size_t i = 0; i < options.numberOfFullUnrolls; i++) {
          // --affine-loop-unroll="unroll-full"
          pm.addPass(mlir::createLoopUnrollPass(4, false, true, 0));
        }

        pm.addPass(createCSEPass());

        // TODO simplify affine structures to get rid of affine.apply

        if (!options.noScalarReplacement) {
          // --affine-scalrep
          pm.addPass(mlir::createAffineScalarReplacementPass());
        }

        pm.addPass(createLowerAffinePass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass());
        pm.addPass(createConvertSCFToCFPass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass());
        pm.addPass(createMemRefToLLVMPass());
        pm.addPass(createConvertMathToLLVMPass());
        pm.addPass(createConvertMathToLibmPass());
        pm.addPass(arith::createArithmeticExpandOpsPass());
        pm.addPass(arith::createConvertArithmeticToLLVMPass());
        pm.addPass(memref::createExpandOpsPass());
        if (options.useBarePtrCallConv) {
          pm.addPass(createCustomFuncToLLVMPass(options.useBarePtrCallConv));
        } else {
          if (options.emitCWrappers)
            pm.addPass(LLVM::createRequestCWrappersPass());
          pm.addPass(createConvertFuncToLLVMPass());
        }
        pm.addPass(cf::createConvertControlFlowToLLVMPass());
        pm.addPass(createReconcileUnrealizedCastsPass());
        pm.addPass(createCanonicalizerPass());
      });
}

void registerOptimizedForVitisHLSPass() {
  PassPipelineRegistration<OptForVitisHLSOptions> registerOptionsPassPipeline(
      "soda-opt-pipeline-for-vitis-hls",
      "Run the full pass pipeline to optimize previously outlined key "
      "operations for Vitis HLS target (WIP)",
      [](OpPassManager &pm, const OptForVitisHLSOptions &options) {
        pm.addPass(createConvertLinalgToAffineLoopsPass());

        if (options.tileSize > 0) {
          // -affine-loop-tile="tile-size=2"
          pm.addPass(mlir::soda::createAffineLoopTilingPass(options.tileSize));
        }

        if (options.permList.hasValue()) {
          // TODO: Permute list must match number of affine.for loops.
          //       Add logic to break away from these restrictions.
          // --test-loop-permutation=permutation-map=1,2,0
          // --test-loop-permutation=permutation-map=1,2,0,3,4,5 if tiled
          pm.addPass(createAffineLoopPermutationPass(options.permList));
        }

        if (!options.noBufferTrick) {
          // -affine-data-copy-generate="generate-dma=false fast-mem-space=0"
          // -erase-buffer-deallocation
          pm.addPass(mlir::soda::createAffineDataCopyGenPass(0, 0));
          pm.addPass(mlir::soda::createEraseMemrefDeallocPass());
        }
        // pm.addPass(createCSEPass());

        if (!options.noAllocaPromotion) {
          // --promote-buffers-to-stack=
          //   "max-rank-of-allocated-memref=4 max-alloc-size-in-bytes=4096"
          pm.addPass(mlir::bufferization::createPromoteBuffersToStackPass(
              options.maxAllocSizeInBytes, options.maxRankOfAllocatedMemRef));
        }

        for (size_t i = 0; i < options.numberOfFullUnrolls; i++) {
          // --affine-loop-unroll="unroll-full"
          pm.addPass(mlir::createLoopUnrollPass(4, false, true, 0));
        }

        pm.addPass(createCSEPass());

        // TODO simplify affine structures to get rid of affine.apply

        if (!options.noScalarReplacement) {
          // --affine-scalrep
          pm.addPass(mlir::createAffineScalarReplacementPass());
        }

        pm.addPass(createLowerAffinePass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass());
        pm.addPass(createConvertSCFToCFPass());
        pm.addPass(createCanonicalizerPass());
        pm.addPass(createCSEPass());
        pm.addPass(createMemRefToLLVMPass());
        pm.addPass(createConvertMathToLLVMPass());
        pm.addPass(createConvertMathToLibmPass());
        pm.addPass(arith::createArithmeticExpandOpsPass());
        pm.addPass(arith::createConvertArithmeticToLLVMPass());
        pm.addPass(memref::createExpandOpsPass());
        if (options.useBarePtrCallConv || options.emitCWrappers) {
          pm.addPass(createCustomFuncToLLVMPass(options.useBarePtrCallConv));
        } else {
          pm.addPass(createConvertFuncToLLVMPass());
        }
        pm.addPass(cf::createConvertControlFlowToLLVMPass());
        pm.addPass(createReconcileUnrealizedCastsPass());
      });
}

} // namespace soda
} // namespace mlir

#endif // SODA_MISC_PIPELINES_H
