//===- MiscPasses.cpp - Misc Passes ---------------------------------------===//
//===----------------------------------------------------------------------===//
//
// This file implements a series of misc passes that dont modify the MLIR code.
// These passes include printing operation nesting or generating test vectors
// in XML targeting bambu simulation.
//
// Test vector generation works for algorithms with no dynamic behaviour based
// on the input data. It supports regular memref call convetion and bareptr call
// convention.
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
        printIndent() << " - '" << attr.getName() << "' : '" << attr.getValue()
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
      // Prepare the output streams
      std::string errorMessageT;
      std::string errorMessageI;
      std::string filenameT = op.getKernelName().getValue().str() + "_test.xml";
      std::string filenameI =
          op.getKernelName().getValue().str() + "_interface.xml";
      auto outputT = openOutputFile(filenameT, &errorMessageT);
      auto outputI = openOutputFile(filenameI, &errorMessageI);
      outputStreamT = &outputT->os();
      outputStreamI = &outputI->os();

      if (writeToTerminal) {
        outputStreamT = &llvm::outs();
        outputStreamI = &llvm::outs();
      }

      // Populate the stream with the xml vector
      resetIndent();

      if (usingBarePtr) {
        generateTestXMLforBareLaunchFunc(op);
        generateInterfaceXMLforBareLaunchFunc(op);
      } else {
        generateTestXMLforLaunchFunc(op);
        generateInterfaceXMLforLaunchFunc(op);
      }

      if (!writeToTerminal) {
        outputT->keep();
        outputI->keep();
      }
    });

    // TODO: Handle case for C interface
    // getOperation().walk([this](LLVM::CallOp op) {
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

  void generateTestXMLforLaunchFunc(soda::LaunchFuncOp op) {
    printTestPreamble();
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
            printIndentT() << "P" << incPointerId() << "=\"{";
            for (long i = 0; i < numElements - 1; ++i) {
              printT() << v << ",";
            }
            printT() << v << "}\"\n";

            // Aligned
            printIndentT() << "P" << incPointerId() << "=\"{";
            for (long i = 0; i < numElements - 1; ++i) {
              printT() << v << ",";
            }
            printT() << v << "}\"\n";

            // Offset
            SmallVector<int64_t> strides;
            int64_t offset;
            // TODO(NICO): Must handle aborting testbench gen
            if (failed(getStridesAndOffset(mr, strides, offset))) {
              llvm::outs() << "MemRefType " << mr << " cannot be converted to "
                           << "strided form\n";
              return;
            }
            printIndentT() << "P" << incPointerId() << "=\"" << offset << "\" ";

            if (mr.getRank() == 0) {
              printT() << "\n";
            } else {
              // Sizes
              for (auto dim : mr.getShape())
                printT() << "P" << incPointerId() << "=\"" << dim << "\" ";

              // Strides
              for (auto stride : strides)
                printT() << "P" << incPointerId() << "=\"" << stride << "\" ";

              printT() << "\n";
            }
          }

          if (FloatType value = a.dyn_cast<FloatType>()) {
            StringRef v;
            v = "1.0";
            printIndentT() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }

          if (IntegerType value = a.dyn_cast<IntegerType>()) {
            StringRef v;
            v = "1";
            printIndentT() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }
          
          if (IndexType value = a.dyn_cast<IndexType>()) {
            StringRef v;
            v = "1";
            printIndentT() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }
        }
      }
      closeTestbench();
    }
    printTestClosure();
  };

  void generateInterfaceXMLforLaunchFunc(soda::LaunchFuncOp op) {
    printInterfacePreamble();
    {
      auto indent = pushIndent();
      initInterface();
      printI() << op.getKernelName().getValue().str() << "\">\n";
      {
        auto indent = pushIndent();

        for (auto a : op.getOperandTypes()) {

          long numElements = 0;
          std::string typeString = "int";

          if (MemRefType mr = a.dyn_cast<MemRefType>()) {

            assert(mr.hasRank() && "expected only ranked shapes");
            numElements = mr.getNumElements();

            if (mr.getElementType().isa<FloatType>())
              typeString = "float";
            if (mr.getElementType().isInteger(1))
              typeString = "_Bool";
            if (mr.getElementType().isInteger(8))
              typeString = "unsigned char";
            if (mr.getElementType().isInteger(16))
              typeString = "unsigned short";
            if (mr.getElementType().isInteger(32))
              typeString = "unsigned int";
            if (mr.getElementType().isInteger(64))
              typeString = "unsigned long long";

            // Allocated
            printInterfaceLine(incPointerId(), true, typeString, numElements);

            // Aligned
            printInterfaceLine(incPointerId(), true, typeString, numElements);

            // Offset
            SmallVector<int64_t> strides;
            int64_t offset;
            // TODO(NICO): Must handle aborting testbench gen
            if (failed(getStridesAndOffset(mr, strides, offset))) {
              llvm::outs() << "MemRefType " << mr << " cannot be converted to "
                           << "strided form\n";
              return;
            }
            typeString = "unsigned long long";
            printInterfaceLine(incPointerId(), false, typeString, numElements);

            if (mr.getRank() != 0) {
              // Sizes
              for (size_t i = 0; i < mr.getShape().size(); i++) {
                printInterfaceLine(incPointerId(), false, typeString,
                                   numElements);
              }

              // Strides
              for (size_t i = 0; i < strides.size(); i++) {
                printInterfaceLine(incPointerId(), false, typeString,
                                   numElements);
              }
            }
          } else {
            if (FloatType value = a.dyn_cast<FloatType>())
              typeString = "float";
            if (IntegerType value = a.dyn_cast<IntegerType>()) {
              if (a.isInteger(1))
                typeString = "_Bool";
              if (a.isInteger(8))
                typeString = "unsigned char";
              if (a.isInteger(16))
                typeString = "unsigned short";
              if (a.isInteger(32))
                typeString = "unsigned int";
              if (a.isInteger(64))
                typeString = "unsigned long long";
            }
            if (IndexType value = a.dyn_cast<IndexType>())
              typeString = "unsigned long long";
            printInterfaceLine(incPointerId(), false, typeString, numElements);
          }
        }
      }
      closeInterface();
    }
  };

  void generateTestXMLforBareLaunchFunc(soda::LaunchFuncOp op) {
    printTestPreamble();
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

          // But with `--convert-func-to-llvm=use-bare-ptr-memref-call-conv` we
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
            printIndentT() << "P" << incPointerId() << "=\"{";
            for (long i = 0; i < numElements - 1; ++i) {
              printT() << v << ",";
            }
            printT() << v << "}\"\n";
          }

          if (FloatType value = a.dyn_cast<FloatType>()) {
            StringRef v;
            v = "1.0";
            printIndentT() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }

          if (IntegerType value = a.dyn_cast<IntegerType>()) {
            StringRef v;
            v = "1";
            printIndentT() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }
          
          if (IndexType value = a.dyn_cast<IndexType>()) {
            StringRef v;
            v = "1";
            printIndentT() << "P" << incPointerId() << "=\"" << v << "\"\n";
          }
        }
      }
      closeTestbench();
    }
    printTestClosure();
  };

  void generateInterfaceXMLforBareLaunchFunc(soda::LaunchFuncOp op) {
    printInterfacePreamble();
    {
      auto indent = pushIndent();
      initInterface();
      printI() << op.getKernelName().getValue().str() << "\">\n";
      {
        auto indent = pushIndent();

        for (auto a : op.getOperandTypes()) {

          long numElements = 0;
          std::string typeString = "int";

          if (MemRefType mr = a.dyn_cast<MemRefType>()) {
            assert(mr.hasRank() && "expected only ranked shapes");
            numElements = mr.getNumElements();

            if (mr.getElementType().isa<FloatType>())
              typeString = "float";
            if (mr.getElementType().isInteger(1))
              typeString = "_Bool";
            if (mr.getElementType().isInteger(8))
              typeString = "unsigned char";
            if (mr.getElementType().isInteger(16))
              typeString = "unsigned short";
            if (mr.getElementType().isInteger(32))
              typeString = "unsigned int";
            if (mr.getElementType().isInteger(64))
              typeString = "unsigned long long";

            printInterfaceLine(incPointerId(), true, typeString, numElements);
          } else {
            if (FloatType value = a.dyn_cast<FloatType>())
              typeString = "float";
            if (IntegerType value = a.dyn_cast<IntegerType>()) {
              if (a.isInteger(1))
                typeString = "_Bool";
              if (a.isInteger(8))
                typeString = "unsigned char";
              if (a.isInteger(16))
                typeString = "unsigned short";
              if (a.isInteger(32))
                typeString = "unsigned int";
              if (a.isInteger(64))
                typeString = "unsigned long long";
            }
            if (IndexType value = a.dyn_cast<IndexType>())
              typeString = "unsigned long long";
            printInterfaceLine(incPointerId(), false, typeString, numElements);
          }
        }
      }
      closeInterface();
    }
  };

  void printTestPreamble() {
    printIndentT() << "<?xml version=\"1.0\"?>\n"
                   << "<function>\n";
  }

  void initTestbench() {
    printIndentT() << "<testbench\n";
    resetPointerId();
  }

  void closeTestbench() { printIndentT() << "/>\n"; }

  void printTestClosure() { printIndentT() << "</function>\n"; }

  void printInterfacePreamble() {
    printIndentI() << "<?xml version=\"1.0\"?>\n"
                   << "<module>\n";
  }

  void initInterface() {
    printIndentI() << "<function id=\"";
    resetPointerId();
  }

  void closeInterface() {
    printIndentI() << "</function>\n";
    resetIndent();
    printIndentI() << "</module>\n";
  }

  void printInterfaceLine(int ID, bool isArray, const std::string &typeString,
                          long arraySize) {
    printIndentI() << "<arg id=\"P" << ID << "\" interface_type=\"";
    if (isArray)
      printI() << "array\" ";
    else
      printI() << "default\" ";
    printI() << "interface_typename=\"" << typeString;
    if (isArray)
      printI() << "*";
    printI() << "\" interface_typename_orig=\"" << typeString;
    if (isArray)
      printI() << " (*)\" size=\"" << arraySize;
    printI() << "\" interface_typename_include=\"\"/>\n";
  }

  /// Manages the indentation as we traverse the IR nesting.
  int indent;
  struct IndentRAII {
    int &indent;
    IndentRAII(int &indent) : indent(indent) {}
    ~IndentRAII() { --indent; }
  };
  void resetIndent() { indent = 0; }
  IndentRAII pushIndent() { return IndentRAII(++indent); }

  /// Output streams to the generated XML files or terminal output
  raw_ostream *outputStreamT;
  raw_ostream *outputStreamI;
  raw_ostream &xmlOutT() { return *outputStreamT; }
  raw_ostream &xmlOutI() { return *outputStreamI; }

  llvm::raw_ostream &printIndentT() {
    for (int i = 0; i < indent; ++i)
      xmlOutT() << " ";
    return xmlOutT();
  }

  llvm::raw_ostream &printIndentI() {
    for (int i = 0; i < indent; ++i)
      xmlOutI() << " ";
    return xmlOutI();
  }

  llvm::raw_ostream &printT() { return xmlOutT(); }
  llvm::raw_ostream &printI() { return xmlOutI(); }
};

} // end anonymous namespace

std::unique_ptr<mlir::Pass> mlir::soda::createTestPrintOpNestingPass() {
  return std::make_unique<TestPrintOpNestingPass>();
}

std::unique_ptr<mlir::Pass> mlir::soda::createTestArgumentsToXMLPass() {
  return std::make_unique<TestArgumentsToXMLPass>();
}