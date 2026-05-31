add_mlir_pdll_library(MulToAddPdllIncGen
  MulToAdd.pdll
  MulToAddPdll.h.inc
)

add_mlir_library(MulToAdd
    MulToAdd.cpp
    MulToAddPdll.cpp

    DEPENDS
    MLIRMulToAddPasses
    MulToAddPdllIncGen
)

set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name Arith)
add_public_tablegen_target(MLIRMulToAddPasses)
add_mlir_doc(Passes ArithPasses ./ -gen-pass-doc)
