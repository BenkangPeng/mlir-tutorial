#ifndef LIB_DIALECT_NOISY_NOISYOPS_H_
#define LIB_DIALECT_NOISY_NOISYOPS_H_

#include "NoisyDialect.h"
#include "NoisyTypes.h"
#include "mlir/Interfaces/InferTypeOpInterface.h"
#include "mlir/Interfaces/InferIntRangeInterface.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"

#define GET_OP_CLASSES
#include "NoisyOps.h.inc"

#endif // LIB_DIALECT_NOISY_NOISYOPS_H_
