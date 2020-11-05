//===- SODADialect.cpp - MLIR Dialect for SODA Kernels implementation -----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA kernel-related dialect and its operations.
//
// It was strongly inspired by the GPU dialect.
//
//===----------------------------------------------------------------------===//

#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/FunctionImplementation.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/StandardTypes.h"
#include "llvm/ADT/TypeSwitch.h"

using namespace mlir;
using namespace mlir::soda;

//===----------------------------------------------------------------------===//
// SODADialect
//===----------------------------------------------------------------------===//

bool SODADialect::isKernel(Operation *op) {
  UnitAttr isKernelAttr = op->getAttrOfType<UnitAttr>(getKernelFuncAttrName());
  return static_cast<bool>(isKernelAttr);
}

void SODADialect::initialize() {
  addTypes<AsyncTokenType>();
  addOperations<
#define GET_OP_LIST
#include "soda/Dialect/SODA/SODAOps.cpp.inc"
      >();
}

Type SODADialect::parseType(DialectAsmParser &parser) const {
  StringRef keyword;
  if (parser.parseKeyword(&keyword))
    return Type();
  MLIRContext *context = getContext();

  // Handle `async token` types.
  if (keyword == "async.token")
    return AsyncTokenType::get(context);

  parser.emitError(parser.getNameLoc(), "unknown soda target type " + keyword);
  return Type();
}

void SODADialect::printType(Type type, DialectAsmPrinter &os) const {
  TypeSwitch<Type>(type)
      .Case<AsyncTokenType>([&](Type) { os << "async.token"; })
      .Default([](Type) { llvm_unreachable("unexpected 'soda' type kind"); });
}

LogicalResult SODADialect::verifyOperationAttribute(Operation *op,
                                                    NamedAttribute attr) {
  if (!attr.second.isa<UnitAttr>() ||
      attr.first != getContainerModuleAttrName())
    return success();

  auto module = dyn_cast<ModuleOp>(op);
  if (!module)
    return op->emitError("expected '")
           << getContainerModuleAttrName() << "' attribute to be attached to '"
           << ModuleOp::getOperationName() << '\'';

  auto walkResult = module.walk([&module](LaunchFuncOp launchOp) -> WalkResult {
    // Ignore launches that are nested more or less deep than functions in the
    // module we are currently checking.
    if (!launchOp.getParentOp() ||
        launchOp.getParentOp()->getParentOp() != module)
      return success();

    // Ignore launch ops with missing attributes here. The errors will be
    // reported by the verifiers of those ops.
    if (!launchOp.getAttrOfType<SymbolRefAttr>(
            LaunchFuncOp::getKernelAttrName()))
      return success();

    // Check that `launch_func` refers to a well-formed SODA kernel module.
    StringRef kernelModuleName = launchOp.getKernelModuleName();
    auto kernelModule = module.lookupSymbol<SODAModuleOp>(kernelModuleName);
    if (!kernelModule)
      return launchOp.emitOpError()
             << "kernel module '" << kernelModuleName << "' is undefined";

    // Check that `launch_func` refers to a well-formed kernel function.
    Operation *kernelFunc = module.lookupSymbol(launchOp.kernel());
    auto kernelSODAFunction = dyn_cast_or_null<soda::SODAFuncOp>(kernelFunc);
    auto kernelLLVMFunction = dyn_cast_or_null<LLVM::LLVMFuncOp>(kernelFunc);
    if (!kernelSODAFunction && !kernelLLVMFunction)
      return launchOp.emitOpError("kernel function '")
             << launchOp.kernel() << "' is undefined";
    if (!kernelFunc->getAttrOfType<mlir::UnitAttr>(
            SODADialect::getKernelFuncAttrName()))
      return launchOp.emitOpError("kernel function is missing the '")
             << SODADialect::getKernelFuncAttrName() << "' attribute";

    // TODO: if the kernel function has been converted to
    // the LLVM dialect but the caller hasn't (which happens during the
    // separate compilation), do not check type correspondence as it would
    // require the verifier to be aware of the LLVM type conversion.
    if (kernelLLVMFunction)
      return success();

    unsigned actualNumArguments = launchOp.getNumKernelOperands();
    unsigned expectedNumArguments = kernelSODAFunction.getNumArguments();
    if (expectedNumArguments != actualNumArguments)
      return launchOp.emitOpError("got ")
             << actualNumArguments << " kernel operands but expected "
             << expectedNumArguments;

    auto functionType = kernelSODAFunction.getType();
    for (unsigned i = 0; i < expectedNumArguments; ++i) {
      if (launchOp.getKernelOperand(i).getType() != functionType.getInput(i)) {
        return launchOp.emitOpError("type of function argument ")
               << i << " does not match";
      }
    }

    return success();
  });

  return walkResult.wasInterrupted() ? failure() : success();
}

template <typename T>
static LogicalResult verifyIndexOp(T op) {
  auto dimension = op.dimension();
  if (dimension != "x" && dimension != "y" && dimension != "z")
    return op.emitError("dimension \"") << dimension << "\" is invalid";
  return success();
}

static LogicalResult verifyShuffleOp(soda::ShuffleOp shuffleOp) {
  auto type = shuffleOp.value().getType();
  if (shuffleOp.result().getType() != type) {
    return shuffleOp.emitOpError()
           << "requires the same type for value operand and result";
  }
  if (!type.isSignlessIntOrFloat() || type.getIntOrFloatBitWidth() != 32) {
    return shuffleOp.emitOpError()
           << "requires value operand type to be f32 or i32";
  }
  return success();
}

static void printShuffleOp(OpAsmPrinter &p, ShuffleOp op) {
  p << ShuffleOp::getOperationName() << ' ' << op.getOperands() << ' '
    << op.mode() << " : " << op.value().getType();
}

static ParseResult parseShuffleOp(OpAsmParser &parser, OperationState &state) {
  SmallVector<OpAsmParser::OperandType, 3> operandInfo;
  if (parser.parseOperandList(operandInfo, 3))
    return failure();

  StringRef mode;
  if (parser.parseKeyword(&mode))
    return failure();
  state.addAttribute("mode", parser.getBuilder().getStringAttr(mode));

  Type valueType;
  Type int32Type = parser.getBuilder().getIntegerType(32);
  Type int1Type = parser.getBuilder().getI1Type();
  if (parser.parseColonType(valueType) ||
      parser.resolveOperands(operandInfo, {valueType, int32Type, int32Type},
                             parser.getCurrentLocation(), state.operands) ||
      parser.addTypesToList({valueType, int1Type}, state.types))
    return failure();
  return success();
}

//===----------------------------------------------------------------------===//
// AsyncOpInterface
//===----------------------------------------------------------------------===//

void soda::addAsyncDependency(Operation *op, Value token) {
  op->insertOperands(0, {token});
  if (!op->template hasTrait<OpTrait::AttrSizedOperandSegments>())
    return;
  auto attrName =
      OpTrait::AttrSizedOperandSegments<void>::getOperandSegmentSizeAttr();
  auto sizeAttr = op->template getAttrOfType<DenseIntElementsAttr>(attrName);
  if (!sizeAttr)
    return; // Async deps is the only variadic operand.
  SmallVector<int32_t, 8> sizes;
  for (auto size : sizeAttr.getIntValues())
    sizes.push_back(size.getSExtValue());
  ++sizes.front();
  op->setAttr(attrName, Builder(op->getContext()).getI32VectorAttr(sizes));
}

//===----------------------------------------------------------------------===//
// LaunchOp
//===----------------------------------------------------------------------===//

// TODO(NICO): remove gpu meta information
void LaunchOp::build(OpBuilder &builder, OperationState &result,
                     Value gridSizeX, Value gridSizeY, Value gridSizeZ,
                     Value blockSizeX, Value blockSizeY, Value blockSizeZ) {

  // Add grid and block sizes as op operands, followed by the data operands.
  result.addOperands(
      {gridSizeX, gridSizeY, gridSizeZ, blockSizeX, blockSizeY, blockSizeZ});

  // TODO(NICO): modify kNumConfigRegionAttributes
  // Create a kernel body region with kNumConfigRegionAttributes + N arguments,
  // where the first kNumConfigRegionAttributes arguments have `index` type and
  // the rest have the same types as the data operands.
  Region *kernelRegion = result.addRegion();
  Block *body = new Block();
  body->addArguments(
      std::vector<Type>(kNumConfigRegionAttributes, builder.getIndexType()));
  kernelRegion->push_back(body);
}

// TODO(NICO): remove all these calls, from here
KernelDim3 LaunchOp::getBlockIds() {
  assert(!body().empty() && "LaunchOp body must not be empty.");
  auto args = body().getArguments();
  return KernelDim3{args[0], args[1], args[2]};
}

KernelDim3 LaunchOp::getThreadIds() {
  assert(!body().empty() && "LaunchOp body must not be empty.");
  auto args = body().getArguments();
  return KernelDim3{args[3], args[4], args[5]};
}

KernelDim3 LaunchOp::getGridSize() {
  assert(!body().empty() && "LaunchOp body must not be empty.");
  auto args = body().getArguments();
  return KernelDim3{args[6], args[7], args[8]};
}

KernelDim3 LaunchOp::getBlockSize() {
  assert(!body().empty() && "LaunchOp body must not be empty.");
  auto args = body().getArguments();
  return KernelDim3{args[9], args[10], args[11]};
}

KernelDim3 LaunchOp::getGridSizeOperandValues() {
  return KernelDim3{getOperand(0), getOperand(1), getOperand(2)};
}

KernelDim3 LaunchOp::getBlockSizeOperandValues() {
  return KernelDim3{getOperand(3), getOperand(4), getOperand(5)};
}
// TODO(NICO): remove all these calls, until here

// TODO(NICO) modify to suport other kind of arguments/attributes
static LogicalResult verify(LaunchOp op) {
  // Kernel launch takes KNumConfigOperands leading operands for grid/block
  // sizes and transforms them into kNumConfigRegionAttributes region arguments
  // for block/thread identifiers and grid/block sizes.
  if (!op.body().empty()) {
    if (op.body().getNumArguments() !=
        LaunchOp::kNumConfigOperands + op.getNumOperands())
      return op.emitOpError("unexpected number of region arguments");
  }

  // Block terminators without successors are expected to exit the kernel region
  // and must be `soda.terminal`.
  for (Block &block : op.body()) {
    if (block.empty())
      continue;
    if (block.back().getNumSuccessors() != 0)
      continue;
    if (!isa<soda::TerminatorOp>(&block.back())) {
      return block.back()
          .emitError()
          .append("expected '", soda::TerminatorOp::getOperationName(),
                  "' or a terminator with successors")
          .attachNote(op.getLoc())
          .append("in '", LaunchOp::getOperationName(), "' body region");
    }
  }

  return success();
}

// TODO(NICO): Add implementations
// #include "soda/Dialect/SODA/SODAOpInterfaces.cpp.inc"

// #define GET_OP_CLASSES
// #include "soda/Dialect/SODA/SODAOps.cpp.inc"