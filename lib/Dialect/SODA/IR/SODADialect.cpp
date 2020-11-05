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

// TODO(NICO): Add implementations
// #include "soda/Dialect/SODA/SODAOpInterfaces.cpp.inc"

// #define GET_OP_CLASSES
// #include "soda/Dialect/SODA/SODAOps.cpp.inc"