#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {
struct Namer : public FunctionPass {
  static char ID;
  Namer() : FunctionPass(ID) {}

  bool runOnFunction(Function &F) override {
    errs() << "Namer: ";
    errs().write_escaped(F.getName()) << '\n';
    return false;
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





