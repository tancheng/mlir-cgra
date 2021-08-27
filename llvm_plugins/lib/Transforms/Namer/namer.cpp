#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {
struct Namer : public FunctionPass {
  static char ID;
  Namer() : FunctionPass(ID) {}

  bool runOnFunction(Function &F) override {
    LLVMContext& C = F.getContext();
    if (!F.isDeclaration()) {
      for (auto I = inst_begin(F), E = inst_end(F); I != E; ++I) {
        if(isa<AllocaInst>(*I))
		    {
          // base name
          std::string mem = "mem";
          // add information about type and size
          std::string my_name = mem + "1";
          MDNode* N1 = MDNode::get(C, MDString::get(C, my_name));
          I->setMetadata("mem.name", N1);
          // Type* t = cast<AllocaInst>(*I).getAllocatedType();
          // errs() << t->str() << "\n";
          // errs() << cast<AllocaInst>(*I).getAllocatedType() << "\n";
          // char* ty = LLVMPrintTypeToString(cast<LLVMTypeRef>(t));
      	}
      }
    }

      for(auto I = inst_begin(F), E = inst_end(F); I != E; ++I) {
        if (MDNode* N = (*I).getMetadata("mem.name")) {
          errs() << cast<MDString>(N->getOperand(0))->getString() << "\n";
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





