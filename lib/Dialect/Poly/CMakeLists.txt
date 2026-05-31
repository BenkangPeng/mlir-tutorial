# --- TableGen Configuration for Operations, Types, and Dialect ---
# Set the primary TableGen file. PolyOps.td includes PolyDialect.td and PolyTypes.td.
set(LLVM_TARGET_DEFINITIONS PolyOps.td)

# Generate C++ declarations and definitions for Operations, Types, and the Dialect class.
mlir_tablegen(PolyOps.h.inc -gen-op-decls)
mlir_tablegen(PolyOps.cpp.inc -gen-op-defs)
mlir_tablegen(PolyTypes.h.inc -gen-typedef-decls -typedefs-dialect=poly)
mlir_tablegen(PolyTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=poly)
mlir_tablegen(PolyDialect.h.inc -gen-dialect-decls -dialect=poly)
mlir_tablegen(PolyDialect.cpp.inc -gen-dialect-defs -dialect=poly)

# Create a target for the generated files so other targets can depend on them.
add_public_tablegen_target(MLIRPolyOpsIncGen)

# Ensure these headers are considered part of the core MLIR headers.
add_dependencies(mlir-headers MLIRPolyOpsIncGen)

# Generate documentation for the dialect.
add_mlir_doc(PolyDialect PolyDialect Poly/ -gen-dialect-doc)

# --- TableGen Configuration for Canonicalization Patterns ---

set(LLVM_TARGET_DEFINITIONS PolyPatterns.td)
# Generate declarative rewrite patterns (DRR) for canonicalization.
mlir_tablegen(PolyCanonicalize.cpp.inc -gen-rewriters)
add_public_tablegen_target(MLIRPolyCanonicalizationIncGen)

# --- Library Definition ---

# Define the dialect library.
add_mlir_dialect_library(MLIRPoly
    PolyDialect.cpp
    PolyOps.cpp

    # Explicitly depend on the TableGen targets to ensure .inc files are generated first.
    DEPENDS
    MLIRPolyOpsIncGen
    MLIRPolyCanonicalizationIncGen

    # Link against required MLIR and LLVM libraries.
    LINK_LIBS PUBLIC
    MLIRComplexDialect
    MLIRIR
    MLIRSideEffectInterfaces
    MLIRInferTypeOpInterface
)
