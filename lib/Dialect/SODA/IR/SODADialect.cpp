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

#include <iostream>

#include "soda/Dialect/SODA/SODADialect.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/FunctionImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/TypeUtilities.h"
#include "llvm/ADT/TypeSwitch.h"

using namespace mlir;
using namespace mlir::soda;

#include "soda/Dialect/SODA/SODAOpsDialect.cpp.inc"

#include <iostream>

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
  if (!attr.getValue().isa<UnitAttr>() ||
      attr.getName() != getContainerModuleAttrName())
    return success();

  auto module = dyn_cast<ModuleOp>(op);
  if (!module)
    return op->emitError("expected '")
           << getContainerModuleAttrName() << "' attribute to be attached to '"
           << ModuleOp::getOperationName() << '\'';

  auto walkResult = module.walk([&module](LaunchFuncOp launchOp) -> WalkResult {
    // Ignore launches that are nested more or less deep than functions in the
    // module we are currently checking.
    if (!launchOp->getParentOp() ||
        launchOp->getParentOp()->getParentOp() != module)
      return success();

    // Ignore launch ops with missing attributes here. The errors will be
    // reported by the verifiers of those ops.
    if (!launchOp->getAttrOfType<SymbolRefAttr>(
            LaunchFuncOp::getKernelAttrName()))
      return success();

    // Check that `launch_func` refers to a well-formed SODA kernel module.
    StringAttr kernelModuleName = launchOp.getKernelModuleName();
    auto kernelModule = module.lookupSymbol<SODAModuleOp>(kernelModuleName);
    if (!kernelModule)
      return launchOp.emitOpError()
             << "kernel module '" << kernelModuleName.getValue()
             << "' is undefined";

    // Check that `launch_func` refers to a well-formed kernel function.
    Operation *kernelFunc = module.lookupSymbol(launchOp.kernelAttr());
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

    auto functionType = kernelSODAFunction.getFunctionType();
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

//===----------------------------------------------------------------------===//
// AsyncOpInterface
//===----------------------------------------------------------------------===//

void soda::addAsyncDependency(Operation *op, Value token) {
  op->insertOperands(0, {token});
  if (!op->template hasTrait<OpTrait::AttrSizedOperandSegments>())
    return;
  auto attrName =
      OpTrait::AttrSizedOperandSegments<void>::getOperandSegmentSizeAttr();
  auto sizeAttr = op->template getAttrOfType<DenseI32ArrayAttr>(attrName);

  // Async dependencies is the only variadic operand.
  if (!sizeAttr)
    return;

  SmallVector<int32_t, 8> sizes(sizeAttr.asArrayRef());
  ++sizes.front();
  op->setAttr(attrName, Builder(op->getContext()).getDenseI32ArrayAttr(sizes));
}

//===----------------------------------------------------------------------===//
// LaunchOp
//===----------------------------------------------------------------------===//

void LaunchOp::build(OpBuilder &builder, OperationState &result,
                     Type asyncTokenType, ValueRange asyncDependencies) {


  result.addOperands(asyncDependencies);
  if (asyncTokenType)
    result.types.push_back(builder.getType<AsyncTokenType>());

  // Add the data operands.

  // This is a good area to add static operands.

  // Create a kernel body region with kNumConfigRegionAttributes + N arguments,
  // where the first kNumConfigRegionAttributes arguments have `index` type and
  // the rest have the same types as the data operands.
  Region *kernelRegion = result.addRegion();
  Block *body = new Block();
  for (unsigned i = 0; i < kNumConfigRegionAttributes; ++i)
    body->addArgument(builder.getIndexType(), result.location);
  kernelRegion->push_back(body);
}

LogicalResult LaunchOp::verify() {
  //  Include this code if Kernel launch takes KNumConfigOperands leading
  //  operands for grid/block sizes and transforms them into
  //  kNumConfigRegionAttributes region arguments for block/thread identifiers
  //  and grid/block sizes.
  // if (!op.body().empty()) {
  //   if (op.body().getNumArguments() !=
  //       LaunchOp::kNumConfigOperands + op.getNumOperands())
  //     return op.emitOpError("unexpected number of region arguments");
  // }

  // Block terminators without successors are expected to exit the kernel region
  // and must be `soda.terminator`.
  for (Block &block : body()) {
    if (block.empty())
      continue;
    if (block.back().getNumSuccessors() != 0)
      continue;
    if (!isa<soda::TerminatorOp>(&block.back())) {
      return block.back()
          .emitError()
          .append("expected '", soda::TerminatorOp::getOperationName(),
                  "' or a terminator with successors")
          .attachNote(getLoc())
          .append("in '", LaunchOp::getOperationName(), "' body region");
    }
  }

  return success();
}

void LaunchOp::print(OpAsmPrinter &p) {
  p << ' ';
  p.printRegion(body(), /*printEntryBlockArgs=*/false);
  p.printOptionalAttrDict((*this)->getAttrs());
}

// Parses a Launch operation.
// operation ::= `gpu.launch` region attr-dict?
// ssa-reassignment ::= `(` ssa-id `=` ssa-use (`,` ssa-id `=` ssa-use)* `)`
ParseResult LaunchOp::parse(OpAsmParser &parser, OperationState &result) {

  // Region arguments to be created.
  SmallVector<OpAsmParser::UnresolvedOperand, 16> regionArgs(
      LaunchOp::kNumConfigRegionAttributes);
  MutableArrayRef<OpAsmParser::UnresolvedOperand> regionArgsRef(regionArgs);

  // Introduce the body region and parse it. The region has
  // kNumConfigRegionAttributes arguments that correspond to
  // block/thread identifiers and grid/block sizes, all of the `index` type.
  Type index = parser.getBuilder().getIndexType();
  SmallVector<Type, LaunchOp::kNumConfigRegionAttributes> dataTypes(
      LaunchOp::kNumConfigRegionAttributes, index);

  SmallVector<OpAsmParser::Argument> regionArguments;
  for (auto ssaValueAndType : llvm::zip(regionArgs, dataTypes)) {
    OpAsmParser::Argument arg;
    arg.ssaName = std::get<0>(ssaValueAndType);
    arg.type = std::get<1>(ssaValueAndType);
    regionArguments.push_back(arg);
  }

  Region *body = result.addRegion();
  if (parser.parseRegion(*body, regionArguments) ||
      parser.parseOptionalAttrDict(result.attributes)) {
    return failure();
  }
  return success();
}

//===----------------------------------------------------------------------===//
// LaunchFuncOp
//===----------------------------------------------------------------------===//

void LaunchFuncOp::build(OpBuilder &builder, OperationState &result,
                         SODAFuncOp kernelFunc, ValueRange kernelOperands,
                         Type asyncTokenType,
                         ValueRange asyncDependencies) {
  // This is a good area to add static operands.

  // Async dependencies.
  result.addOperands(asyncDependencies);
  if (asyncTokenType)
    result.types.push_back(builder.getType<AsyncTokenType>());

  // Add the data operands.
  result.addOperands(kernelOperands);
  auto kernelModule = kernelFunc->getParentOfType<SODAModuleOp>();
  auto kernelSymbol =
      SymbolRefAttr::get(kernelModule.getNameAttr(),
                         {SymbolRefAttr::get(kernelFunc.getNameAttr())});
  result.addAttribute(getKernelAttrName(), kernelSymbol);
  SmallVector<int32_t, 2> segmentSizes(2, 1);
  segmentSizes.front() = asyncDependencies.size();
  segmentSizes.back() = static_cast<int32_t>(kernelOperands.size());
  result.addAttribute(getOperandSegmentSizeAttr(),
                      builder.getDenseI32ArrayAttr(segmentSizes));
}

unsigned LaunchFuncOp::getNumKernelOperands() { return operands().size(); }

StringAttr LaunchFuncOp::getKernelModuleName() {
  return kernel().getRootReference();
}

StringAttr LaunchFuncOp::getKernelName() { return kernel().getLeafReference(); }

Value LaunchFuncOp::getKernelOperand(unsigned i) {
  return getOperand(asyncDependencies().size() + kNumConfigOperands + i);
}

LogicalResult LaunchFuncOp::verify() {
  auto module = (*this)->getParentOfType<ModuleOp>();
  if (!module)
    return emitOpError("expected to belong to a module");

  if (!module->getAttrOfType<UnitAttr>(
          SODADialect::getContainerModuleAttrName()))
    return emitOpError("expected the closest surrounding module to have the '" +
                       SODADialect::getContainerModuleAttrName() +
                       "'attribute");

  auto kernelAttr = (*this)->getAttrOfType<SymbolRefAttr>(getKernelAttrName());
  if (!kernelAttr)
    return emitOpError("symbol reference attribute '" + getKernelAttrName() +
                       "' must be specified");

  return success();
}

static ParseResult parseLaunchFuncOperands(
    OpAsmParser &parser,
    SmallVectorImpl<OpAsmParser::UnresolvedOperand> &argNames,
    SmallVectorImpl<Type> &argTypes) {
  if (parser.parseOptionalKeyword("args"))
    return success();

  SmallVector<OpAsmParser::Argument> args;
  if (parser.parseArgumentList(args, OpAsmParser::Delimiter::Paren,
                               /*allowType=*/true))
    return failure();
  for (auto &arg : args) {
    argNames.push_back(arg.ssaName);
    argTypes.push_back(arg.type);
  }
  return success();
}

static void printLaunchFuncOperands(OpAsmPrinter &printer, Operation *,
                                    OperandRange operands, TypeRange types) {
  if (operands.empty())
    return;
  printer << "args(";
  llvm::interleaveComma(llvm::zip(operands, types), printer,
                        [&](const auto &pair) {
                          printer.printOperand(std::get<0>(pair));
                          printer << " : ";
                          printer.printType(std::get<1>(pair));
                        });
  printer << ")";
}


//===----------------------------------------------------------------------===//
// LaunchCGRAOp
//===----------------------------------------------------------------------===//

void LaunchCGRAOp::build(OpBuilder &builder, OperationState &result,
                         SODAFuncOp kernelFunc, ValueRange kernelOperands) {
  // This is a good area to add static operands.

  // Add the data operands.
  result.addOperands(kernelOperands);
  auto kernelModule = kernelFunc->getParentOfType<SODAModuleOp>();
  if (kernelModule == NULL)
    std::cout<<"kernelModule is NULL"<<std::endl;
  auto kernelSymbol =
      SymbolRefAttr::get(kernelModule.getNameAttr(),
                         {SymbolRefAttr::get(kernelFunc.getNameAttr())});
  result.addAttribute(getKernelAttrName(), kernelSymbol);
  SmallVector<int32_t, 2> segmentSizes(2, 1);
  segmentSizes.front() = 0; // Initially no async dependencies.
  segmentSizes.back() = static_cast<int32_t>(kernelOperands.size());
  result.addAttribute(getOperandSegmentSizeAttr(),
                      builder.getI32VectorAttr(segmentSizes));
}

unsigned LaunchCGRAOp::getNumKernelOperands() {
  return getNumOperands() - asyncDependencies().size() - kNumConfigOperands;
}

StringAttr LaunchCGRAOp::getKernelModuleName() {
  return kernel().getRootReference();
}

StringAttr LaunchCGRAOp::getKernelName() { return kernel().getLeafReference(); }

Value LaunchCGRAOp::getKernelOperand(unsigned i) {
  return getOperand(asyncDependencies().size() + kNumConfigOperands + i);
}

LogicalResult LaunchCGRAOp::verify() {
  auto module = (*this)->getParentOfType<ModuleOp>();
  if (!module)
    return emitOpError("expected to belong to a module");

  if (!module->getAttrOfType<UnitAttr>(
          SODADialect::getContainerModuleAttrName()))
    return emitOpError("expected the closest surrounding module to have the '" +
                       SODADialect::getContainerModuleAttrName() +
                       "'attribute");

  auto kernelAttr = (*this)->getAttrOfType<SymbolRefAttr>(getKernelAttrName());
  if (!kernelAttr)
    return emitOpError("symbol reference attribute '" + getKernelAttrName() +
                       "' must be specified");

  return success();
}

static ParseResult parseLaunchCGRAOperands(
    OpAsmParser &parser,
    SmallVectorImpl<OpAsmParser::UnresolvedOperand> &argNames,
    SmallVectorImpl<Type> &argTypes) {
  if (parser.parseOptionalKeyword("args"))
    return success();

  SmallVector<OpAsmParser::Argument> args;
  if (parser.parseArgumentList(args, OpAsmParser::Delimiter::Paren,
                               /*allowType=*/true))
    return failure();
  for (auto &arg : args) {
    argNames.push_back(arg.ssaName);
    argTypes.push_back(arg.type);
  }
  return success();
}

static void printLaunchCGRAOperands(OpAsmPrinter &printer, Operation *,
                                    OperandRange operands, TypeRange types) {
  if (operands.empty())
    return;
  printer << "args(";
  llvm::interleaveComma(llvm::zip(operands, types), printer,
                        [&](const auto &pair) {
                          printer.printOperand(std::get<0>(pair));
                          printer << " : ";
                          printer.printType(std::get<1>(pair));
                        });
  printer << ")";
}

//===----------------------------------------------------------------------===//
// SODAFuncOp
//===----------------------------------------------------------------------===//

/// Adds a new block argument that corresponds to buffers located in
/// workgroup memory.
BlockArgument SODAFuncOp::addWorkgroupAttribution(Type type, Location loc) {
  auto attrName = getNumWorkgroupAttributionsAttrName();
  auto attr = (*this)->getAttrOfType<IntegerAttr>(attrName);
  (*this)->setAttr(attrName,
                   IntegerAttr::get(attr.getType(), attr.getValue() + 1));
  return getBody().insertArgument(
      getFunctionType().getNumInputs() + attr.getInt(), type, loc);
}

/// Adds a new block argument that corresponds to buffers located in
/// private memory.
BlockArgument SODAFuncOp::addPrivateAttribution(Type type, Location loc) {
  // Buffers on the private memory always come after buffers on the workgroup
  // memory.
  return getBody().addArgument(type, loc);
}

void SODAFuncOp::build(OpBuilder &builder, OperationState &result,
                       StringRef name, FunctionType type,
                       TypeRange workgroupAttributions,
                       TypeRange privateAttributions,
                       ArrayRef<NamedAttribute> attrs) {
  result.addAttribute(SymbolTable::getSymbolAttrName(),
                      builder.getStringAttr(name));
  result.addAttribute(getTypeAttrName(), TypeAttr::get(type));
  result.addAttribute(getNumWorkgroupAttributionsAttrName(),
                      builder.getI64IntegerAttr(workgroupAttributions.size()));
  result.addAttributes(attrs);
  Region *body = result.addRegion();
  Block *entryBlock = new Block;
  // TODO: Allow passing in proper locations here.
  for (Type argTy : type.getInputs())
    entryBlock->addArgument(argTy, result.location);
  for (Type argTy : workgroupAttributions)
    entryBlock->addArgument(argTy, result.location);
  for (Type argTy : privateAttributions)
    entryBlock->addArgument(argTy, result.location);

  body->getBlocks().push_back(entryBlock);
}

/// Parses a SODA function memory attribution.
///
/// memory-attribution ::= (`workgroup` `(` ssa-id-and-type-list `)`)?
///                        (`private` `(` ssa-id-and-type-list `)`)?
///
/// Note that this function parses only one of the two similar parts, with the
/// keyword provided as argument.
static ParseResult
parseAttributions(OpAsmParser &parser, StringRef keyword,
                  SmallVectorImpl<OpAsmParser::Argument> &args) {
  // If we could not parse the keyword, just assume empty list and succeed.
  if (failed(parser.parseOptionalKeyword(keyword)))
    return success();

  return parser.parseArgumentList(args, OpAsmParser::Delimiter::Paren,
                                  /*allowType=*/true);
}

/// Parses a SODA function.
///
/// <operation> ::= `soda.func` symbol-ref-id `(` argument-list `)`
///                 (`->` function-result-list)? memory-attribution `kernel`?
///                 function-attributes? region
ParseResult SODAFuncOp::parse(OpAsmParser &parser, OperationState &result) {
  SmallVector<OpAsmParser::Argument> entryArgs;
  // SmallVector<NamedAttrList> argAttrs;
  SmallVector<DictionaryAttr> resultAttrs;
  SmallVector<Type> resultTypes;
  // SmallVector<Location> argLocations;
  bool isVariadic;

  // Parse the function name.
  StringAttr nameAttr;
  if (parser.parseSymbolName(nameAttr, ::mlir::SymbolTable::getSymbolAttrName(),
                             result.attributes))
    return failure();

  auto signatureLocation = parser.getCurrentLocation();
  if (failed(function_interface_impl::parseFunctionSignature(
          parser, /*allowVariadic=*/false, entryArgs, isVariadic, resultTypes,
          resultAttrs)))
    return failure();

  if (!entryArgs.empty() && entryArgs[0].ssaName.name.empty())
    return parser.emitError(signatureLocation)
           << "soda.func requires named arguments";

  // Construct the function type. More types will be added to the region, but
  // not to the function type.
  Builder &builder = parser.getBuilder();

  SmallVector<Type> argTypes;
  for (auto &arg : entryArgs)
    argTypes.push_back(arg.type);
  auto type = builder.getFunctionType(argTypes, resultTypes);
  result.addAttribute(SODAFuncOp::getTypeAttrName(), TypeAttr::get(type));

  function_interface_impl::addArgAndResultAttrs(builder, result, entryArgs,
                                                resultAttrs);

  // Parse workgroup memory attributions.
  if (failed(parseAttributions(parser, SODAFuncOp::getWorkgroupKeyword(),
                               entryArgs)))
    return failure();

  // Store the number of operands we just parsed as the number of workgroup
  // memory attributions.
  unsigned numWorkgroupAttrs = argTypes.size() - type.getNumInputs();
  result.addAttribute(SODAFuncOp::getNumWorkgroupAttributionsAttrName(),
                      builder.getI64IntegerAttr(numWorkgroupAttrs));

  // Parse private memory attributions.
  if (failed(parseAttributions(parser, SODAFuncOp::getPrivateKeyword(),
                               entryArgs)))
    return failure();

  // Parse the kernel attribute if present.
  if (succeeded(parser.parseOptionalKeyword(SODAFuncOp::getKernelKeyword())))
    result.addAttribute(SODADialect::getKernelFuncAttrName(),
                        builder.getUnitAttr());

  // Parse attributes.
  if (failed(parser.parseOptionalAttrDictWithKeyword(result.attributes)))
    return failure();

  // Parse the region. If no argument names were provided, take all names
  // (including those of attributions) from the entry block.
  auto *body = result.addRegion();
  return parser.parseRegion(*body, entryArgs);
}

static void printAttributions(OpAsmPrinter &p, StringRef keyword,
                              ArrayRef<BlockArgument> values) {
  if (values.empty())
    return;

  p << ' ' << keyword << '(';
  llvm::interleaveComma(
      values, p, [&p](BlockArgument v) { p << v << " : " << v.getType(); });
  p << ')';
}

/// Prints a SODA Func op.
void SODAFuncOp::print(OpAsmPrinter &p) {
  p << ' ';
  p.printSymbolName(getName());

  FunctionType type = getFunctionType();
  function_interface_impl::printFunctionSignature(p, *this, type.getInputs(),
                                                  /*isVariadic=*/false,
                                                  type.getResults());

  printAttributions(p, getWorkgroupKeyword(), getWorkgroupAttributions());
  printAttributions(p, getPrivateKeyword(), getPrivateAttributions());
  if (isKernel())
    p << ' ' << getKernelKeyword();

  function_interface_impl::printFunctionAttributes(
      p, *this, type.getNumInputs(), type.getNumResults(),
      {getNumWorkgroupAttributionsAttrName(),
       SODADialect::getKernelFuncAttrName()});
  p.printRegion(getBody(), /*printEntryBlockArgs=*/false);
}

/// Hook for FunctionLike verifier.
LogicalResult SODAFuncOp::verifyType() {
  Type type = getFunctionTypeAttr().getValue();
  if (!type.isa<FunctionType>())
    return emitOpError("requires '" + getTypeAttrName() +
                       "' attribute of function type");

  if (isKernel() && getFunctionType().getNumResults() != 0)
    return emitOpError() << "expected void return type for kernel function";

  return success();
}

static LogicalResult verifyAttributions(Operation *op,
                                        ArrayRef<BlockArgument> attributions,
                                        unsigned memorySpace) {
  for (Value v : attributions) {
    auto type = v.getType().dyn_cast<MemRefType>();
    if (!type)
      return op->emitOpError() << "expected memref type in attribution";

    if (type.getMemorySpaceAsInt() != memorySpace) {
      return op->emitOpError()
             << "expected memory space " << memorySpace << " in attribution";
    }
  }
  return success();
}

/// Verifies the body of the function.
LogicalResult SODAFuncOp::verifyBody() {
  unsigned numFuncArguments = getNumArguments();
  unsigned numWorkgroupAttributions = getNumWorkgroupAttributions();
  unsigned numBlockArguments = front().getNumArguments();

  // TODO(NICO): Remove this check
  if (numBlockArguments < numFuncArguments + numWorkgroupAttributions)
    return emitOpError() << "expected at least "
                         << numFuncArguments + numWorkgroupAttributions
                         << " arguments to body region";

  ArrayRef<Type> funcArgTypes = getFunctionType().getInputs();
  for (unsigned i = 0; i < numFuncArguments; ++i) {
    Type blockArgType = front().getArgument(i).getType();
    if (funcArgTypes[i] != blockArgType)
      return emitOpError() << "expected body region argument #" << i
                           << " to be of type " << funcArgTypes[i] << ", got "
                           << blockArgType;
  }

  if (failed(verifyAttributions(getOperation(), getWorkgroupAttributions(),
                                SODADialect::getWorkgroupAddressSpace())) ||
      failed(verifyAttributions(getOperation(), getPrivateAttributions(),
                                SODADialect::getPrivateAddressSpace())))
    return failure();

  return success();
}

//===----------------------------------------------------------------------===//
// ReturnOp
//===----------------------------------------------------------------------===//

LogicalResult soda::ReturnOp::verify() {
  SODAFuncOp function = (*this)->getParentOfType<SODAFuncOp>();

  FunctionType funType = function.getFunctionType();

  if (funType.getNumResults() != operands().size())
    return emitOpError()
        .append("expected ", funType.getNumResults(), " result operands")
        .attachNote(function.getLoc())
        .append("return type declared here");

  for (const auto &pair : llvm::enumerate(
           llvm::zip(function.getFunctionType().getResults(), operands()))) {
    auto [type, operand] = pair.value();
    if (type != operand.getType())
      return emitOpError() << "unexpected type `" << operand.getType()
                           << "' for operand #" << pair.index();
  }
  return success();
}

//===----------------------------------------------------------------------===//
// SODAModuleOp
//===----------------------------------------------------------------------===//

void SODAModuleOp::build(OpBuilder &builder, OperationState &result,
                         StringRef name) {
  ensureTerminator(*result.addRegion(), builder, result.location);
  result.attributes.push_back(builder.getNamedAttr(
      ::mlir::SymbolTable::getSymbolAttrName(), builder.getStringAttr(name)));
}

ParseResult SODAModuleOp::parse(OpAsmParser &parser, OperationState &result) {
  StringAttr nameAttr;
  if (parser.parseSymbolName(nameAttr, ::mlir::SymbolTable::getSymbolAttrName(),
                             result.attributes))
    return failure();

  // If module attributes are present, parse them.
  if (parser.parseOptionalAttrDictWithKeyword(result.attributes))
    return failure();

  // Parse the module body.
  auto *body = result.addRegion();
  if (parser.parseRegion(*body, {}))
    return failure();

  // Ensure that this module has a valid terminator.
  SODAModuleOp::ensureTerminator(*body, parser.getBuilder(), result.location);
  return success();
}

void SODAModuleOp::print(OpAsmPrinter &p) {
  p << ' ';
  p.printSymbolName(getName());
  p.printOptionalAttrDictWithKeyword((*this)->getAttrs(),
                                     {mlir::SymbolTable::getSymbolAttrName()});
  p << ' ';
  p.printRegion(getRegion(), /*printEntryBlockArgs=*/false,
                /*printBlockTerminators=*/false);
}

/// Parses an optional list of async operands with an optional leading keyword.
/// (`async`)? (`[` ssa-id-list `]`)?
///
/// This method is used by the tablegen assembly format for async ops as well.
static ParseResult parseAsyncDependencies(
    OpAsmParser &parser, Type &asyncTokenType,
    SmallVectorImpl<OpAsmParser::UnresolvedOperand> &asyncDependencies) {
  auto loc = parser.getCurrentLocation();
  if (succeeded(parser.parseOptionalKeyword("async"))) {
    if (parser.getNumResults() == 0)
      return parser.emitError(loc, "needs to be named when marked 'async'");
    asyncTokenType = parser.getBuilder().getType<AsyncTokenType>();
  }
  return parser.parseOperandList(asyncDependencies,
                                 OpAsmParser::Delimiter::OptionalSquare);
}

static void printAsyncDependencies(OpAsmPrinter &printer, Operation *op,
                                   Type asyncTokenType,
                                   OperandRange asyncDependencies) {
  if (asyncTokenType)
    printer << "async ";
  if (asyncDependencies.empty())
    return;
  printer << '[';
  llvm::interleaveComma(asyncDependencies, printer);
  printer << ']';
}

#include "soda/Dialect/SODA/SODAOpInterfaces.cpp.inc"
#include "soda/Dialect/SODA/SODAOpsEnums.cpp.inc"

#define GET_ATTRDEF_CLASSES
#include "soda/Dialect/SODA/SODAOpsAttributes.cpp.inc"

#define GET_OP_CLASSES
#include "soda/Dialect/SODA/SODAOps.cpp.inc"
