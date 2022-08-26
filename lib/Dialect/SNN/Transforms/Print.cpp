//===- Print.cpp - Simple print to terminal for `snn` dialect ops ---------===//
//===----------------------------------------------------------------------===//
//
// This file implements a print to terminal for `snn` dialect ops
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Support/LLVM.h"

#include "PassDetail.h"
#include "soda/Dialect/SNN/IR/SNN.h"
#include "soda/Dialect/SNN/Transforms/Passes.h"

using namespace mlir;

namespace {
class SNNPrintPass : public SNNPrintBase<SNNPrintPass> {
  void runOnOperation() override {}
};
} // namespace

std::unique_ptr<OperationPass<ModuleOp>> mlir::snn::createSNNPrintPass() {
  return std::make_unique<SNNPrintPass>();
}
