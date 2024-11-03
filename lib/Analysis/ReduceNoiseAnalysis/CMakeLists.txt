include_directories(${PROJECT_SOURCE_DIR}/lib/Dialect/Noisy)
include_directories(${PROJECT_BINARY_DIR}/lib/Dialect/Noisy)
add_mlir_library(ReduceNoiseAnalysis
    ReduceNoiseAnalysis.cpp


    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/lib/Analysis/ReduceNoiseAnalysis/
    ${PROJECT_BINARY_DIR}/lib/Analysis/ReduceNoiseAnalysis/
    # LINK_LIBS PUBLIC
    # ortools::ortools
)
