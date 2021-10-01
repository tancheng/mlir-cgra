//===- soda-opt.cpp ---------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Support/MlirOptMain.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"

#include "soda/Conversion/Passes.h"
#include "soda/Dialect/SNN/IR/SNN.h"
#include "soda/Dialect/SNN/Transforms/Passes.h"
#include "soda/Dialect/SODA/Passes.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Misc/Passes.h"
#include "soda/Misc/Pipelines.h"

// Defined in the test directory, no public header.
namespace mlir {
void registerTestLoopPermutationPass();
namespace test {

int registerTestLinalgCodegenStrategy();
} // namespace test
} // namespace mlir

// Register important linalg passes
inline void registerLinalgPassesForSoda() {

  mlir::registerLinalgPromotionPass();
  // Test passes
  mlir::test::registerTestLinalgCodegenStrategy();
}

// Register important affine passes
inline void registerAffinePassesForSoda() {

  mlir::registerAffineDataCopyGenerationPass();
  mlir::registerAffineLoopInvariantCodeMotionPass();
  mlir::registerAffineLoopTilingPass();
  mlir::registerAffineLoopFusionPass();
  mlir::registerAffineLoopUnrollPass();
  mlir::registerAffineScalarReplacementPass();

  // Test passes
  mlir::registerTestLoopPermutationPass();
}

int main(int argc, char **argv) {
  // mlir::registerAllDialects();
  // mlir::registerAllPasses();
  mlir::DialectRegistry registry;

  //===--------------------------------------------------------------------===//
  // Register mlir dialects and passes
  //===--------------------------------------------------------------------===//

  mlir::registerInlinerPass();
  mlir::registerCanonicalizerPass();
  mlir::registerCSEPass();

  registerLinalgPassesForSoda();
  registerAffinePassesForSoda();
  mlir::registerPromoteBuffersToStackPass();

  mlir::registerConvertLinalgToStandardPass();
  // mlir::registerConvertLinalgToLLVMPass(); // This pass maps linalg to blas
  mlir::registerLinalgLowerToAffineLoopsPass();
  mlir::registerConvertStandardToLLVMPass();
  mlir::registerConvertMemRefToLLVMPass();
  mlir::registerSCFToStandardPass();
  mlir::registerConvertAffineToStandardPass();
  mlir::registerReconcileUnrealizedCastsPass();

  // Add the following to selectively include the necessary dialects. You only
  // need to register dialects that will be *parsed* by the tool, not the one
  // generated
  // clang-format off
  registry.insert<mlir::StandardOpsDialect,
                  mlir::memref::MemRefDialect,
                  mlir::LLVM::LLVMDialect,
                  mlir::linalg::LinalgDialect,
                  mlir::math::MathDialect,
                  mlir::scf::SCFDialect,
                  mlir::vector::VectorDialect,
                  mlir::AffineDialect>();
  // clang-format on
  // mlir::registerAllDialects(registry);

  //===--------------------------------------------------------------------===//
  // Register SODA dialects and passes
  //===--------------------------------------------------------------------===//

  // Dialects
  registry.insert<mlir::soda::SODADialect>();
  registry.insert<mlir::snn::SNNDialect>();

  // ----- SODA -----
  // Misc passes
  mlir::soda::registerTestPrintOpNestingPass();
  mlir::soda::registerTestArgumentsToXMLPass();
  mlir::soda::registerEraseMemrefDeallocPass();

  // SODA Passes
  mlir::soda::registerSodaKernelOutliningPass();
  mlir::soda::registerSodaKernelGenerationPass();
  mlir::soda::registerSodaHostGenerationPass();
  mlir::soda::registerSodaAsyncRegionPassPass();

  // Outlining passes
  mlir::soda::registerConvertAffineForToSODAPass();
  mlir::soda::registerConvertSCFForToSODAPass();
  mlir::soda::registerConvertLinalgDotToSODAPass();
  mlir::soda::registerConvertLinalgMatmulToSODAPass();
  mlir::soda::registerConvertLinalgConvToSODAPass();
  mlir::soda::registerConvertLinalgGenericToSODAPass();

  // Optimization passes
  mlir::soda::registerPassManagerMiscPass();
  mlir::soda::registerOptimizedForBambuPass();

  // Conversion passes

  // ----- SNN -----
  mlir::snn::registerSNNPrintPass();

  return failed(
      mlir::MlirOptMain(argc, argv, "SODA optimizer driver\n", registry));
}
