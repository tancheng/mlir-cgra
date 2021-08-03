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

#include "mlir/Support/FileUtilities.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"

#define DEBUG_TYPE "misc-passes"

using namespace mlir;
using namespace soda;

namespace {

class TestPrintOpNestingPass
    : public mlir::soda::TestPrintOpNestingBase<TestPrintOpNestingPass> {
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
    : public mlir::soda::TestArgumentsToXMLBase<TestArgumentsToXMLPass> {

  void runOnOperation() override {

    getOperation().walk([this](mlir::soda::LaunchFuncOp op) {
      // Prepare the output stream
      std::string errorMessage;
      std::string filename = op.getKernelName().str() + "_test.xml";
      auto output = openOutputFile(filename, &errorMessage);
      outputStream = &output->os();

      if (writeToTerminal) {
        outputStream = &llvm::outs();
      }

      // Populate the stream with the xml vector
      resetIndent();

      if (usingBarePtr)
        generateXMLforBareLaunchFunc(op);
      else
        generateXMLforLaunchFunc(op);

      if (!writeToTerminal) {
        output->keep();
      }
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

        // XML comment
        // printIndent() << "<!-- Function arguments: -->\n";
        // printIndent() << "<!-- ";
        // for (auto a : op.getOperandTypes())
        //   print() << a << " ";
        // print() << "-->\n";

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
          // soda.launch_func should not have anything else but memrefs as args
          // if (a.isa<MemRefType, UnrankedMemRefType>()) {
          if (MemRefType mr = a.dyn_cast<MemRefType>()) {

            assert(mr.hasRank() && "expected only ranked shapes");

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
            // TODO(NICO): Must handle aborting testbench gen
            if (failed(getStridesAndOffset(mr, strides, offset))) {
              llvm::outs() << "MemRefType " << mr << " cannot be converted to "
                           << "strided form\n";
              return;
            }
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

          if (FloatType value = a.dyn_cast<FloatType>()) {
            StringRef v;
            v = "1.0";
            printIndent() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }

          if (IntegerType value = a.dyn_cast<IntegerType>()) {
            StringRef v;
            v = "1";
            printIndent() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }
        }
      }
      closeTestbench();
    }
    printClosure();
  };

  void generateXMLforBareLaunchFunc(soda::LaunchFuncOp op) {
    printPreamble();
    {
      auto indent = pushIndent();
      initTestbench();
      {
        auto indent = pushIndent();

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

          // But with `--convert-std-to-llvm=use-bare-ptr-memref-call-conv` we
          // only have one pointer per memref, thus we only use need the number
          // of elements to generate the array and we can ignore the other
          // members

          if (MemRefType mr = a.dyn_cast<MemRefType>()) {

            assert(mr.hasRank() && "expected only ranked shapes");

            StringRef v;
            if (mr.getElementType().isa<FloatType>()) {
              v = "1.0";
            } else {
              v = "1";
            }

            long numElements = mr.getNumElements();

            // Allocated bare pointers
            printIndent() << "P" << incPointerId() << "=\"{";
            for (long i = 0; i < numElements - 1; ++i) {
              print() << v << ",";
            }
            print() << v << "}\"\n";
          }

          if (FloatType value = a.dyn_cast<FloatType>()) {
            StringRef v;
            v = "1.0";
            printIndent() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }

          if (IntegerType value = a.dyn_cast<IntegerType>()) {
            StringRef v;
            v = "1";
            printIndent() << "P" << incPointerId() << "=\"" << v << "\"\n";
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

  /// Output stream to the generated XML file or terminal output
  raw_ostream *outputStream;
  raw_ostream &xmlOut() { return *outputStream; }

  llvm::raw_ostream &printIndent() {
    for (int i = 0; i < indent; ++i)
      xmlOut() << " ";
    return xmlOut();
  }

  llvm::raw_ostream &print() { return xmlOut(); }
};

} // end anonymous namespace

std::unique_ptr<mlir::Pass> mlir::soda::createTestPrintOpNestingPass() {
  return std::make_unique<TestPrintOpNestingPass>();
}

std::unique_ptr<mlir::Pass> mlir::soda::createTestArgumentsToXMLPass() {
  return std::make_unique<TestArgumentsToXMLPass>();
}