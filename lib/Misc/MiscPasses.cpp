//===- MiscPasses.cpp - Misc Passes ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements a Function level pass performing interprocedural
// propagation of array shapes through function specialization.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Pass/Pass.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Misc/Passes.h"

#include "llvm/IR/IRBuilder.h"

#define DEBUG_TYPE "misc-passes"

using namespace mlir;
using namespace soda;

namespace {

struct TestPrintOpNestingPass
    : public mlir::PassWrapper<TestPrintOpNestingPass, OperationPass<>> {
  // Entry point for the pass.
  void runOnOperation() override {
    Operation *op = getOperation();
    resetIndent();
    printOperation(op);
  }

  void printOperation(Operation *op) {
    // Print the operation itself and some of its properties
    printIndent() << "visiting op: '" << op->getName() << "' with "
                  << op->getNumOperands() << " operands and "
                  << op->getNumResults() << " results\n";
    // Print the operation attributes
    if (!op->getAttrs().empty()) {
      printIndent() << op->getAttrs().size() << " attributes:\n";
      for (NamedAttribute attr : op->getAttrs())
        printIndent() << " - '" << attr.first << "' : '" << attr.second
                      << "'\n";
    }

    // Recurse into each of the regions attached to the operation.
    printIndent() << " " << op->getNumRegions() << " nested regions:\n";
    auto indent = pushIndent();
    for (Region &region : op->getRegions())
      printRegion(region);
  }

  void printRegion(Region &region) {
    // A region does not hold anything by itself other than a list of blocks.
    printIndent() << "Region with " << region.getBlocks().size()
                  << " blocks:\n";
    auto indent = pushIndent();
    for (Block &block : region.getBlocks())
      printBlock(block);
  }

  void printBlock(Block &block) {
    // Print the block intrinsics properties (basically: argument list)
    printIndent()
        << "Block with " << block.getNumArguments() << " arguments, "
        << block.getNumSuccessors()
        << " successors, and "
        // Note, this `.size()` is traversing a linked-list and is O(n).
        << block.getOperations().size() << " operations\n";

    // A block main role is to hold a list of Operations: let's recurse into
    // printing each operation.
    auto indent = pushIndent();
    for (Operation &op : block.getOperations())
      printOperation(&op);
  }

  /// Manages the indentation as we traverse the IR nesting.
  int indent;
  struct IdentRAII {
    int &indent;
    IdentRAII(int &indent) : indent(indent) {}
    ~IdentRAII() { --indent; }
  };
  void resetIndent() { indent = 0; }
  IdentRAII pushIndent() { return IdentRAII(++indent); }

  llvm::raw_ostream &printIndent() {
    for (int i = 0; i < indent; ++i)
      llvm::outs() << "  ";
    return llvm::outs();
  }
};

class TestArgumentsToXMLPass
    : public TestArgumentsToXMLBase<TestArgumentsToXMLPass> {
  // Entry point for the pass.
  void runOnOperation() override {

    getOperation().walk([this](mlir::soda::LaunchFuncOp op) {
      resetIndent();
      generateXMLforLaunchFunc(op);
    });

    // TODO: Handle case for C interface
    // getFunction().walk([this](LLVM::CallOp op) {
    //   if (isCInterfaceVulkanLaunchCallOp(op))
    //     generateXMLforCLaunchFunc(op);
    // });
  }

  // To keep track of what name to use for the XML arguments
  int pointerId = 0;

  // Resets pointer ID
  // Should be called at each new testbench
  void resetPointerId() { pointerId = 0; }
  int incPointerId() { return pointerId++; }

  void generateXMLforLaunchFunc(soda::LaunchFuncOp op) {
    printPreamble();
    {
      auto indent = pushIndent();
      initTestbench();
      {
        auto indent = pushIndent();

        printIndent() << "<!-- Function arguments: -->\n";
        printIndent() << "<!-- ";
        for (auto a : op.getOperandTypes())
          print() << a << " ";
        print() << "-->\n";

        for (auto a : op.getOperandTypes()) {
          // According to the MLIR doc memref argument is converted into a
          // pointer-to-struct argument of type:
          // template <typename Elem, size_t Rank>
          // struct {
          //   Elem *allocated;
          //   Elem *aligned;
          //   int64_t offset;
          //   int64_t sizes[Rank]; // omitted when rank == 0
          //   int64_t strides[Rank]; // omitted when rank == 0
          // };

          // TODO
          // assert(a.hasRank() && "expected only ranked shapes");
          // return MemRefType::get(a.getShape(), a.getElementType());

          // soda.launch_func should not have anything else but memrefs as args
          // if (a.isa<MemRefType, UnrankedMemRefType>()) {
          if (MemRefType mr = a.dyn_cast<MemRefType>()) {
            StringRef v;
            if (mr.getElementType().isa<FloatType>()) {
              v = "1.0";
            } else {
              v = "1";
            }

            // auto shape = a.getShape();
            long numElements = mr.getNumElements();

            // Allocated
            printIndent() << "P" << incPointerId() << "=\"{";
            for (long i = 0; i < numElements - 1; ++i) {
              print() << v << ",";
            }
            print() << v << "}\"\n";

            // Aligned
            printIndent() << "P" << incPointerId() << "=\"{";
            for (long i = 0; i < numElements - 1; ++i) {
              print() << v << ",";
            }
            print() << v << "}\"\n";

            // Offset
            SmallVector<int64_t> strides;
            int64_t offset;
            getStridesAndOffset(mr, strides, offset);
            printIndent() << "P" << incPointerId() << "=\"" << offset << "\" ";

            if (mr.getRank() == 0) {
              print() << "\n";
            } else {
              // Sizes
              for (auto dim : mr.getShape())
                print() << "P" << incPointerId() << "=\"" << dim << "\" ";

              // Strides
              for (auto stride : strides)
                print() << "P" << incPointerId() << "=\"" << stride << "\" ";

              print() << "\n";
            }
          }
        }
      }
      closeTestbench();
    }
    printClosure();
  };

  void printPreamble() {
    printIndent() << "<?xml version=\"1.0\"?>\n"
                  << "<function>\n";
  }

  void initTestbench() {
    printIndent() << "<testbench\n";
    resetPointerId();
  }

  void closeTestbench() { printIndent() << "/>\n"; }

  void printClosure() { printIndent() << "</function>\n"; }

  
  /// Manages the indentation as we traverse the IR nesting.
  int indent;
  struct IndentRAII {
    int &indent;
    IndentRAII(int &indent) : indent(indent) {}
    ~IndentRAII() { --indent; }
  };
  void resetIndent() { indent = 0; }
  IndentRAII pushIndent() { return IndentRAII(++indent); }

  llvm::raw_ostream &printIndent() {
    for (int i = 0; i < indent; ++i)
      llvm::outs() << " ";
    return llvm::outs();
  }

  llvm::raw_ostream &print() { return llvm::outs(); }
};

} // end anonymous namespace

std::unique_ptr<mlir::Pass> mlir::soda::createTestPrintOpNestingPass() {
  return std::make_unique<TestPrintOpNestingPass>();
}

std::unique_ptr<mlir::Pass> mlir::soda::createTestArgumentsToXMLPass() {
  return std::make_unique<TestArgumentsToXMLPass>();
}