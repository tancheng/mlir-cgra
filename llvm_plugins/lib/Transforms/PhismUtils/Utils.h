//===- Utils.h --------------------------------------------------*- C++ -*-===//
// LLVM transform utilities.
//===----------------------------------------------------------------------===//

#include <string>

namespace llvm {
class Type;
}

namespace phism {
namespace llvm {

bool isPointerToArray(::llvm::Type *);

std::string getXlnTop();
std::string getXlnNames();
std::string getXlnTBTclNames();
std::string getXlnTBDummyNames();
std::string getXlnLLVMIn();
std::string getXlnFEPath();
std::string getTargetBoard();
int getClockPeriod();
bool getXlnArrayPartitionEnabled();
bool getXlnArrayPartitionFlattened();
int getXlnLoopUnrollMaxCount();
int getXlnLoopUnrollMaxDepth();
bool getXlnHasNonAffine();

} // namespace llvm
} // namespace phism