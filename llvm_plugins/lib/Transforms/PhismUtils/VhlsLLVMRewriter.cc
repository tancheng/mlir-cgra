//===- VhlsLLVMRewriter.cc --------------------------------------*- C++ -*-===//
//
// This file implements a pass that transforms LLVM-IR for Vitis HLS input.
//
//===----------------------------------------------------------------------===//

#include "Utils.h"

#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include <queue>
#include <regex>
#include <string>

using namespace llvm;
using namespace phism::llvm;

#define DEBUG_TYPE "vhls_llvm"

/// Rename the name of basic blocks, function arguments, and values defined
/// by instructions with string prefixes.
static void
renameBasicBlocksAndValues(Module &M,
                           llvm::ArrayRef<llvm::StringRef> ParamNames) {
  // Rename BB and I
  size_t BBCnt = 0, ValCnt = 1, ArgCnt = 0;
  for (Function &F : M) {
    // Rename arguments
    if (F.getName() == getXlnTop()) {
      LLVM_DEBUG(dbgs() << "F:\n");
      LLVM_DEBUG(F.dump());

      for (size_t i = 0; i < ParamNames.size(); i++) {
        LLVM_DEBUG(dbgs() << "Setting #" << i << " to " << ParamNames[i]
                          << '\n');
        F.getArg(i)->setName(ParamNames[i]);
      }
      for (size_t i = ParamNames.size(); i < F.arg_size(); i++)
        F.getArg(i)->setName("arg_" + Twine(ArgCnt++));
    } else {
      for (Argument &arg : F.args()) {
        arg.setName("arg_" + Twine(ArgCnt++));
      }
    }

    for (BasicBlock &BB : F) {
      // Rename basic blocks
      BB.setName("bb_" + Twine(BBCnt++));

      for (Instruction &I : BB) {
        // Rename variables
        Value *V = &I;
        if (V && !V->getType()->isVoidTy())
          V->setName("val_" + Twine(ValCnt++));
      }
    }
  }
}

namespace {

struct RenameBasicBlocksAndValues : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  RenameBasicBlocksAndValues() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    llvm::SmallVector<llvm::StringRef, 4> ParamNames;
    std::string names = getXlnNames();
    llvm::SplitString(names, ParamNames, ",");

    LLVM_DEBUG(dbgs() << "Input xlnnames: " << names << '\n');
    LLVM_DEBUG(dbgs() << "Parsed name list:\n");
    LLVM_DEBUG(interleaveComma(ParamNames, dbgs()));

    renameBasicBlocksAndValues(M, ParamNames);
    return false;
  }
};

} // namespace

static void annotateXilinxAttributes(Module &M) {
  assert(!getXlnTop().empty() &&
         "-xlntop should be specified to annotate properties.");

  Function *F = M.getFunction(getXlnTop());
  assert(F != nullptr && "Top function should be found.");

  // Top function annotation.
  F->addFnAttr("fpga.top.func", getXlnTop());
}

namespace {

struct AnnotateXilinxAttributes : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  AnnotateXilinxAttributes() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    annotateXilinxAttributes(M);
    return false;
  }
};

} // namespace

namespace {

struct StripInvalidAttributes : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  StripInvalidAttributes() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    // Here is the list of all supported attributes. Note that not all the
    // differences are covered.
    // https://github.com/llvm/llvm-project/blob/release%2F3.9.x/llvm/include/llvm/IR/Attributes.td
    for (auto &F : M) {
      F.removeFnAttr(Attribute::AttrKind::NoFree);
      F.removeFnAttr(Attribute::AttrKind::NoSync);
      F.removeFnAttr(Attribute::AttrKind::Speculatable);
      F.removeFnAttr(Attribute::AttrKind::WillReturn);
    }

    return false;
  }
};

} // namespace

/// Rewrite fneg to fsub, e.g., %1 = fneg double %0 will be rewritten to
/// %1 = fsub double -0.000000e+00, %0
static Instruction *rewriteFNegToFSub(Instruction &I) {
  assert(I.getOpcode() == Instruction::FNeg && "OpCode should be FNeg.");

  Value *Operand = I.getOperand(0);
  Type *OperandTy = Operand->getType();
  assert(OperandTy->isFloatingPointTy() &&
         "The operand to fneg should be floating point.");

  // NOTE: The zero created here is negative.
  Value *NegZero = ConstantFP::get(
      I.getContext(),
      APFloat::getZero(OperandTy->getFltSemantics(), /*Negative=*/true));

  std::string NIName = I.getName().str() + ".sub";
  Instruction *NI = BinaryOperator::Create(Instruction::BinaryOps::FSub,
                                           NegZero, Operand, "", &I);
  I.replaceAllUsesWith(NI);

  return NI;
}

namespace {

/// Rewrite some math instructions to work together with Vitis.
struct XilinxRewriteMathInstPass : public ModulePass {
  static char ID;
  XilinxRewriteMathInstPass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    SmallVector<Instruction *, 4> ToErase;

    for (auto &F : M)
      for (auto &BB : F)
        for (auto &I : BB) {
          if (isa<UnaryInstruction>(I) && I.getOpcode() == Instruction::FNeg) {
            rewriteFNegToFSub(I);
            ToErase.push_back(&I);
          }
        }

    for (Instruction *I : ToErase) {
      assert(I->use_empty() && "Inst to be erased should have empty use.");
      I->eraseFromParent();
    }

    return false;
  }
};

} // namespace

/// getTripCountTemporary - Return an integer indicating the number of times the
/// loop will be executed. This function assumes the affine loop always have a
/// following pattern in its header (start from 0 && step is 1 && condition is
/// < or <=):
/// 17:                                               ; preds = %20, %2
/// %18 = phi i64 [ %49, %20 ], [ 0, %2 ]
/// %19 = icmp slt i64 %18, 8
/// br i1 %19, label %20, label %50
static int getTripCountTemporary(Loop *loop) {
  auto header = loop->getHeader();
  auto condition = dyn_cast<BranchInst>(header->getTerminator());
  assert(
      condition && condition->isConditional() &&
      "Cannot find the loop exit - please check if the loop is canonicalized");

  PHINode *indvar = dyn_cast<PHINode>(header->begin());
  assert(indvar && "Cannot find the loop indvar - please check if the loop is "
                   "canonicalized");
  auto icmp = dyn_cast<ICmpInst>(condition->getCondition());
  assert(icmp && "Cannot find the exit loop condition - expected to be icmp");
  assert(icmp->getOperand(0) == indvar && "Cannot find the exit loop condition "
                                          "- expected to have the loop indvar "
                                          "as operand 0");
  // Disable unroll if the loop is not canonicalized
  if ((icmp->getPredicate() != ICmpInst::ICMP_SLE &&
       icmp->getPredicate() != ICmpInst::ICMP_SLT))
    return -2;

  if (auto const1 = dyn_cast<ConstantInt>(icmp->getOperand(1)))
    return const1->getValue().getSExtValue() +
           (icmp->getPredicate() == ICmpInst::ICMP_SLE);

  return -1;
}

static void unrollLoop(Loop *loop, int alreadyUnrolled, int maxUnrolled,
                       int parentLoopTripCount,
                       int currentVariableBoundedDepth) {
  // Check loop trip count. Return if the factor is not greater than 1.
  if (maxUnrolled / alreadyUnrolled <= 1)
    return;
  int tripCount = getTripCountTemporary(loop);
  bool isVariableLoopBound = (tripCount == -1);
  bool skipToNextLevel = (tripCount == -2);
  if (!skipToNextLevel) {
    LLVM_DEBUG(if (isVariableLoopBound) {
      assert(parentLoopTripCount > 0);
      dbgs()
          << "Found a variable loop bound. Assume it has the same trip count "
             "as its parent loop:\n"
          << *(loop->getHeader()) << "\n";
    });
    tripCount = isVariableLoopBound ? parentLoopTripCount : tripCount;
    currentVariableBoundedDepth += isVariableLoopBound;
    bool isFullyUnroll = (tripCount <= maxUnrolled / alreadyUnrolled);
    tripCount = isFullyUnroll ? tripCount : maxUnrolled / alreadyUnrolled;
    if (tripCount == 1)
      return;

    SmallVector<Metadata *, 4> Args;

    // Reserve operand 0 for loop id self reference.
    LLVMContext &Context = loop->getHeader()->getContext();
    auto TempNode = MDNode::getTemporary(Context, None);
    Args.push_back(TempNode.get());

    // Keep the original loop metadata
    if (auto id = loop->getLoopID())
      for (unsigned int i = 1; i < id->getNumOperands(); i++)
        Args.push_back(id->getOperand(i));

    // Loop unroll
    if (isFullyUnroll) {
      Metadata *nameVals[] = {MDString::get(Context, "llvm.loop.unroll.full")};
      Args.push_back(MDNode::get(Context, nameVals));
    } else {
      Metadata *nameVals[] = {MDString::get(Context, "llvm.loop.unroll.count"),
                              ConstantAsMetadata::get(ConstantInt::get(
                                  IntegerType::get(Context, 32), tripCount))};
      Args.push_back(MDNode::get(Context, nameVals));
    }

    // Set the first operand to itself.
    MDNode *LoopID = MDNode::get(Context, Args);
    LoopID->replaceOperandWith(0, LoopID);
    loop->setLoopID(LoopID);
  } else
    tripCount = 1;
  if (!loop->isInnermost() &&
      currentVariableBoundedDepth < getXlnLoopUnrollMaxDepth())
    for (auto &subloop : loop->getSubLoops())
      unrollLoop(subloop, alreadyUnrolled * tripCount, maxUnrolled, tripCount,
                 currentVariableBoundedDepth);
}

namespace {

/// Unroll all the loops in a specified function for Xilinx Vitis.
struct XilinxUnrollPass : public ModulePass {
  static char ID;
  XilinxUnrollPass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    assert((!getXlnTop().empty() || getXlnHasNonAffine()) &&
           "Top function name should be set.");

    for (auto &F : M)
      if ((!getXlnHasNonAffine() && F.getName() == getXlnTop()) ||
          (getXlnHasNonAffine() &&
           F.getName().find("__f") != std::string::npos &&
           F.getName().find("__PE") == std::string::npos)) {
        auto DT = llvm::DominatorTree(F);
        LoopInfo LI(DT);
        if (!LI.empty()) {
          for (auto &loop : LI) {
            unrollLoop(loop, 1, getXlnLoopUnrollMaxCount(), -1, 0);
          }
        }
      }

    return false;
  }
};

} // namespace

/// Return a set of <dimension, size> as the dimension information for the
/// current array type.
static SmallVector<std::pair<unsigned, unsigned>>
getArrayDimensionInfo(ArrayType *arrayTy) {
  SmallVector<std::pair<unsigned, unsigned>> dims;
  unsigned d = 0;
  do {
    dims.push_back(
        std::pair<unsigned, unsigned>(d + 1, arrayTy->getNumElements()));
    arrayTy = dyn_cast<ArrayType>(arrayTy->getElementType());
    ++d;
  } while (arrayTy);

  return dims;
}

namespace {

/// Partition arrays in the top-level function arguments for Xilinx Vitis.
/// This pass partitions the array in first half dimensions completely to
/// parallelise the transformed arrays from Polymer. For instance, an array of
/// size 2x3x32x32 will be partitioned into 6 blocks of size 32x32
struct XilinxArrayPartitionPass : public ModulePass {
  static char ID;
  XilinxArrayPartitionPass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    if (!getXlnArrayPartitionEnabled())
      return true;

    // Declare array partition APIs in Vitis HLS LLVM frontend
    auto mod = &M;
    auto voidTy = Type::getVoidTy(mod->getContext());
    mod->getOrInsertFunction("llvm.sideeffect",
                             FunctionType::get(voidTy, {}, false));
    auto arrayPartitionFunc = mod->getFunction("llvm.sideeffect");
    arrayPartitionFunc->addFnAttr(llvm::Attribute::InaccessibleMemOnly);
    arrayPartitionFunc->addFnAttr(llvm::Attribute::NoUnwind);

    for (auto &F : M)
      if (F.getName() == getXlnTop()) {
        auto &BB = F.getEntryBlock();
        IRBuilder<> builder(&BB, BB.begin());
        for (unsigned i = 0; i < F.arg_size(); i++) {
          auto arg = F.getArg(i);
          if (arg->getType()->isPointerTy() &&
              arg->getType()->getPointerElementType()->isArrayTy()) {
            auto arrayTy =
                dyn_cast<ArrayType>(arg->getType()->getPointerElementType());
            auto partitions = getArrayDimensionInfo(arrayTy);
            if (partitions.size() == 1)
              continue;
            if (getXlnArrayPartitionFlattened())
              partitions.pop_back_n(partitions.size() - 1);
            else
              partitions.pop_back_n(partitions.size() / 2);
            for (auto partition : partitions) {
              auto int32ty = Type::getInt32Ty(mod->getContext());
              OperandBundleDef bd = OperandBundleDef(
                  "xlx_array_partition",
                  (std::vector<Value *>){
                      arg, ConstantInt::get(int32ty, partition.first),
                      ConstantInt::get(int32ty, partition.second),
                      ConstantInt::get(int32ty, 1) /* block scheme*/});
              builder.CreateCall(arrayPartitionFunc, {}, {bd});
            }
          }
        }
      }

    return false;
  }
};

} // namespace

static std::string interpretArgumentType(Type *type) {
  if (type->isVoidTy())
    return "void";
  if (type->isIntegerTy(1))
    return "bool";
  if (type->isIntegerTy()) // TODO: could this be long?
    return "int";
  if (type->isDoubleTy())
    return "double";
  if (type->isFloatTy())
    return "float";
  if (type->isPointerTy()) {
    auto pointerTy = dyn_cast<Type>(type);
    auto elementTy = pointerTy->getPointerElementType();
    // A plain pointer
    if (!elementTy->isArrayTy())
      return interpretArgumentType(elementTy) + "*";

    // Pointer to an array
    /// TODO: could type itself be an array type?
    auto arrayTy = dyn_cast<ArrayType>(elementTy);
    Type *nextTy;
    do {
      nextTy = arrayTy->getElementType();
      arrayTy = dyn_cast<ArrayType>(nextTy);
    } while (arrayTy);
    return interpretArgumentType(nextTy);
  }

  return "undefined_type";
}

static Function *findFunc(Module *M, StringRef name) {
  for (auto &F : *M)
    if (F.getName() == name)
      return &F;
  return nullptr;
}

static Value *findIntegerArg(Function &F) {
  for (unsigned i = 0; i < F.arg_size(); ++i) {
    Value *arg = F.getArg(i);
    if (arg->getType()->isIntegerTy())
      return arg;
  }
  return nullptr;
}

/// Generate the dummy C file for testbench generation. The function interface
/// and body are generated from the input LLVM (top) function.
static void generateXlnTBDummy(Function &F, StringRef fileName) {
  std::error_code ec;
  llvm::raw_fd_ostream XlnTBDummy(fileName, ec);
  if (ec) {
    errs() << ec.message() << '\n';
    return;
  }

  // Find an integer argument to use as indices which results in
  // unpredictable memory acccesses. This forces Vitis to generate generic
  // RAM ports for all the arrays.
  Value *intArg = findIntegerArg(F);

  // Build the function interface.
  SmallVector<std::string> argDeclList, argList, funcStmtList;
  for (unsigned i = 0; i < F.arg_size(); i++) {
    auto arg = F.getArg(i);
    auto argType = arg->getType();
    auto argName = arg->getName().str();
    argList.push_back(argName);

    // e.g. (in C), int A, float *p.
    std::string argDecl = interpretArgumentType(argType) + " " + argName;

    // If it is an array, then append the dimension information
    // e.g. (in LLVM), [32 x f64]* %0
    if (isPointerToArray(argType)) {
      auto dims = getArrayDimensionInfo(
          dyn_cast<ArrayType>(argType->getPointerElementType()));
      for (auto dim : dims)
        argDecl += "[" + std::to_string(dim.second) + "]";

      // The function body does some meaningless array assignments just to
      // make sure that Vitis generates proper RAM interface. Add memory
      // accesses to the function body to ensure the RAM ports are
      // properly generated.
      //
      // Suppose the original LLVM interface looks like -
      //     @foo(i32 %N, [10 x float]* %A)
      //
      // We will generate the following C statements as the function body -
      //     A[N + 1] += A[N];
      //
      // Note that the access might be out-of-bound here. But since this body is
      // just used to direct HLS design INTERFACE generation and will later be
      // discarded, these malformed accesses are negligible.

      if (intArg) {
        std::string readVar = argName, storeVar = argName;
        for (unsigned j = 0; j < dims.size(); ++j) {
          readVar += "[" + intArg->getName().str() + "]";
          storeVar += "[" + intArg->getName().str() + " + 1]";
        }
        funcStmtList.push_back(storeVar + " += " + readVar + ";");
      }
    }

    argDeclList.push_back(argDecl);
  }

  // Generate dummy file
  // Function definition -
  XlnTBDummy << interpretArgumentType(F.getReturnType()) << " " << F.getName()
             << "(";
  interleaveComma(argDeclList, XlnTBDummy);
  XlnTBDummy << ") {\n";
  interleave(funcStmtList, XlnTBDummy, "\n\t");
  XlnTBDummy << "\n}\n\n";

  // Main definition -
  XlnTBDummy << "int main() {\n";
  // Prepend the `static' keyword to mitigate segmentfault.
  for (auto &argDecl : argDeclList)
    argDecl = std::string("static ") + argDecl;
  // Value declaration
  interleave(argDeclList, XlnTBDummy, ";\n");
  if (!argDeclList.empty())
    XlnTBDummy << ";\n";
  // Function call
  XlnTBDummy << F.getName() << "(";
  interleaveComma(argList, XlnTBDummy);
  XlnTBDummy << ");\n"
             << "return 0;\n"
             << "}\n";
}

static void generateXlnTBTcl(Function &F, StringRef fileName,
                             StringRef dummyFileName,
                             bool arrayPartitionEnabled,
                             bool arrayPartitionFlattened) {
  std::error_code ec;
  llvm::raw_fd_ostream XlnTBTcl(fileName, ec);
  if (ec) {
    errs() << ec.message() << '\n';
    return;
  }

  // Generate tcl file
  XlnTBTcl << "open_project -reset proj\n"
           << "add_files " << dummyFileName << "\n"
           << "add_files -tb " << dummyFileName << "\n"
           << "set_top " << F.getName().str() << "\n"
           << "open_solution -reset solution1\n"
           << "set_part \"xc7vx690t-ffg1930-3\"\n"
           << "create_clock -period " << std::to_string(getClockPeriod()) << "\n"
           //  << "config_compile -pipeline_loops 16\n"
           << '\n';

  //for (unsigned i = 0; i < F.arg_size(); i++) {
  //  auto arg = F.getArg(i);
  //  if (isPointerToArray(arg->getType())) {
  //    auto arrayTy =
  //        dyn_cast<ArrayType>(arg->getType()->getPointerElementType());
  //    if (arrayPartitionEnabled) {
  //      auto partitions = getArrayDimensionInfo(arrayTy);
  //      // dbgs() << "Partition size: " << partitions.size() << '\n';
  //      if (partitions.size() != 1) { // won't handle 1-dim array
  //        if (arrayPartitionFlattened)
  //          partitions.pop_back_n(partitions.size() - 1);
  //        else {
  //          assert(
  //              partitions.size() % 2 == 0 &&
  //              "The number of dims should be divisble by 2 if the partition "
  //              "dims are not flattened");
  //          partitions.pop_back_n(partitions.size() / 2);
  //        }
//
  //        for (auto partition : partitions)
  //          XlnTBTcl << "set_directive_array_partition -dim " << partition.first
  //                   << " -factor " << partition.second << " -type block \""
  //                   << getXlnTop() << "\" " << arg->getName() << "\n";
  //      }
  //    }
  //    XlnTBTcl << "set_directive_interface " << F.getName() << " "
  //             << arg->getName() << " -mode ap_memory -storage_type ram_2p\n";
  //  }
  //}

  XlnTBTcl << "set ::LLVM_CUSTOM_OPT "
           << getXlnFEPath()
           << "/hls-build/bin/opt\n"
           << "set ::LLVM_CUSTOM_CMD {$LLVM_CUSTOM_OPT "
           << getXlnLLVMIn()
           << " -o $LLVM_CUSTOM_OUTPUT}\n"
           //  << "config_bind -effort high\n"
           << "csynth_design\n"
           << "cosim_design\n"
           //<< "config_export -version 2.0.1\n"
           << "export_design -format syn_dcp -flow impl\n";
}

namespace {

/// Generate test bench tcl script and C dummy for Xilinx Vitis. This pass
/// parses the LLVM IR and generates compatible test bench for the design in
/// LLVM IR.
struct XilinxTBTclGenPass : public ModulePass {
  static char ID;
  XilinxTBTclGenPass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    assert(!getXlnTop().empty() && "Top function name should be set.");

    Function *F = findFunc(&M, getXlnTop());
    assert(F && "Top function should be found.");

    // Generate the dummy C file.
    generateXlnTBDummy(*F, getXlnTBDummyNames());
    // Generate the Tcl file.
    generateXlnTBTcl(*F, getXlnTBTclNames(), getXlnTBDummyNames(),
                     getXlnArrayPartitionEnabled(),
                     getXlnArrayPartitionFlattened());

    return false;
  }
};

} // namespace

static void nameLoop(Loop *loop, int &loopCounter) {
  SmallVector<Metadata *, 4> Args;

  // Reserve operand 0 for loop id self reference.
  LLVMContext &Context = loop->getHeader()->getContext();
  auto TempNode = MDNode::getTemporary(Context, None);
  Args.push_back(TempNode.get());

  // Loop name
  Metadata *nameVals[] = {
      MDString::get(Context, "llvm.loop.name"),
      MDString::get(Context, "VITIS_LOOP_" + std::to_string(loopCounter))};
  Args.push_back(MDNode::get(Context, nameVals));

  // Set the first operand to itself.
  MDNode *LoopID = MDNode::get(Context, Args);
  LoopID->replaceOperandWith(0, LoopID);
  loop->setLoopID(LoopID);
  loopCounter++;

  if (!loop->isInnermost())
    for (auto &subloop : loop->getSubLoops())
      nameLoop(subloop, loopCounter);
}

namespace {

/// Assign a name to each loop and enable flattening for Xilinx Vitis.
struct XilinxNameLoopPass : public ModulePass {
  static char ID;
  XilinxNameLoopPass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {

    int loopCounter = 0;
    for (auto &F : M)
      if (F.getName() != getXlnTop() && !F.empty()) {
        auto DT = llvm::DominatorTree(F);
        LoopInfo LI(DT);

        if (!LI.empty())
          for (auto &loop : LI)
            nameLoop(loop, loopCounter);
      }

    return false;
  }
};

} // namespace

// -----------------------------------------------------------------------------------
// Mark no inline for kernels'

/// Check if the input function is a scop.stmt based on the pattern S[0-1]+
static bool isScopStmt(Function &F) {
  StringRef name = F.getName();
  if (!name.startswith("S"))
    return false;

  StringRef suffix = name.drop_front();
  if (any_of(suffix, [](const char &c) { return !isdigit(c); }))
    return false;

  return true;
}

namespace {

struct AnnotateNoInlinePass : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  AnnotateNoInlinePass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    bool modified = false;
    for (auto &F : M) {
      if (!isScopStmt(F)) {
        if (!F.hasFnAttribute(Attribute::NoInline)) {
          modified = true;
          F.addFnAttr(Attribute::NoInline);
        }
      } else {
        modified = true;
        // Should always inline scop.stmt.
        F.addFnAttr(Attribute::AlwaysInline);
      }
    }

    return modified;
  }
};

} // namespace

namespace {

/// Add attributes related to memory interfaces to each of the array arguments
/// of a function.
struct ConfigMemoryInterfacePass : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  ConfigMemoryInterfacePass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    assert(!getXlnTop().empty() && "Top function name should be set.");

    Function *F = findFunc(&M, getXlnTop());
    assert(F && "Top function should be found.");

    auto attributeList = F->getAttributes();
    for (unsigned i = 0; i < F->arg_size(); i++) {
      Value *arg = F->getArg(i);
      if (isPointerToArray(arg->getType())) {
        // Set ap_memory interface to array arguments.
        auto arrayName = arg->getName().str();
        attributeList = attributeList.addAttributeAtIndex(
            F->getContext(), i + 1, "fpga.address.interface",
            "ap_memory." + arrayName);

        // Set bram configuration to function metadata.
        auto &C = F->getContext();
        // A list of aggregated metadata
        SmallVector<Metadata *, 32> ops;
        ops.push_back(MDString::get(C, arrayName));
        ops.push_back(MDString::get(C, "ap_memory"));
        ops.push_back(ConstantAsMetadata::get(
            ConstantInt::get(IntegerType::get(C, 32), 666)));
        ops.push_back(ConstantAsMetadata::get(
            ConstantInt::get(IntegerType::get(C, 32), 208 /*ram2p*/)));
        ops.push_back(ConstantAsMetadata::get(
            ConstantInt::get(IntegerType::get(C, 32), -1)));
        // One additional metadata annotating the adaptor type.
        auto *N = MDTuple::get(C, ops);
        F->setMetadata("fpga.adaptor.bram." + arrayName, N);
      }
    }
    F->setAttributes(attributeList);

    return false;
  }
};

} // namespace

char RenameBasicBlocksAndValues::ID = 2;
static RegisterPass<RenameBasicBlocksAndValues>
    X3("xlnname", "Rename entities in the model with string prefixes to follow "
                  "Xilinx tool guidance.");

char AnnotateXilinxAttributes::ID = 3;
static RegisterPass<AnnotateXilinxAttributes>
    X4("xlnanno", "Annotate attributes for Xilinx HLS.");

char StripInvalidAttributes::ID = 4;
static RegisterPass<StripInvalidAttributes>
    X5("strip-attr",
       "Strip invalid function attributes not compatible with Clang 3.9.");

char XilinxRewriteMathInstPass::ID = 5;
static RegisterPass<XilinxRewriteMathInstPass>
    X6("xlnmath", "Rewrite math instructions for Xilinx Vitis.");

char XilinxUnrollPass::ID = 6;
static RegisterPass<XilinxUnrollPass>
    X7("xlnunroll",
       "Unroll all the loops in a specified function for Xilinx Vitis.");

char XilinxArrayPartitionPass::ID = 7;
static RegisterPass<XilinxArrayPartitionPass> X8(
    "xlnarraypartition",
    "Partition arrays in the top-level function arguments for Xilinx Vitis.");

char XilinxTBTclGenPass::ID = 8;
static RegisterPass<XilinxTBTclGenPass>
    X9("xlntbgen",
       "Generate test bench tcl script and dummy C code for Xilinx Vitis.");

char XilinxNameLoopPass::ID = 9;
static RegisterPass<XilinxNameLoopPass> X10("xlnloopname",
                                            "Name loops for Xilinx Vitis.");

char AnnotateNoInlinePass::ID = 10;
static RegisterPass<AnnotateNoInlinePass>
    X11("anno-noinline", "Annotate noinline to the functions.");

char ConfigMemoryInterfacePass::ID = 11;
static RegisterPass<ConfigMemoryInterfacePass>
    X12("xlnram2p",
        "Config all the arrays to have ram2p interface for Xilinx Vitis.");