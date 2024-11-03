include_directories(${PROJECT_SOURCE_DIR}/lib/Transform/Affine/)
include_directories(${PROJECT_BINARY_DIR}/lib/Transform/Affine/)
add_mlir_library(AffineFullUnroll
    AffineFullUnroll.cpp
    AffineFullUnrollPatternRewrite.cpp


    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/lib/Transform/Affine/
    ${PROJECT_BINARY_DIR}/lib/Transform/Affine/

    DEPENDS
    MLIRAffineFullUnrollPasses

    LINK_LIBS PUBLIC
)

set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name Affine)
add_public_tablegen_target(MLIRAffineFullUnrollPasses)
add_mlir_doc(Passes AffinePasses ./ -gen-pass-doc)
