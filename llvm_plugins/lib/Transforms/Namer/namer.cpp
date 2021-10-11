#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Type.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {
struct Namer : public FunctionPass {
  static char ID;
  Namer() : FunctionPass(ID) {}

  bool runOnFunction(Function &F) override {
    if (!F.isDeclaration()) {
      int alloca_counter = 0;
      for (auto I = inst_begin(F), E = inst_end(F); I != E; ++I) {
        if (isa<AllocaInst>(*I)) {
          std::string my_base = "alloca_";
          std::string my_function = std::string(F.getName());
          std::string my_ID = std::to_string(alloca_counter);
          std::string my_name = my_base + my_function + my_ID;
          I->addAnnotationMetadata(my_name);
          alloca_counter++;
          // further information can be appended with further calls to
          // addAnnotationMetadata
        }
      }
    }

    return true;
  }
}; // end of struct Namer
} // end of anonymous namespace

char Namer::ID = 0;
static RegisterPass<Namer>
    X("namer",
      "Assign metadata representing names for memory allocation operations.",
      false /* Only looks at CFG */, false /* Analysis Pass */);

static RegisterStandardPasses Y(PassManagerBuilder::EP_EarlyAsPossible,
                                [](const PassManagerBuilder &Builder,
                                   legacy::PassManagerBase &PM) {
                                  PM.add(new Namer());
                                });