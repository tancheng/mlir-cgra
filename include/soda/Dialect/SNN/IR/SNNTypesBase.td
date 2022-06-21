//===-- SNNTypesBase.td - SNN type definitions -------------*- tablegen -*-===//
//===----------------------------------------------------------------------===//
//
// This file defines the type definitions for the SNN dialect.
//
//===----------------------------------------------------------------------===//

#ifndef SNN_TYPES_BASE
#define SNN_TYPES_BASE

include "mlir/IR/OpBase.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/BuiltinDialect.td"
include "mlir/IR/BuiltinTypeInterfaces.td"
include "mlir/IR/SubElementInterfaces.td"

// Base class for Builtin dialect types.
class Builtin_Type<string name, list<Trait> traits = [],
                   string baseCppClass = "::mlir::Type">
    : TypeDef<Builtin_Dialect, name, traits, baseCppClass> {
  let mnemonic = ?;
}

def SNN_UnrankedTensor : Builtin_Type<"UnrankedSpikeTrain", [
    DeclareTypeInterfaceMethods<SubElementTypeInterface>
  ], "SpikeTrainType"> {
  let summary = "Multi-dimensional array with unknown dimensions";
  let description = [{
    Syntax:

    ```
    tensor-type ::= `spike_train_type` `<` `*` `x` type `>`
    ```

    An unranked tensor is a type of tensor in which the set of dimensions have
    unknown rank. See [RankedTensorType](#builtin_rankedtensor-rankedtensortype)
    for more information on tensor types.

    Examples:

    ```mlir
    tensor<*f32>
    ```
  }];
  let parameters = (ins "Type":$elementType);

  let builders = [
    TypeBuilderWithInferredContext<(ins "Type":$elementType), [{
      return $_get(elementType.getContext(), elementType);
    }]>
  ];
  let extraClassDeclaration = [{
    ArrayRef<int64_t> getShape() const { return llvm::None; }
  }];
  let skipDefaultBuilders = 1;
  let genVerifyDecl = 1;
}

//===----------------------------------------------------------------------===//
// SNN Type Definitions.
//===----------------------------------------------------------------------===//

// The base class of a quantized type.
// Param tuple is: [bitwidth, zeropt, smantissa, sexp, low_end, high_end].
// Where low and high ends are 0,255 when unsigned, -128,127 when signed, for
// the 8-bit case.
// class SNN_QuantizedType<string n, list<int> params, bit signed>
//   : Type<And<[CPred<"$_self.isa<mlir::quant::QuantizedType>()">,
//               CPred<"$_self.cast<mlir::quant::QuantizedType>()" #
//                     ".getStorageTypeIntegralWidth() == " # !head(params)>]>,
//     "Q" # !if (signed, "int", "uint") # !head(params) # " type"> {
//   string name = n;
//   string asTraitArgsStr = !interleave(params, ", ") #
//                           !if(signed, ", true", ", false");
// }

//===----------------------------------------------------------------------===//
// Non-Quantized Signed Integer Types.
// Used to express accumulator results or compare results.
//===----------------------------------------------------------------------===//

def SNN_UInt8 : UI<8>;

def SNN_Int8 : I<8>;
def SNN_Int16 : I<16>;
def SNN_Int32 : I<32>;
def SNN_Int48 : I<48>;
def SNN_Int64 : I<64>;

def SNN_SignedInt : AnyTypeOf<[SNN_Int8,
                                SNN_Int16,
                                SNN_Int32,
                                SNN_Int48,
                                SNN_Int64]>;

def SNN_Bool : I<1>;

// No unsigned unquantized int types.
def SNN_Int : AnyTypeOf<[SNN_Bool,
                          SNN_UInt8,
                          SNN_SignedInt]>;

def SNN_Int32Or64 : AnyTypeOf<[SNN_Int32,
                   	        SNN_Int64]>;

//===----------------------------------------------------------------------===//
// Quantized Integer Types.
// Datatype for network feature map or weight content.
//===----------------------------------------------------------------------===//
//===----------------------------------------------------------------------===//
// Name    Symmetry   Grouping                Sign
//===----------------------------------------------------------------------===//
// uint8 : asymmetric per tensor ,            unsigned
// int4  : symmetric  per channel,            signed
// int8  : symmetric  per tensor/per channel, signed
// int16 : symmetric  per tensor,             signed
//===----------------------------------------------------------------------===//
// def SNN_QuantizedInt	: AnyTypeOf<[ SNN_QuantizedType<"uint8", [8], 0>,
//                                      SNN_QuantizedType<"int4", [4, 0], 1>,
//                                      SNN_QuantizedType<"int8", [8, 0], 1>,
//                                      SNN_QuantizedType<"int16", [16, 0], 1>]>;

//===----------------------------------------------------------------------===//
// Floating-point types.
//===----------------------------------------------------------------------===//
def SNN_Float : AnyTypeOf<[
                            F32,
			    F16,
			    BF16]>;

//===----------------------------------------------------------------------===//
// Multi-category types.
//===----------------------------------------------------------------------===//
def SNN_AnyNumber : AnyTypeOf<[SNN_Int, SNN_Float],
                               "number">;

//===----------------------------------------------------------------------===//
// Tensor types
//===----------------------------------------------------------------------===//

def SNN_Int32Tensor : TensorOf<[SNN_Int32]>;
def SNN_Int32Or64Tensor : TensorOf<[SNN_Int32Or64]>;

// Either ranked or unranked tensor of SNN supported element types. 
def SNN_Tensor : TensorOf<[SNN_AnyNumber]>;
// Must be ranked but no further constraints
def SNN_RankedTensor : RankedTensorOf<[SNN_AnyNumber]>;

// Any tensor element type allowed in SNN ops.
def SNN_ElementType : Type<Or<[SNN_Int.predicate, 
                                SNN_Float.predicate]>, "snn.dtype">;

class SNN_TensorOfOrNone<list<Type> allowedTypes, string description = ""> :
  AnyTypeOf<[TensorOf<allowedTypes>, NoneType], description>;

//===----------------------------------------------------------------------===//
// Tensor types with constrained ranks.
//===----------------------------------------------------------------------===//

// We include unranked tensors as a supported type for all possible SNN
// Tensors as unranked does not guarantee invalid. If unranked tensors exist
// they should be shape propagate used SNN's shape inference pass and verified
// to not include any remaining unranked tensors.
// def SNN_UnrankedTensor : UnrankedTensorOf<[SNN_AnyNumber]>;

def SNN_Tensor1D : AnyTypeOf<[SNN_UnrankedTensor, 1DTensorOf<[SNN_AnyNumber]>]>;
def SNN_Tensor2D : AnyTypeOf<[SNN_UnrankedTensor, 2DTensorOf<[SNN_AnyNumber]>]>;
def SNN_Tensor3D : AnyTypeOf<[SNN_UnrankedTensor, 3DTensorOf<[SNN_AnyNumber]>]>;
def SNN_Tensor4D : AnyTypeOf<[SNN_UnrankedTensor, 4DTensorOf<[SNN_AnyNumber]>]>;
def SNN_Tensor5D : AnyTypeOf<[SNN_UnrankedTensor, TensorRankOf<[SNN_AnyNumber], [5]>]>;

// Ranked tensors up to given rank.
def SNN_Tensor1Dto4D : AnyTypeOf<[
  SNN_UnrankedTensor, TensorRankOf<[SNN_AnyNumber], [1,2,3,4]>]>;
def SNN_Tensor1Dto6D : AnyTypeOf<[
  SNN_UnrankedTensor, TensorRankOf<[SNN_AnyNumber], [1,2,3,4,5,6]>]>;

def SNN_TensorUpto4D : AnyTypeOf<[
  SNN_UnrankedTensor, TensorRankOf<[SNN_AnyNumber], [0,1,2,3,4]>]>;

def SNN_Int32TensorUpto4D : AnyTypeOf<[
  SNN_UnrankedTensor, TensorRankOf<[SNN_Int32], [0,1,2,3,4]>]>;

//===----------------------------------------------------------------------===//
// Generic scalar, vector, or tensor of a particular type.
//===----------------------------------------------------------------------===//

class SNN_TypeLike<list<Type> types, string description = ""> : TypeConstraint<Or<[
     AnyTypeOf<types>.predicate,
     VectorOf<types>.predicate,
     TensorOf<types>.predicate]>,
     description>;

def SNN_Int8Like : SNN_TypeLike<[SNN_Int8], "signless-integer-8-bit-like">;
def SNN_Int16Like : SNN_TypeLike<[SNN_Int16], "signless-integer-16-bit-like">;
def SNN_Int32Like : SNN_TypeLike<[SNN_Int32], "signless-integer-32-bit-like">;
def SNN_Int64Like : SNN_TypeLike<[SNN_Int64], "signless-integer-64-bit-like">;

//===----------------------------------------------------------------------===//
// Attribute predicates and classes.
//===----------------------------------------------------------------------===//
class ArrayMaxCt<int n> : AttrConstraint<
    CPred<"$_self.cast<::mlir::ArrayAttr>().size() <= " # n>,
    "with at least " # n # " elements">;

def SNN_Fp32ArrayAttr2 : Confined<F32ArrayAttr, [ArrayCount<2>]>;
def SNN_Fp32ArrayAttr3 : Confined<F32ArrayAttr, [ArrayCount<3>]>;
def SNN_Fp32ArrayAttr4 : Confined<F32ArrayAttr, [ArrayCount<4>]>;
def SNN_Fp32ArrayAttr5 : Confined<F32ArrayAttr, [ArrayCount<5>]>;
def SNN_Fp32ArrayAttr6 : Confined<F32ArrayAttr, [ArrayCount<6>]>;

def SNN_IntArrayAttr2 : Confined<I64ArrayAttr, [ArrayCount<2>]>;
def SNN_IntArrayAttr3 : Confined<I64ArrayAttr, [ArrayCount<3>]>;
def SNN_IntArrayAttr4 : Confined<I64ArrayAttr, [ArrayCount<4>]>;
def SNN_IntArrayAttr5 : Confined<I64ArrayAttr, [ArrayCount<5>]>;
def SNN_IntArrayAttr6 : Confined<I64ArrayAttr, [ArrayCount<6>]>;

def SNN_IntArrayAttrUpto2 : Confined<I64ArrayAttr, [ArrayMaxCt<2>]>;
def SNN_IntArrayAttrUpto4 : Confined<I64ArrayAttr, [ArrayMaxCt<4>]>;
def SNN_IntArrayAttrUpto5 : Confined<I64ArrayAttr, [ArrayMaxCt<5>]>;

//===----------------------------------------------------------------------===//
// Iterable attributes.
//===----------------------------------------------------------------------===//
// Supported regimes for snn.resize.
def SNN_ResizeTypeAttr : StringBasedAttr<
    CPred<"$_self.cast<StringAttr>().getValue() == \"BILINEAR\"  || " #
          "$_self.cast<StringAttr>().getValue() == \"NEAREST_NEIGHBOR\"">,
    "Supported resize/upsampling strategies">;

def SNN_TensorTypeAttr : TypeAttrBase<"SNNType", "Tensor type attribute">;

// Tensor to buffer types.
def SNN_Buffer : MemRefOf<[SNN_AnyNumber]>;
def SNN_TupleBuffer : NestedTupleOf<[SNN_Buffer]>;
def SNN_BufOrTuple : AnyTypeOf<[SNN_Buffer, SNN_TupleBuffer]>;

#endif // TOSA_TYPES_BASE
