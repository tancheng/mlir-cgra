//===- MemRefToArray.cc -----------------------------------------*- C++ -*-===//
//
// This file implements a pass that rewrites memref struct to plain array.
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

using namespace llvm;
using namespace phism::llvm;

#define DEBUG_TYPE "vhls_llvm"

/// Will abort if the Value is not a ConstantInt.
static int64_t getI64Value(Value *value) {
  assert(isa<ConstantInt>(value));

  ConstantInt *CI = dyn_cast<ConstantInt>(value);
  assert(CI->getBitWidth() == 64);

  return CI->getSExtValue();
}

/// Get the dimensions from the provided array type.
static SmallVector<int64_t> getDimsFromArrayType(ArrayType *type) {
  SmallVector<int64_t> dims;
  dims.push_back(type->getNumElements());

  while (type && type->getArrayElementType()->isArrayTy()) {
    type = dyn_cast<ArrayType>(type->getArrayElementType());
    dims.push_back(type->getNumElements());
  }

  return dims;
}

namespace {

/// InsExtSequence holds a sequence of `insertvalue` and `extractvalue`
/// instructions that operate on the same aggregated value, which correpsonds to
/// a `memref` value in MLIR.
/// For more information on how the `memref` type is organized:
/// https://mlir.llvm.org/docs/ConversionToLLVMDialect/#default-convention
class InsExtSequence {
public:
  Value *ptr = nullptr;                  /// aligned pointer.
  Value *offset = nullptr;               /// offset.
  SmallVector<Value *, 4> dim_values;    /// dimensionality.
  SmallVector<Value *, 4> stride_values; /// stride in each dim.
  SmallVector<int64_t, 4> dims;          /// dimensionality.
  SmallVector<int64_t, 4> strides;       /// stride in each dim.

  /// Sequences of `insertvalue` and `extractvalue` instructions.
  SmallVector<Instruction *, 4> insertInsts;
  SmallVector<Instruction *, 4> extractInsts;

  Type *getRankedArrayType(ArrayRef<int64_t> dims) const {
    Type *newType =
        ArrayType::get(ptr->getType()->getPointerElementType(), dims.back());
    for (size_t i = 1; i < dims.size(); i++)
      newType = ArrayType::get(newType, dims[dims.size() - i - 1]);
    return newType;
  }

  /// Create a new type from the ptr and dims.
  Type *getRankedArrayType() const { return getRankedArrayType(dims); }

  /// Initialize the data fields.
  bool initialize(Type *type) {
    if (!type->isAggregateType() || !isa<StructType>(type))
      return false;

    StructType *structType = dyn_cast<StructType>(type);
    if (structType->getNumElements() != 5)
      return false;

    // The sizes of each dim is the 4th field.
    ArrayType *dimsType = dyn_cast<ArrayType>(structType->getElementType(3));
    if (!dimsType)
      return false;
    // Unset the dims array.
    dims.assign(dimsType->getNumElements(), -1);
    dim_values.assign(dimsType->getNumElements(), nullptr);

    // Gather strides.
    ArrayType *stridesType = dyn_cast<ArrayType>(structType->getElementType(4));
    if (!stridesType ||
        stridesType->getNumElements() != dimsType->getNumElements())
      return false;
    strides.assign(stridesType->getNumElements(), -1);
    stride_values.assign(stridesType->getNumElements(), nullptr);

    return true;
  }

  bool insertInstsCompleted() const {
    return insertInsts.size() == dims.size() * 2 + 3;
  }

  bool checkAggregatedType(Type *type) const {
    if (!type->isAggregateType() || !isa<StructType>(type))
      return false;

    StructType *structType = dyn_cast<StructType>(type);
    if (structType->getNumElements() != 5)
      return false;

    ArrayType *dimsType = dyn_cast<ArrayType>(structType->getElementType(3));
    if (!dimsType || dimsType->getNumElements() != dims.size())
      return false;

    ArrayType *stridesType = dyn_cast<ArrayType>(structType->getElementType(4));
    if (!stridesType || stridesType->getNumElements() != strides.size())
      return false;

    return true;
  }
  /// From the scalar offset to a set of offset for each dim.
  /// There should be in total dimSize * 2 expressions.
  /// Dim size will be dims.size() * 2 since the dims in this Seq only has the
  /// tile dims.
  void processOffset(Function &F) {
    // Won't process constant offsets.
    if (isa<ConstantInt>(offset))
      return;

    LLVM_DEBUG({
      dbgs() << "\n--------------------------------------\n";
      dbgs() << "Processing offset for target pointer: \n";
      ptr->dump();
      dbgs() << " within function:\n";
      F.dump();
    });

    SmallVector<Value *> offsets;
    SmallVector<int64_t> strides;

    Value *curr = offset;
    BinaryOperator *binOp;
    unsigned dimSize =
        getXlnArrayPartitionFlattened() ? dims.size() + 1 : dims.size() * 2;
    for (unsigned i = 0; i < dimSize; ++i) {
      binOp = cast<BinaryOperator>(curr);
      assert(binOp->getOpcode() == BinaryOperator::Add);

      Value *lhs = binOp->getOperand(0), *rhs = binOp->getOperand(1);
      BinaryOperator *lhsBinOp = dyn_cast<BinaryOperator>(lhs);
      BinaryOperator *rhsBinOp = dyn_cast<BinaryOperator>(rhs);
      BinaryOperator *mul =
          (lhsBinOp && lhsBinOp->getOpcode() == BinaryOperator::Mul) ? lhsBinOp
                                                                     : rhsBinOp;
      BinaryOperator *add =
          (lhsBinOp && lhsBinOp->getOpcode() == BinaryOperator::Mul) ? rhsBinOp
                                                                     : lhsBinOp;

      assert(mul && mul->getOpcode() == BinaryOperator::Mul);
      assert(!add || add->getOpcode() == BinaryOperator::Add);

      // Offsets and strides are both from the mul operands, since we basically
      // multiply offset by stride.
      // Strides should be constant values.
      offsets.push_back(mul->getOperand(0));
      strides.push_back(getI64Value(mul->getOperand(1)));

      if (add)
        curr = cast<Value>(add);
    }

    assert(!offsets.empty());
    assert(offsets.size() == strides.size());
    assert(strides[0] == 1);

    LLVM_DEBUG({
      dbgs() << "Offsets: \n";
      for (Value *offset : offsets)
        offset->dump();
      dbgs() << "Strides: ";
      interleave(
          strides, [&](const int64_t &stride) { dbgs() << stride; },
          [&]() { dbgs() << ", "; });
      dbgs() << "\n\n";
    });

    SmallVector<int64_t> partialDims;
    for (unsigned i = 1; i < strides.size(); ++i)
      partialDims.push_back(strides[i] / strides[i - 1]);
    assert(partialDims.size() == dimSize - 1);

    LLVM_DEBUG({
      dbgs() << "Partial dims:\n";
      interleave(
          partialDims, [&](const int64_t &v) { dbgs() << v; },
          [&]() { dbgs() << ", "; });
      dbgs() << "\n";
    });

    std::reverse(partialDims.begin(), partialDims.end());
    std::reverse(offsets.begin(), offsets.end());

    Type *rankedArrType = getRankedArrayType(partialDims);
    Type *restoredType =
        PointerType::get(PointerType::get(rankedArrType, F.getAddressSpace()),
                         F.getAddressSpace());

    // Below is a sequence of instructions that -
    // 1. Cast the original pointer to a pointer that points to an array;
    // 2. Load the array
    // 3. Get the subarray based on the offsets using GEP.
    // 4. Cast the subarray into raw pointer, so that it can be accepted by the
    // original callers.
    BitCastInst *bitCastInst = new BitCastInst(
        ptr, restoredType, Twine(""), cast<Instruction>(offset)->getNextNode());
    LoadInst *load = new LoadInst(
        cast<Type>(restoredType)->getPointerElementType(), bitCastInst,
        Twine(""), cast<Instruction>(bitCastInst->getNextNode()));

    SmallVector<Value *> gepInds;
    for (unsigned i = 0;
         i < (getXlnArrayPartitionFlattened() ? 1 : offsets.size() / 2); ++i)
      gepInds.push_back(offsets[i]);
    GetElementPtrInst *gep =
        GetElementPtrInst::Create(rankedArrType, load, gepInds, Twine(""),
                                  cast<Instruction>(load->getNextNode()));
    ptr = new BitCastInst(gep, ptr->getType(), Twine(""),
                          cast<Instruction>(gep)->getNextNode());

    LLVM_DEBUG({
      dbgs() << "Created the following instructions:\n";
      bitCastInst->dump();
      load->dump();
      gep->dump();
      ptr->dump();

      dbgs() << "\nExpected result type:\n";
      gep->getType()->dump();
    });
  }

  /// Append insInst to the insertInsts list, and gather the value to be
  /// inserted into the members of this class.
  bool addInsertInst(InsertValueInst *insInst) {
    Value *agg = insInst->getAggregateOperand();
    if (!checkAggregatedType(agg->getType()))
      return false;

    ArrayRef<unsigned> indices = insInst->getIndices();
    assert(indices.size() >= 1);

    if (indices[0] == 1) {
      setMemberOnce(ptr, insInst->getInsertedValueOperand());
      LLVM_DEBUG(dbgs() << " ---> Set ptr to " << (*ptr) << '\n');
      assert(ptr->getType()->isPointerTy() && "ptr should be a pointer.");
    } else if (indices[0] == 2) {
      setMemberOnce(offset, insInst->getInsertedValueOperand());
    } else if (indices[0] == 3) {
      assert(dims.size() > indices[1]);
      setMemberOnce(dims[indices[1]],
                    getI64Value(insInst->getInsertedValueOperand()), -1);
      setMemberOnce(dim_values[indices[1]], insInst->getInsertedValueOperand());
    } else if (indices[0] == 4) {
      assert(strides.size() > indices[1]);
      setMemberOnce(strides[indices[1]],
                    getI64Value(insInst->getInsertedValueOperand()), -1);
      setMemberOnce(stride_values[indices[1]],
                    insInst->getInsertedValueOperand());
    }

    insertInsts.push_back(insInst);
    return true;
  }

  /// Erase all insertvalue and extractvalue instructions associated with this
  /// instance. Be careful that here we erase from the last instruction in the
  /// sequence to the first.
  void eraseAllInsts() {
    while (!extractInsts.empty()) {
      Instruction *inst = extractInsts.pop_back_val();
      if (!inst->use_empty())
        inst->dump();
      assert(inst->use_empty());
      inst->eraseFromParent();
    }

    while (!insertInsts.empty()) {
      Instruction *inst = insertInsts.pop_back_val();
      if (!inst->use_empty())
        inst->dump();
      assert(inst->use_empty());
      inst->eraseFromParent();
    }
  }

  /// Replace the uses of values defined by `extractvalue` with the original
  /// values.
  void replaceExtractValueUses() {
    for (Instruction *inst : extractInsts) {
      ExtractValueInst *extInst = dyn_cast<ExtractValueInst>(inst);
      if (extInst->getNumIndices() == 1) {
        if (extInst->getIndices()[0] == 1)
          extInst->replaceAllUsesWith(ptr);
        if (extInst->getIndices()[0] == 2)
          extInst->replaceAllUsesWith(offset);
      } else if (extInst->getNumIndices() == 2) {
        if (extInst->getIndices()[0] == 3) {
          extInst->replaceAllUsesWith(dim_values[extInst->getIndices()[1]]);
        } else if (extInst->getIndices()[0] == 4) {
          extInst->replaceAllUsesWith(stride_values[extInst->getIndices()[1]]);
        }
      }
    }
  }

private:
  /// The member `lhs` can only be set if it currently is the default value.
  template <typename T, typename U>
  void setMemberOnce(T &lhs, T rhs, U defaultValue) {
    assert(lhs == defaultValue);
    lhs = rhs;
  }

  template <typename T> void setMemberOnce(T *&lhs, T *rhs) {
    assert(lhs == nullptr);
    lhs = rhs;
  }
};

} // namespace

static void
findInsertExractValueSequences(Function &F,
                               SmallVectorImpl<InsExtSequence> &seqs) {
  SmallPtrSet<Instruction *, 4> visited;
  SmallDenseMap<Value *, unsigned> StructToSeqId;

  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {
      // An InsExtSequence starts at an `insertvalue` instruction
      // instance with its 1st operand undefined (`undef`).
      if (InsertValueInst *insInst = dyn_cast<InsertValueInst>(&I)) {
        if (isa<UndefValue>(insInst->getOperand(0))) {
          assert(insInst->getAggregateOperand());

          InsExtSequence seq;
          // If initialize fails, then we should know that `insertvalue` doesn't
          // operate on a Value of `memref` type.
          if (!seq.initialize(insInst->getAggregateOperand()->getType()))
            continue;

          bool isValidSeq = true;

          // Now we trace through the use-def chain of the value defined by the
          // first `insertvalue`.
          Instruction *inst = &I;
          while (isa<InsertValueInst>(inst)) {
            // If we find a visited instruction in the use-def chain, it is a
            // case we cannot handle, and therefore, invalid.
            // Otherwise, we try to append the instruction.
            if (visited.contains(inst) ||
                !seq.addInsertInst(cast<InsertValueInst>(inst))) {
              isValidSeq = false;
              break;
            }
            visited.insert(inst);

            if (seq.insertInstsCompleted())
              break;

            // The only user of a `insertvalue` applied to memref should be a
            // `insertvalue` inst.
            if (inst->getNumUses() != 1 ||
                !isa<InsertValueInst>(*inst->user_begin())) {
              isValidSeq = false;
              break;
            }
            inst = dyn_cast<InsertValueInst>(*inst->user_begin());
          }

          // At this point, `inst` should be the last `insertvalue` applied on
          // the memref value. It's users should all be `extractvalue`.
          Instruction *lastInst = inst;
          for (User *user : lastInst->users()) {
            inst = dyn_cast<Instruction>(user);
            if (!isa<ExtractValueInst>(inst) || visited.contains(inst)) {
              isValidSeq = false;
              break;
            }
            visited.insert(inst);
            seq.extractInsts.push_back(inst);
          }

          // Every condition is matched.
          if (!isValidSeq)
            continue;

          LLVM_DEBUG({
            dbgs() << " - Resolved ptr: " << (*seq.ptr) << '\n';
            dbgs() << " - Found valid insert/extract sequence:\n";
            dbgs() << " - Inserts:\n";
            for (auto I : seq.insertInsts)
              I->dump();
            dbgs() << " - Extracts:\n";
            for (auto I : seq.extractInsts)
              I->dump();
            dbgs() << "\n";
          });

          seq.processOffset(F);
          seq.replaceExtractValueUses();
          seqs.push_back(seq);

          LLVM_DEBUG(dbgs() << " Function after update:\n" << (F) << '\n');
        }
      }
    }
  }
}

/// After this pass, a new function cloned from `F` will have ranked array
/// arguments at the end, which are duplicated from those unranked.
/// The mapping from unranked arrays to their resp. ranked counterparts will be
/// stored in `RankedArrVMap`.
static Function *
duplicateFunctionsWithRankedArrays(Function *F,
                                   SmallVectorImpl<InsExtSequence> &Seqs,
                                   ValueToValueMapTy &RankedArrVMap) {

  // Resolve parameter types. The first part should be the same as `F`, and the
  // second part should let every Seq create a new Array in their order.
  SmallVector<Type *, 4> ParamTypes;
  FunctionType *FuncType = F->getFunctionType();

  for (unsigned i = 0; i < FuncType->getFunctionNumParams(); ++i)
    ParamTypes.push_back(FuncType->getFunctionParamType(i));

  SmallPtrSet<Value *, 4> ExistArgs;
  for (unsigned i = 0; i < F->arg_size(); ++i)
    ExistArgs.insert(F->getArg(i));

  // Map an argument to the new ranked array type.
  SmallDenseMap<Value *, Type *> ArgToArrType;

  LLVM_DEBUG({
    dbgs() << "============\n Existing sequences\n";
    for (InsExtSequence &Seq : Seqs)
      dbgs() << "\n * Ptr: " << (*Seq.ptr)
             << "\n * Type: " << (*Seq.getRankedArrayType()) << "\n\n";
    dbgs() << "============\n";
  });

  for (InsExtSequence &Seq : Seqs) // Each Seq has a new ArrayType arg.
    // Note that here we only set the array type ONCE. It is based on the
    // understanding that the first sequence will give the full info of the
    // target memref.
    if (ExistArgs.count(Seq.ptr) && !ArgToArrType.count(Seq.ptr))
      ArgToArrType[Seq.ptr] = Seq.getRankedArrayType();

  for (InsExtSequence &Seq : Seqs) { // Each Seq has a new ArrayType arg.
    AllocaInst *I = dyn_cast<AllocaInst>(Seq.ptr);
    if (!I) { // Will resolve the function arguments later.
      // If the source ptr for the Sequence is a function argument, we extend
      // the function signature.
      if (ExistArgs.count(Seq.ptr))
        ParamTypes.push_back(
            PointerType::get(ArgToArrType[Seq.ptr], F->getAddressSpace()));
    } else // Create a new AllocaInst.
      new AllocaInst(Seq.getRankedArrayType(), F->getAddressSpace(), Twine(""),
                     I);
  }

  FunctionType *NewFuncType =
      FunctionType::get(F->getReturnType(), ParamTypes, F->isVarArg());

  // Instantiate the new Function instance. Its name extends the original one
  // with .new, and possibly we won't need this feature.
  Function *NewFunc =
      Function::Create(NewFuncType, F->getLinkage(), F->getAddressSpace(),
                       F->getName() + ".dup_ranked", F->getParent());

  // For cloning, we should map the original parameters to the new ones in the
  // new function.
  ValueToValueMapTy VMap;
  for (unsigned i = 0; i < F->arg_size(); i++)
    VMap[F->getArg(i)] = NewFunc->getArg(i);

  // We also map the raw pointers to the new ranked arrays. Note that the key to
  // this map is the new argument in the `NewFunc`. The value of the mapping is
  // the newly appended arguments at the end of `NewFunc`.
  unsigned j = 0;
  for (unsigned i = 0; i < Seqs.size(); i++)
    if (VMap.count(Seqs[i].ptr))
      RankedArrVMap[VMap[Seqs[i].ptr]] = NewFunc->getArg(F->arg_size() + (j++));

  // Finally, clone the content from the old function into the new one.
  SmallVector<ReturnInst *, 4> Returns;
  CloneFunctionInto(NewFunc, F, VMap, CloneFunctionChangeType::LocalChangesOnly,
                    Returns);

  // Map the alloca pairs. It is based on the previous code that the new static
  // alloca will always be one instruction before the one it is mapped from.
  for (BasicBlock &BB : *NewFunc)
    for (Instruction &I : BB) {
      AllocaInst *Curr = dyn_cast<AllocaInst>(&I);
      if (!Curr)
        continue;
      AllocaInst *Next = dyn_cast<AllocaInst>(Curr->getNextNode());
      if (!Next)
        continue;
      if (Curr->isStaticAlloca())
        RankedArrVMap[Next] = Curr;
    }

  return NewFunc;
}

/// Get the size of each array dimension. If the array type is like [2 x [3 x
/// float]], then the sizes returned will be {3, 1}.
static void getArraySizes(Type *Ty, SmallVectorImpl<Value *> &Sizes) {
  SmallVector<int64_t, 4> IntDims;
  while (Ty->isArrayTy()) {
    IntDims.push_back(Ty->getArrayNumElements());
    Ty = Ty->getArrayElementType();
  }

  int64_t IntSize = 1;
  Sizes.resize(IntDims.size());
  for (unsigned i = 0; i < IntDims.size(); i++) {
    Sizes[IntDims.size() - i - 1] =
        ConstantInt::get(IntegerType::get(Ty->getContext(), 64), IntSize);
    IntSize *= IntDims[IntDims.size() - i - 1];
  }
}

/// Duplicate the given GEP instruction, with its operand replaced by its
/// ranked array counterpart.
static Instruction *duplicateGEPWithRankedArray(Instruction *I,
                                                ValueToValueMapTy &RankedArrMap,
                                                unsigned &NumNewGEP) {
  assert(isa<GetElementPtrInst>(I) &&
         "Instruction given should be a GetElementPtrInst type.");

  GetElementPtrInst *GEP = cast<GetElementPtrInst>(I);
  assert(RankedArrMap.count(GEP->getPointerOperand()) &&
         "The original operand of the GEP should be in the RankedArrMap");

  // New pointer operand for the new GEP.
  Value *RankedArrayPtr = RankedArrMap[GEP->getPointerOperand()];
  SmallVector<Value *, 4> ArrSizes;
  getArraySizes(RankedArrayPtr->getType()->getPointerElementType(), ArrSizes);

  // The address to be accessed. We will recover the addresses to each dimension
  // from it.
  Value *Addr = *(GEP->idx_begin() + 0);

  // Here we iteratively resolve the index for the new GEP at each level of the
  // ranked array.
  SmallVector<Value *, 4> IdxList;

  // The first index should always be 0.
  ConstantInt *Zero =
      ConstantInt::get(IntegerType::get(I->getContext(), 64), 0);
  IdxList.push_back(Zero);

  // The reset of the indices will be calculated iteratively, based on the
  // formula: Addr[i + 1] = Idx[i] * ArrSizes[i] + Addr[i]. Here:
  //
  // - Addr[i] is the flattened address for level i;
  // - Idx[i] is the exact index at the i-th level;
  // - and ArrSizes[i] is the i-th level's size.
  //
  // For instance, given an array of dims [2][3][4] and its flattened address
  // 10, we can calculate its each dim's address by:
  //
  // Addr[0] = 10;
  // Idx[0] = 10 / 12 = 0, Addr[1] = 10 % 12 = 10;
  // Idx[1] = 10 / 4 = 2,  Addr[2] = 10 % 4 = 2;
  // Idx[2] = 2 / 1 = 2.
  //
  // You may need -instcombine to clean-up duplicated arithmetic operations.
  for (unsigned i = 0; i < ArrSizes.size() - 1; i++) {
    Value *Idx = BinaryOperator::Create(
        BinaryOperator::BinaryOps::UDiv, Addr, ArrSizes[i],
        "gep" + Twine(NumNewGEP) + "idx" + Twine(i), GEP);
    IdxList.push_back(Idx);

    Addr = BinaryOperator::Create(
        BinaryOperator::BinaryOps::URem, Addr, ArrSizes[i],
        "gep" + Twine(NumNewGEP) + "addr" + Twine(i + 1), GEP);
  }
  IdxList.push_back(Addr);

  GetElementPtrInst *NewGEP = GetElementPtrInst::CreateInBounds(
      RankedArrayPtr->getType()->getScalarType()->getPointerElementType(), RankedArrayPtr, IdxList, "gep" + Twine(NumNewGEP++), GEP->getNextNode());

  return NewGEP;
}

static bool shouldSkipArgument(Value *arg) {
  return arg->use_empty() && arg->getType()->isPointerTy();
}

/// Clone F2 into a new function without duplicated parameters, and replace F1's
/// uses with the new function being created.
static Function *replaceFunction(Function *F1, Function *F2) {
  // Create the new function interface.
  SmallVector<Type *, 4> ParamTypes;
  FunctionType *FuncType = F2->getFunctionType();
  // Skip no-use args, i.e., original pointers.
  for (unsigned i = 0; i < FuncType->getFunctionNumParams(); ++i)
    if (!shouldSkipArgument(F2->getArg(i)))
      ParamTypes.push_back(FuncType->getFunctionParamType(i));

  FunctionType *NewFuncType =
      FunctionType::get(F2->getReturnType(), ParamTypes, F2->isVarArg());

  // Build a trimmed copy of the F2 interface, using the same name as F1, and
  // erase F1. After this step, we have a clean state F1 with the updated
  // argument types.
  std::string Name = F1->getName().str();
  F1->setName(Name + Twine(".origin"));
  Function *NewFunc =
      Function::Create(NewFuncType, F2->getLinkage(), F2->getAddressSpace(),
                       Name, F2->getParent());

  // Create a mapping from the original parameter list to the new one.
  DenseMap<unsigned, unsigned> ArgMap;
  unsigned NumArgs = 0;
  FunctionType *F1Type = F1->getFunctionType();
  // First gather those unaffected indices.
  for (unsigned i = 0; i < F1Type->getFunctionNumParams(); ++i)
    if (!shouldSkipArgument(F2->getArg(i)))
      ArgMap[NumArgs++] = i;
  // Then put every other indices at the end.
  for (unsigned i = 0; i < F1Type->getFunctionNumParams(); ++i)
    if (shouldSkipArgument(F2->getArg(i)))
      ArgMap[NumArgs++] = i;

  // Prepare parameter mapping for cloning. Note that we also skip no-use
  // argument here.
  ValueToValueMapTy VMap;
  unsigned argIdx = 0;
  for (unsigned i = 0; i < F2->arg_size(); i++) {
    if (!shouldSkipArgument(F2->getArg(i)))
      VMap[F2->getArg(i)] = NewFunc->getArg(argIdx++);
    else // CloneFunctionInto requires every F2 arg exists as a VMap key.
      VMap[F2->getArg(i)] = UndefValue::get(F2->getArg(i)->getType());
  }

  // Clone.
  SmallVector<ReturnInst *, 4> Returns;
  llvm::CloneFunctionInto(NewFunc, F2, VMap,
                          CloneFunctionChangeType::LocalChangesOnly, Returns);

  return NewFunc;
}

static SmallVector<Function *> TopologicalSort(ArrayRef<Function *> funcs) {
  SmallPtrSet<Function *, 4> Avail{funcs.begin(), funcs.end()};

  DenseMap<Function *, SmallPtrSet<Function *, 4>> graph;
  for (Function *F : funcs)
    graph[F] = {};

  for (Function *F : funcs)
    for (BasicBlock &BB : F->getBasicBlockList())
      for (Instruction &I : BB)
        if (isa<CallInst>(I) &&
            Avail.count(cast<CallInst>(I).getCalledFunction()))
          graph[F].insert(cast<CallInst>(I).getCalledFunction());

  SmallVector<Function *> sorted;
  while (true) {
    SmallPtrSet<Function *, 4> to_remove;
    for (auto &it : graph)
      if (it.second.empty())
        to_remove.insert(it.first);

    for (Function *F : to_remove) {
      graph.erase(graph.find(F));
      sorted.push_back(F);
    }

    for (auto &it : graph)
      for (Function *F : to_remove)
        it.second.erase(F);

    if (to_remove.empty())
      break;
  }

  assert(sorted.size() == funcs.size() &&
         "The input list of functions cannot form an acyclic graph.");

  return sorted;
}

/// See the doc from rewriteModuloGepIndices.
static Value *rewriteModulo(Value *value) {
  SelectInst *selectInst = dyn_cast<SelectInst>(value);
  if (!selectInst)
    return nullptr;

  ICmpInst *icmpInst = dyn_cast<ICmpInst>(selectInst->getCondition());
  if (!icmpInst)
    return nullptr;

  BinaryOperator *addInst =
      dyn_cast<BinaryOperator>(selectInst->getTrueValue());
  if (!addInst || addInst->getOpcode() != BinaryOperator::Add)
    return nullptr;

  BinaryOperator *sremInst =
      dyn_cast<BinaryOperator>(selectInst->getFalseValue());
  if (!sremInst || sremInst->getOpcode() != BinaryOperator::SRem)
    return nullptr;

  // Now the pattern has been matched, do the rewrite.
  selectInst->replaceAllUsesWith(sremInst);

  // Clean up
  selectInst->eraseFromParent();
  addInst->eraseFromParent();
  icmpInst->eraseFromParent();

  return sremInst;
}

static bool isValidGepIndex(Value *value) {
  return isa<SelectInst, PHINode, ConstantInt, Argument>(value);
}

/// We trace the address calculation (mul and add) chain for the GEP index.
///
/// It would looks like (from heat-3d) -
///
///     %val_9 = mul i64 %val_3, 400
///     %val_10 = add i64 %val_9, 400 <-----  Add the offset value of 400
///     %val_11 = mul i64 %val_5, 20
///     %val_12 = add i64 %val_10, %val_11
///     %val_13 = add i64 %val_12, %val_7
///
/// Without offset
///
///     %val_20 = mul i64 %val_3, 400
///     %val_21 = mul i64 %val_5, 20
///     %val_22 = add i64 %val_20, %val_21
///     %val_23 = add i64 %val_22, %val_7
///
/// We cannot recover the indices when there is an offset at present.
/// It will return all the found indices.
/// The provided type argument is to verify the extracted information.
static SmallVector<Value *> getGepIndices(GetElementPtrInst *inst, Type *type) {
  LLVM_DEBUG({
    dbgs() << "Recognizing GEP indices from ";
    inst->dump();
    dbgs() << "\n";
    dbgs() << "Using type: ";
    type->dump();
    dbgs() << "\n\n";
  });

  if (inst->getNumIndices() != 1) {
    LLVM_DEBUG(dbgs() << "Given GEP has 0 or more than 1 indices.");
    return {};
  }
  ArrayType *arrayType = cast<ArrayType>(type->getPointerElementType());
  SmallVector<int64_t> dims = getDimsFromArrayType(arrayType);

  SmallVector<Value *> operands;
  // Will use this to check with the ranked array type.
  SmallVector<int64_t> mulDims;

  // First of all, all the adders will be connected by their LHS operator.
  // If the input is already an index.
  if (isValidGepIndex(*inst->idx_begin())) {
    operands.push_back(*inst->idx_begin());
  } else {
    SmallVector<BinaryOperator *> addInsts;
    BinaryOperator *addInst = dyn_cast<BinaryOperator>(*inst->idx_begin());
    while (addInst && addInst->getOpcode() == BinaryOperator::Add) {
      addInsts.push_back(addInst);
      addInst = dyn_cast<BinaryOperator>(addInst->getOperand(0));
      if (addInsts.size() == dims.size())
        break;
    }

    LLVM_DEBUG({
      dbgs() << "Recognized adders:\n";
      for (BinaryOperator *op : addInsts)
        op->dump();
      dbgs() << "\n\n";
    });

    for (unsigned i = 0; i < addInsts.size(); ++i) {
      if (i == addInsts.size() - 1)
        operands.push_back(addInsts[i]->getOperand(0));
      operands.push_back(addInsts[i]->getOperand(1));
    }

    LLVM_DEBUG({
      dbgs() << "Adder operands:\n";
      for (Value *operand : operands)
        operand->dump();
      dbgs() << "\n\n";
    });

    // Replace operand with multipliers.
    for (unsigned i = 0; i < operands.size(); ++i) {
      BinaryOperator *mulInst = dyn_cast<BinaryOperator>(operands[i]);
      if (!mulInst || mulInst->getOpcode() != BinaryOperator::Mul)
        continue;
      if (!isa<ConstantInt>(mulInst->getOperand(1))) {
        LLVM_DEBUG({
          dbgs() << "The RHS of a multiplied index is not a constant integer.";
          mulInst->dump();
        });
        return {};
      }

      mulDims.push_back(getI64Value(mulInst->getOperand(1)));
      operands[i] = mulInst->getOperand(0);
    }
  }

  LLVM_DEBUG({
    dbgs() << "Updated operands by mul:\n";
    for (Value *operand : operands)
      operand->dump();
    dbgs() << "\n\n";
  });

  // Check if every operand can be a valid GEP index.
  for (Value *operand : operands) {
    if (!isValidGepIndex(operand)) {
      LLVM_DEBUG({
        dbgs() << "Found an invalid operand:";
        operand->dump();
      });
      return {};
    }
  }

  // Finally, check whether the type matches with the parsed results.
  if (dims.size() != operands.size()) {
    LLVM_DEBUG({
      dbgs() << "Number of dims from the type: " << dims.size()
             << " doesn't match the number of operands: " << operands.size()
             << "\n";
    });
    return {};
  }

  SmallVector<int64_t> parDims;
  for (unsigned i = 1; i < dims.size(); ++i)
    parDims.push_back(dims[i] * (parDims.empty() ? 1 : parDims.back()));

  LLVM_DEBUG({
    dbgs() << "Partial dims resolved from type: ";
    interleaveComma(parDims, dbgs());
    dbgs() << "\nPartial dims resolved from multipliers: ";
    interleaveComma(mulDims, dbgs());
    dbgs() << "\n";
  });

  if (parDims != mulDims) {
    LLVM_DEBUG(dbgs() << "Partial dims don't match.\n");
    return {};
  }

  std::reverse(operands.begin(), operands.end());

  return operands;
}

/// Look at the indices passed to the given GEP and see if there is any chance
/// we can make the modulo expressions simplier given that the address of GEP
/// should be positive.
///
/// For example, transform:
///      %0 = srem i64 %arg, 32
///      %1 = icmp slt i64 %0, 0
///      %2 = add i64 %0, 32
///      %3 = select i1 %1, i64 %2, i64 %0
///
/// to:
///      %0 = srem i64 %arg, 32
///
static void rewriteModuloGepIndices(SmallVectorImpl<Value *> &indices) {
  LLVM_DEBUG(dbgs() << "Rewriting modulo gep indices.\n");
  for (unsigned i = 0; i < indices.size(); ++i)
    if (isa<SelectInst>(indices[i])) {
      Value *newInd = rewriteModulo(indices[i]);
      if (!newInd) {
        LLVM_DEBUG({
          dbgs() << "Failed to rewrite index at " << i << " : ";
          indices[i]->dump();
        });
        continue;
      }

      LLVM_DEBUG({
        dbgs() << "Rewritten index at " << i << " to ";
        newInd->dump();
      });
      indices[i] = newInd;
    }
}

/// This helper function convert the MemRef value represented by an
/// aggregated type to a ranked N-d array. The function interface, as well
/// as the internal usage of GEP will be updated.
///
/// The overall workflow is:
/// 1. Gather insertvalue/extractvalue sequences that identify aggregated
/// MemRef types.
/// 2. Duplicate the original function with extra ranked array types.
/// 3. Replace GEPs in the duplicated function.
/// 4. Clone the content back from the duplicated one. Clean up.
///
/// If ranked is passed as false, this function stops at step 1.
///
static void convertMemRefToArray(Module &M, bool ranked = false) {
  DenseMap<Function *, SmallVector<InsExtSequence, 4>> FuncToSeqs;

  /// First, we gather the mapping from Functions to all the InsExtSequences
  /// that they should rewrite on.
  for (auto &F : M) {
    SmallVector<InsExtSequence, 4> Seqs;
    findInsertExractValueSequences(F, Seqs);

    if (Seqs.empty())
      continue;

    FuncToSeqs[&F] = Seqs;

    // Clean up the sequences in the current function in reversed order.
    std::reverse(Seqs.begin(), Seqs.end());
    for (InsExtSequence &Seq : Seqs)
      Seq.eraseAllInsts();
  }

  // If it is ok to keep the array unranked, we can just return.
  if (!ranked)
    return;

  // Topological sort the functions.
  SmallVector<Function *, 4> Funcs;
  for (auto &it : FuncToSeqs)
    Funcs.push_back(it.first);
  Funcs = TopologicalSort(Funcs);

  // Map to the new version.
  DenseMap<Function *, Function *> FuncToNew;

  // Next, we iterate these Function, Sequence pairs and create new
  // candidate functions. The new function at this stage looks almost the
  // same as the original one, just have additional arguments that are
  // ranked arrays.
  for (Function *F : Funcs) {
    LLVM_DEBUG({
      dbgs() << "\nTransforming function:  \n\n";
      F->dump();
    });
    ValueToValueMapTy RankedArrVMap;
    auto &Seqs = FuncToSeqs[F];

    // -----------------------------------------------------------------
    // Step 1: create a rank-duplicated interface.
    Function *NewFunc =
        duplicateFunctionsWithRankedArrays(F, Seqs, RankedArrVMap);
    LLVM_DEBUG({
      dbgs() << "\nDuplicated function:  \n\n";
      NewFunc->dump();
    });

    // -----------------------------------------------------------------
    // Step 2: update the GEP expressions.
    SmallVector<Instruction *, 4> GEPList;
    for (BasicBlock &BB : *NewFunc)
      for (Instruction &I : BB)
        if (isa<GetElementPtrInst>(&I) && isa<Argument>(I.getOperand(0)))
          GEPList.push_back(&I);

    // Create new GEPs that use the ranked arrays and remove the old ones.
    unsigned NumNewGEP = 0;
    for (Instruction *I : GEPList) {
      // Simplify the address calculation expressions to make Vitis happy.
      // It is easier to work on the original GEP.
      SmallVector<Value *> indices =
          getGepIndices(cast<GetElementPtrInst>(I),
                        RankedArrVMap[I->getOperand(0)]->getType());

      Instruction *NewGEP;
      if (indices.empty()) {
        NewGEP = duplicateGEPWithRankedArray(I, RankedArrVMap, NumNewGEP);
      } else {
        // We will directly use the resolved indices.
        // Try to rewrite the modulo expressions.
        rewriteModuloGepIndices(indices);

        LLVM_DEBUG({
          dbgs() << "Indices to use: \n";
          for (Value *index : indices)
            index->dump();
        });

        // We can directly use the indices from the rewrite to get the new GEP.
        /// TODO: should be more careful.
        Value *ptr = RankedArrVMap[I->getOperand(0)];
        assert(ptr);

        indices.push_back(ConstantInt::get(indices.front()->getType(), 0));
        std::reverse(indices.begin(), indices.end());

        NewGEP = GetElementPtrInst::CreateInBounds(ptr->getType()->getScalarType()->getPointerElementType(), ptr, indices, Twine(""),
                                                   I->getNextNode());
        LLVM_DEBUG({
          dbgs() << "Newly generated GEP: ";
          NewGEP->dump();
        });
      }

      I->replaceAllUsesWith(NewGEP);
      I->eraseFromParent();
    }

    LLVM_DEBUG({
      dbgs() << "\nGEP updated function: \n\n";
      NewFunc->dump();
    });

    // -----------------------------------------------------------------
    // Step 3: update callers within the new function.
    // If there is any caller.
    SmallVector<CallInst *> Callers;
    for (BasicBlock &BB : *NewFunc)
      for (Instruction &I : BB)
        if (CallInst *CI = dyn_cast<CallInst>(&I))
          if (FuncToNew.count(CI->getCalledFunction()))
            Callers.push_back(CI);

    for (CallInst *Caller : Callers) {
      Function *Callee = Caller->getCalledFunction();

      LLVM_DEBUG(dbgs() << "The new callee: " << *FuncToNew[Callee] << '\n');

      // Initial arguments.
      SmallVector<Value *> Args;
      unsigned NumArg = 0;
      for (Value *Arg : Caller->args())
        if (Arg->getType() == FuncToNew[Callee]->getArg(NumArg)->getType()) {
          Args.push_back(Arg);
          NumArg++;
        }

      // Duplicated arguments (new memref).
      SmallVector<Instruction *> toErase;
      for (Value *Arg : Caller->args()) {
        // If it is a newly mapped memref argument -
        if (RankedArrVMap.count(Arg))
          Args.push_back(RankedArrVMap[Arg]);
        else if (isa<BitCastInst>(Arg)) {
          LLVM_DEBUG({
            dbgs() << "Found ";
            Arg->dump();
            dbgs() << " as a result from bitcast. Need to transform it into "
                      "the multi-dimensional type.\n";
          });

          BitCastInst *bitCastInst = cast<BitCastInst>(Arg);

          // ------------------------------------------------
          // Here are two cases:
          if (!isa<GetElementPtrInst>(bitCastInst->getOperand(0))) {
            /// TODO: perform additional checking.
            // 1. There is a single bitcast.
            // Here we simply replace the cast target from the original type to
            // what the new callee expects.
            Type *newCastType =
                FuncToNew[Callee]->getArg(Args.size())->getType();
            BitCastInst *newBitCastInst = new BitCastInst(
                bitCastInst->getOperand(0), newCastType, "", bitCastInst);
            Args.push_back(newBitCastInst);
            toErase.push_back(bitCastInst);

          } else {
            // 2. There is a bitcast expression chain.
            // This chain is based on the instructions generated by the
            // processOffset function.
            /// TODO:  can we make this a pattern?
            GetElementPtrInst *gep =
                cast<GetElementPtrInst>(bitCastInst->getOperand(0));
            LoadInst *loadInst = cast<LoadInst>(gep->getOperand(0));
            BitCastInst *src = cast<BitCastInst>(loadInst->getOperand(0));

            // Now we should replace these instructions by a single GEP.
            // This GEP directly calculates the address from the input ranked
            // array pointer.
            Value *newArg = RankedArrVMap[src->getOperand(0)];
            SmallVector<Value *> indices;
            // Start with 0.
            indices.push_back(
                ConstantInt::get((*gep->idx_begin())->getType(), 0));
            // Borrow the indices from the original GEP.
            for (Value *val : gep->indices())
              indices.push_back(val);
            // Construct the new GEP.
            GetElementPtrInst *newGEP = GetElementPtrInst::Create(
                cast<Type>(newArg->getType())->getPointerElementType(), newArg,
                indices, Twine(""),
                cast<Instruction>(bitCastInst->getNextNode()));

            // The result from this newGEP will be the new argument, i.e., the
            // subview pointer.
            Args.push_back(newGEP);

            // Prepare what to erase in the end. They should be in the reversed
            // order.
            toErase.append({bitCastInst, gep, loadInst, src});
          }
        }
      }

      LLVM_DEBUG({
        dbgs() << "Creating caller for " << FuncToNew[Callee]->getName()
               << ", signature: ";
        FuncToNew[Callee]->getFunctionType()->dump();
        dbgs() << "-----------------------\n\n";
        dbgs() << "Argument list:\n";
        for (auto arg : enumerate(Args)) {
          dbgs() << arg.index() << "\t-> ";
          arg.value()->dump();
        }
        dbgs() << "\nArgument types:\n";
        for (auto arg : enumerate(Args)) {
          dbgs() << arg.index() << "\t-> ";
          arg.value()->getType()->dump();
          dbgs() << "\t-> ";
          FuncToNew[Callee]->getArg(arg.index())->getType()->dump();
        }
      });

      // New caller.
      CallInst::Create(FuncToNew[Callee], Args, Twine(), Caller);
      // Erase the original caller.
      Caller->eraseFromParent();
      for (Instruction *inst : toErase)
        if (inst->getNumUses() == 0)
          inst->eraseFromParent();
    }

    FuncToNew[F] = replaceFunction(F, NewFunc);
    FuncToNew[F]->addFnAttr(Attribute::NoInline);

    // Finally, delete the duplicate.
    NewFunc->eraseFromParent();
  }

  // Erase the original functions backward.
  std::reverse(Funcs.begin(), Funcs.end());
  for (Function *F : Funcs)
    F->eraseFromParent();
}

namespace {

/// Fix the case that a caller that should take the pointer extracted from the
/// subview takes from the original memref instead.
struct MemRefSubview : public ModulePass {
  static char ID;
  MemRefSubview() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    for (Function &F : M) {
      for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
          if (CallInst *caller = dyn_cast<CallInst>(&I)) {
            Function *callee = caller->getCalledFunction();
            if (!callee)
              continue;

            // There should be a PE substring in the target function name. Might
            // be too hacky.
            auto name = callee->getName();
            if (name.find("PE") == StringRef::npos)
              continue;

            for (unsigned i = 0; i < caller->getNumOperands(); ++i) {
              Value *operand = caller->getOperand(i);
              // The target operand should be a pointer.
              if (!operand->getType()->isPointerTy())
                continue;

              // Won't work with those not defined by extractvalue.
              ExtractValueInst *extInst = dyn_cast<ExtractValueInst>(operand);
              if (!extInst)
                continue;

              // Find the latest before the caller.
              InsertValueInst *src = nullptr;
              for (auto it = extInst->user_begin(); it != extInst->user_end();
                   ++it) {
                if (InsertValueInst *insInst = dyn_cast<InsertValueInst>(*it)) {
                  if (insInst->comesBefore(caller) &&
                      (!src || src->comesBefore(insInst)))
                    src = insInst;
                }
              }

              if (!src)
                continue;

              // Go to the last insertvalue.
              // insertvalue is NORMALLY a chain of single uses.
              InsertValueInst *inst = src;
              while (inst->getNumUses() == 1 &&
                     isa<InsertValueInst>(*inst->user_begin()))
                inst = dyn_cast<InsertValueInst>(*inst->user_begin());
              assert(isa<InsertValueInst>(inst));

              // Now we can create the new extractvalue inst.
              Value *newPtr =
                  ExtractValueInst::Create(inst, {1}, Twine(), caller);
              caller->setOperand(i, newPtr);
            }
          }
        }
      }
    }

    return false;
  }
};
} // namespace

namespace {
struct ConvertMemRefToArray : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  ConvertMemRefToArray() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    convertMemRefToArray(M);

    return false;
  }
};
} // namespace

namespace {

struct ConvertMemRefToRankedArray : public ModulePass {
  static char ID; // Pass identification, replacement for typeid
  ConvertMemRefToRankedArray() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    convertMemRefToArray(M, /*ranked=*/true);

    return false;
  }
};

} // namespace

static void replaceOperandBy(Instruction *inst, Value *from, Value *to) {
  for (unsigned i = 0; i < inst->getNumOperands(); ++i) {
    if (inst->getOperand(i) == from) {
      LLVM_DEBUG(dbgs() << "Replacing " << (*from) << "\n with \n"
                        << (*to) << '\n');
      inst->setOperand(i, to);
      return;
    }
  }
}

/// Replace the use of source in inst by the true value and the false value, and
/// the propagate down to  all the uses of inst.
static void replaceUses(Instruction *inst, Value *source, Value *trueValue,
                        Value *falseValue, Value *cond) {
  LLVM_DEBUG({
    dbgs() << "\n-------------------------\n";
    dbgs() << " Replacing ... \n";
    inst->dump();
    dbgs() << "\nSource: " << (*source);
    dbgs() << "\nTrue:   " << (*trueValue);
    dbgs() << "\nFalse:  " << (*falseValue);
    dbgs() << "\n-------------------------- \n";
  });

  // Base case.
  if (isa<LoadInst>(source)) {
    SelectInst *selectInst =
        SelectInst::Create(cond, trueValue, falseValue, Twine(), inst);
    replaceOperandBy(inst, source, selectInst);

    return;
  }

  Instruction *falseInst = inst->clone();
  falseInst->insertBefore(inst);
  LLVM_DEBUG(dbgs() << "False inst: " << (*falseInst) << "\n");

  replaceOperandBy(inst, source, trueValue);
  replaceOperandBy(falseInst, source, falseValue);

  for (Value *user : inst->users())
    replaceUses(cast<Instruction>(user), inst, inst, falseInst, cond);
}

namespace {
struct SelectPointer : public ModulePass {
  static char ID;
  SelectPointer() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    // Find select instructions on insertvalue.
    SmallVector<SelectInst *> selectInsts;
    for (Function &F : M) {
      for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
          if (auto selectInst = dyn_cast<SelectInst>(&I)) {
            if (isa<InsertValueInst>(selectInst->getTrueValue()))
              selectInsts.push_back(selectInst);
          }
        }
      }
    }

    for (SelectInst *selectInst : selectInsts) {
      LLVM_DEBUG(dbgs() << "Handling " << (*selectInst) << '\n');
      Value *trueValue = selectInst->getTrueValue();
      Value *falseValue = selectInst->getFalseValue();

      for (Value *user : selectInst->users())
        replaceUses(cast<Instruction>(user), selectInst, trueValue, falseValue,
                    selectInst->getCondition());

      selectInst->eraseFromParent();
    }

    selectInsts.clear();
    for (Function &F : M) {
      for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
          if (auto selectInst = dyn_cast<SelectInst>(&I)) {
            if (isa<InsertValueInst>(selectInst->getTrueValue()))
              selectInsts.push_back(selectInst);
          }
        }
      }
    }

    for (SelectInst *selectInst : selectInsts)
      selectInst->eraseFromParent();

    return false;
  }
};
} // namespace

char ConvertMemRefToArray::ID = 0;
static RegisterPass<ConvertMemRefToArray>
    X1("mem2ptr",
       "Convert MemRef structure to unranked array, i.e., raw pointer.");

char ConvertMemRefToRankedArray::ID = 1;
static RegisterPass<ConvertMemRefToRankedArray>
    X2("mem2arr", "Convert MemRef structure to ranked array.");

char MemRefSubview::ID = 12;
static RegisterPass<MemRefSubview> X3("subview",
                                      "Fix various subview related issues.");

char SelectPointer::ID = 13;
static RegisterPass<SelectPointer> X4("select-pointer",
                                      "Select pointer instead of struct.");