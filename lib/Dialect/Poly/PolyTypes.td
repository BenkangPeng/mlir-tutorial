#ifndef LIB_DIALECT_POLY_POLYTYPES_TD_
#define LIB_DIALECT_POLY_POLYTYPES_TD_

include "PolyDialect.td"
include "mlir/IR/AttrTypeBase.td"

// A base class for all types in this dialect
class Poly_Type<string name, string typeMnemonic> : TypeDef<Poly_Dialect, name> {
  let mnemonic = typeMnemonic;
}

def Polynomial : Poly_Type<"Polynomial", "poly"> {
  let summary = "A polynomial with u32 coefficients";

  let description = [{
    A type for polynomials with integer coefficients in a single-variable polynomial ring.
  }];
  //单变量多项式

  let parameters = (ins "int":$degreeBound);//输入参数是$degreeBound,类型是int，表示多项式的最高次数
  let assemblyFormat = "`<` $degreeBound `>`";
}

#endif  // LIB_DIALECT_POLY_POLYTYPES_TD_
