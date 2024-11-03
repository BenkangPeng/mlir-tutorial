include_directories(${PROJECT_SOURCE_DIR}/lib/Transform/Noisy)
include_directories(${PROJECT_BINARY_DIR}/lib/Transform/Noisy)
include_directories(${PROJECT_SOURCE_DIR}/lib/Analysis/ReduceNoiseAnalysis)
include_directories(${PROJECT_BINARY_DIR}/lib/Analysis/ReduceNoiseAnalysis)
include_directories(${PROJECT_SOURCE_DIR}/lib/Dialect/Noisy)
include_directories(${PROJECT_BINARY_DIR}/lib/Dialect/Noisy)
add_mlir_library(NoisyPasses
    ReduceNoiseOptimizer.cpp


    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/lib/Transform/Noisy/
    ${PROJECT_BINARY_DIR}/lib/Transform/Noisy/

    DEPENDS
    MLIRNoisy
    MLIRNoisyPasses

    LINK_LIBS PUBLIC
    ReduceNoiseAnalysis
)

set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name Noisy)
add_public_tablegen_target(MLIRNoisyPasses)
add_mlir_doc(Passes NoisyPasses ./ -gen-pass-doc)
