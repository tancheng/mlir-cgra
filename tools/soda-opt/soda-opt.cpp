//===- soda-opt.cpp ---------------------------------------------*- C++ -*-===//
//===----------------------------------------------------------------------===//

#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
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

#include "mlir/Dialect/Arithmetic/Transforms/Passes.h"
#include "mlir/Dialect/Func/Transforms/Passes.h"

// Defined in the test directory, no public header.
namespace mlir {
void registerTestLoopPermutationPass();
namespace test {

int registerTestLinalgCodegenStrategy();
} // namespace test
} // namespace mlir

// Register important linalg passes
inline void registerLinalgPassesForSoda() {

  // TODO: MLIR removed the promotion pass. Expose it to the command line.
  // mlir::registerLinalgPromotionPass();
  // Test passes
  // mlir::test::registerTestLinalgCodegenStrategy();

  mlir::registerLinalgPasses();
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
  mlir::bufferization::registerPromoteBuffersToStackPass();

  mlir::registerConvertLinalgToStandardPass();
  // mlir::registerConvertLinalgToLLVMPass(); // This pass maps linalg to blas
  mlir::registerLinalgLowerToAffineLoopsPass();
  mlir::registerConvertFuncToLLVMPass();
  mlir::registerConvertMemRefToLLVMPass();
  mlir::registerSCFToControlFlowPass();
  mlir::registerConvertAffineToStandardPass();
  mlir::registerConvertMathToLLVMPass();
  mlir::registerConvertMathToLibmPass();
  mlir::registerConvertArithmeticToLLVMPass();
  mlir::arith::registerArithmeticExpandOpsPass();
  mlir::memref::registerExpandOpsPass();
  mlir::registerReconcileUnrealizedCastsPass();

  // Add the following to selectively include the necessary dialects. You only
  // need to register dialects that will be *parsed* by the tool, not the one
  // generated
  // clang-format off
  registry.insert<mlir::func::FuncDialect,
                  mlir::memref::MemRefDialect,
                  mlir::LLVM::LLVMDialect,
                  mlir::linalg::LinalgDialect,
                  mlir::math::MathDialect,
                  mlir::scf::SCFDialect,
                  mlir::cf::ControlFlowDialect,
                  mlir::vector::VectorDialect,
                  mlir::arith::ArithmeticDialect,
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
  mlir::soda::registerForwardMemrefAllocPass();
  mlir::soda::registerForwardLinalgFillPass();
  mlir::soda::registerForwardMemrefCopyPass();

  // SODA Passes
  mlir::soda::registerSodaKernelOutliningPass();
  mlir::soda::registerSodaKernelGenerationPass();
  mlir::soda::registerSodaHostGenerationPass();
  mlir::soda::registerSodaAsyncRegionPassPass();

  // Outlining passes
  mlir::soda::registerConvertAllToSODAPass();
  mlir::soda::registerConvertOperationToSODAPass();
  mlir::soda::registerConvertAffineForToSODAPass();
  mlir::soda::registerConvertSCFForToSODAPass();
  mlir::soda::registerConvertLinalgDotToSODAPass();
  mlir::soda::registerConvertLinalgMatmulToSODAPass();
  mlir::soda::registerConvertLinalgConvToSODAPass();
  mlir::soda::registerConvertLinalgGenericToSODAPass();

  // CGRA passes
  mlir::soda::registerConvertPatternToCGRAPass();
  mlir::soda::registerConvertLinalgMatmulToCGRAPass();
  mlir::soda::registerConvertLinalgBatchMatmulToCGRAPass();
  mlir::soda::registerConvertLinalgGenericToCGRAPass();
  mlir::soda::registerConvertLinalgConvToCGRAPass();
  mlir::soda::registerCGRAKernelOutliningPass();
  mlir::soda::registerCGRAKernelGenerationPass();
  mlir::soda::registerCGRAHostGenerationPass();
  mlir::soda::registerLinalgTilingForCGRAPass();

  // Optimization passes
  mlir::soda::registerPassManagerMiscPass();
  mlir::soda::registerSimpleLoweringPass();
  mlir::soda::registerOptimizedForBambuPass();
  mlir::soda::registerOptimizedForVitisHLSPass();

  // Conversion passes

  // ----- SNN -----
  mlir::snn::registerSNNPrintPass();

  return failed(
      mlir::MlirOptMain(argc, argv, "SODA optimizer driver\n", registry));
}
