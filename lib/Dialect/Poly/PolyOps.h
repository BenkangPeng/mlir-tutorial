#ifndef LIB_DIALECT_POLY_POLYOPS_H_
#define LIB_DIALECT_POLY_POLYOPS_H_

#include "PolyDialect.h"
#include "PolyTraits.h"
#include "PolyTypes.h"
#include "mlir/Interfaces/InferTypeOpInterface.h" // from @llvm-project
#include "mlir/IR/BuiltinOps.h"      // from @llvm-project
#include "mlir/IR/BuiltinTypes.h"    // from @llvm-project
#include "mlir/IR/Dialect.h"         // from @llvm-project

#define GET_OP_CLASSES
#include "PolyOps.h.inc"

#endif // LIB_DIALECT_POLY_POLYOPS_H_
