include_directories(${PROJECT_SOURCE_DIR}/lib/Conversion/PolyToStandard/)
include_directories(${PROJECT_BINARY_DIR}/lib/Conversion/PolyToStandard/)
include_directories(${PROJECT_SOURCE_DIR}/lib/Dialect/Poly/)
include_directories(${PROJECT_BINARY_DIR}/lib/Dialect/Poly/)
add_mlir_library(PolyToStandard
  PolyToStandard.cpp


  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/lib/Conversion/PolyToStandard/
  ${PROJECT_BINARY_DIR}/lib/Conversion/PolyToStandard/
  ${PROJECT_SOURCE_DIR}/lib/Dialect/Poly/
  ${PROJECT_BINARY_DIR}/lib/Dialect/Poly/

  DEPENDS
  PolyToStandardPassIncGen

  LINK_COMPONENTS
  Core

  LINK_LIBS PUBLIC
  MLIRPoly
  MLIRArithDialect
  MLIRFuncDialect
  MLIRFuncTransforms
  MLIRIR
  MLIRPass
  MLIRSCFDialect
  MLIRTensorDialect
  MLIRTransforms
  )

set(LLVM_TARGET_DEFINITIONS PolyToStandard.td)
mlir_tablegen(PolyToStandard.h.inc -gen-pass-decls -name PolyToStandard)
add_dependencies(mlir-headers MLIRPolyOpsIncGen)
add_public_tablegen_target(PolyToStandardPassIncGen)
add_mlir_doc(PolyToStandard PolyToStandard PolyToStandard/ -gen-pass-doc)
