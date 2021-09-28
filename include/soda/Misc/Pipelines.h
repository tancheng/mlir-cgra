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

} // namespace soda
} // namespace mlir

#endif // SODA_MISC_PIPELINES_H
