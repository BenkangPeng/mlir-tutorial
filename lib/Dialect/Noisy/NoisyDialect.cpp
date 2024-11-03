#include "NoisyDialect.h"

#include "NoisyOps.h"
#include "NoisyTypes.h"
#include "mlir/IR/Builders.h"
#include "llvm/ADT/TypeSwitch.h"

#include "NoisyDialect.cpp.inc"
#define GET_TYPEDEF_CLASSES
#include "NoisyTypes.cpp.inc"
#define GET_OP_CLASSES
#include "NoisyOps.cpp.inc"

namespace mlir {
namespace tutorial {
namespace noisy {

void NoisyDialect::initialize() {
  addTypes<
#define GET_TYPEDEF_LIST
#include "NoisyTypes.cpp.inc"
      >();
  addOperations<
#define GET_OP_LIST
#include "NoisyOps.cpp.inc"
      >();
}

} // namespace noisy
} // namespace tutorial
} // namespace mlir
