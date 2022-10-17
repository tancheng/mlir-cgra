//===- OperationToSODA.cpp - Convert operations matching string to a SODA -===//
//===----------------------------------------------------------------------===//
//
// This implements a straightforward conversion of operation that matches anchor
// string to SODA launch operations.
//
//===----------------------------------------------------------------------===//

#include "soda/Conversion/KernelsToSODA/PatternToCGRA.h"
#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Arithmetic/IR/Arithmetic.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Location.h"

#include <iostream>
#include <list>

#define DEBUG_TYPE "pattern-to-cgra"

using namespace std;
using namespace mlir;

namespace {
// Helper structure that holds common state of the loop to CGRA kernel
// conversion.
struct PatternToCGRAConverter {
  void createLaunch(Operation *op, string patterns);
  string getMatchedPattern(list<string> &arithOptNameList, string patterns);
};

} // namespace

//===----------------------------------------------------------------------===//
// PatternToCGRA
//===----------------------------------------------------------------------===//

string PatternToCGRAConverter::getMatchedPattern(list<string> &arithOptNameList, string patterns) {

  // One pattern (i.e., operation chain) includes multiple ops that are connected
  // by `-` as delimiter.
  string delim = "-";
  string targetOpts;
  for(const auto &s : arithOptNameList) {
    if(!targetOpts.empty())
      targetOpts += delim;
    targetOpts += s;
  }

  // Multiple patterns are separated by `,`.
  string separator = ",";
  auto start = 0;
  auto end = patterns.find(separator);
  while (end != string::npos) {

    if (patterns.substr(start, end - start) == targetOpts) {
      return targetOpts;
    }

    start = end + separator.length();
    end = patterns.find(separator, start);
  }

  if (patterns.substr(start, end) == targetOpts)
    return targetOpts;

  return "";
}

// Add a SODA launch operation around the generic op if the inner ops match
// the pattern.
void PatternToCGRAConverter::createLaunch(Operation *op, string patterns) {

  OpBuilder builder(op);
  auto genericOp = dyn_cast<linalg::GenericOp>(op);

  // Create a launch op and move target op into the region
  Location loc = genericOp->getLoc();
  auto launchOp = builder.create<soda::LaunchOp>(loc);
  builder.setInsertionPointToEnd(&launchOp.body().front());
  builder.create<soda::TerminatorOp>(loc);
  builder.setInsertionPointToStart(&launchOp.body().front());

  Operation* newOp = NULL;

  list<string> arithOptList;
  for (Operation &arithOp : llvm::make_early_inc_range(genericOp.getRegion().front().getOperations())) {
    arithOptList.push_back(string(arithOp.getName().getStringRef()));
  }

  auto matchedPattern = getMatchedPattern(arithOptList, patterns);
  if (matchedPattern != "") {
    auto ctx  = builder.getContext();
    newOp = builder.create<soda::FusionOp>(loc, genericOp->getOperands());
    newOp->setAttr("pattern", StringAttr::get(ctx, matchedPattern));
  }

/*
  for (Operation &arithOp : llvm::make_early_inc_range(genericOp.getRegion().front().getOperations())) {
    if (auto maxOp = dyn_cast<arith::MaxFOp>(&arithOp)) {
      matchTargetArithOp(maxOp, patterns);
      mlir::Value maxInput = maxOp.getOperand(0);
      auto maxInputOp = maxInput.getDefiningOp<arith::MaxFOp>();
      if (maxInputOp) {
        newOp = builder.create<soda::AddMaxOp>(loc, genericOp->getOperands());
      }
    }
  }
*/

  // Clone the op.
  if (newOp == NULL) {
    newOp = Operation::create(
        op->getLoc(), op->getName(), op->getResultTypes(),
        op->getOperands(), op->getAttrDictionary(),
        op->getSuccessors(), op->getRegions());

    builder.insert(newOp);
  }

  // Insert the clone into the soda launch.
  auto results = newOp->getResults();
  op->replaceAllUsesWith(results);
  op->erase();
}

static LogicalResult convertPatternToCGRALaunch(Operation *op, string patterns) {
  PatternToCGRAConverter converter;
  converter.createLaunch(op, patterns);
  return success();
}

LogicalResult mlir::convertPatternToCGRALaunch(Operation *op, string patterns) {
  return ::convertPatternToCGRALaunch(op, patterns);
}
