#ifndef LIB_DIALECT_POLY_POLYTYPES_TD_
#define LIB_DIALECT_POLY_POLYTYPES_TD_

include "PolyDialect.td"
include "mlir/IR/AttrTypeBase.td"

// A base class for all types in this dialect
// Difference between `def` and `class`:
// `def` defines actual types, which actually means it generates C++ code,
// while class is only an inheritance base and disappears after tablegen is done(doesn't generate C++ code). 
class Poly_Type<string name, string typeMnemonic> : TypeDef<Poly_Dialect, name> {
  let mnemonic = typeMnemonic;
}

def Polynomial : Poly_Type<"Polynomial", "poly"> {
  let summary = "A polynomial with u32 coefficients";

  let description = [{
    A type for polynomials with integer coefficients in a single-variable polynomial ring.
  }];

  // Polynomial type has a single input parameter: the degree bound.
  // e.g., Polynomial<5>
  let parameters = (ins "int":$degreeBound);
  // The assembly format for the polynomial type is `Polynomial<degreeBound>`.
  let assemblyFormat = "`<` $degreeBound `>`";
}

#endif  // LIB_DIALECT_POLY_POLYTYPES_TD_
