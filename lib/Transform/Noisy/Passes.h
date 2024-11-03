#ifndef LIB_TRANSFORM_NOISY_PASSES_H_
#define LIB_TRANSFORM_NOISY_PASSES_H_

#include "ReduceNoiseOptimizer.h"

namespace mlir {
namespace tutorial {
namespace noisy {

#define GEN_PASS_REGISTRATION
#include "Passes.h.inc"

}  // namespace noisy
}  // namespace tutorial
}  // namespace mlir

#endif  // LIB_TRANSFORM_NOISY_PASSES_H_
