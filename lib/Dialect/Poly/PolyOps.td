#ifndef LIB_DIALECT_POLY_POLYOPS_TD_
#define LIB_DIALECT_POLY_POLYOPS_TD_

include "PolyDialect.td"
include "PolyTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

// Type constraint for poly binop arguments: polys, vectors of polys, or
// tensors of polys.
def PolyOrContainer : TypeOrContainer<Polynomial, "poly-or-container">;//类型约束

// Inject verification that all integer-like arguments are 32-bits
def Has32BitArguments : NativeOpTrait<"Has32BitArguments"> {
  let cppNamespace = "::mlir::tutorial::poly";
}

class Poly_BinOp<string mnemonic> : Op<Poly_Dialect, mnemonic, [Pure, ElementwiseMappable, SameOperandsAndResultType]> {
  //                                  ↑属于Poly_Dialect方言，助记符，pure表示操作无副作用？，
  //              ElementwiseMappable表示可以逐元素操作，SameOperandsAndResultType表示操作数和结果类型相同
  let arguments = (ins PolyOrContainer:$lhs, PolyOrContainer:$rhs);
  //        接受两个输入参数，类型为PolyOrContainer，名称为lhs和rhs
  let results = (outs PolyOrContainer:$output);
  let assemblyFormat = "$lhs `,` $rhs attr-dict `:` qualified(type($output))";
  //例如 ：%result = poly.add %lhs, %rhs, {attributeName = attributeValue} : poly-or-container
  let hasFolder = 1;//支持合并(折叠)优化
  let hasCanonicalizer = 1;//支持规范化，即支持特定规则对多项式进行简化
}

def Poly_AddOp : Poly_BinOp<"add"> {
  let summary = "Addition operation between polynomials.";
}

def Poly_SubOp : Poly_BinOp<"sub"> {
  let summary = "Subtraction operation between polynomials.";
}

def Poly_MulOp : Poly_BinOp<"mul"> {
  let summary = "Multiplication operation between polynomials.";
}

def Poly_FromTensorOp : Op<Poly_Dialect, "from_tensor", [Pure]> {
  let summary = "Creates a Polynomial from integer coefficients stored in a tensor.";
  let arguments = (ins TensorOf<[AnyInteger]>:$input);
  let results = (outs Polynomial:$output);
  let assemblyFormat = "$input attr-dict `:` type($input) `->` qualified(type($output))";
  let hasFolder = 1;
}
//多项式转tensor
def Poly_ToTensorOp : Op<Poly_Dialect, "to_tensor", [Pure]> {
  let summary = "Converts a polynomial to a tensor of its integer coefficients.";
  let arguments = (ins Polynomial:$input);
  let results = (outs TensorOf<[AnyInteger]>:$output);
  let assemblyFormat = "$input attr-dict `:` qualified(type($input)) `->` type($output)";
  //%output = poly.to_tensor %poly : poly -> tensor<3xi32>
}

def IntOrComplex : AnyTypeOf<[AnyInteger, AnyComplex]>;
//定义一个类型别名 IntOrComplex表示可以是AnyInteger任意整数类型或AnyComplex(任意复数类型）

def Poly_EvalOp : Op<Poly_Dialect, "eval", [AllTypesMatch<["point", "output"]>, Has32BitArguments]> {
  //eval:计算多项式的值,输入值$poing与$output必须type-match,检查整数类型是否为32位
  let summary = "Evaluates a Polynomial at a given input value.";
  let arguments = (ins Polynomial:$polynomial, IntOrComplex:$point);
  let results = (outs IntOrComplex:$output);
  let assemblyFormat = "$polynomial `,` $point attr-dict `:` `(` qualified(type($polynomial)) `,` type($point) `)` `->` type($output)";
  let hasVerifier = 1;//验证器
  let hasCanonicalizer = 1;//规范化
}

def Poly_ConstantOp : Op<Poly_Dialect, "constant", [Pure, ConstantLike]> {
  let summary = "Define a constant polynomial via an attribute.";
  let arguments = (ins AnyIntElementsAttr:$coefficients);
  let results = (outs Polynomial:$output);
  let assemblyFormat = "$coefficients attr-dict `:` qualified(type($output))";
  let hasFolder = 1;
}


#endif  // LIB_DIALECT_POLY_POLYOPS_TD_
