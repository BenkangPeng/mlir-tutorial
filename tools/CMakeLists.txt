# `MLIR_DIALECT_LIBS`: A globally maintained attribute within MLIR that contains a list of all registered MLIR dialect libraries (such as MLIRAffine, MLIRArithmetic, MLIRSCF, etc.).
# `MLIR_CONVERSION_LIBS`: A globally maintained attribute within MLIR that contains a list of all registered MLIR conversion libraries (such as MLIRAffineToStandard, MLIRArithmeticToStandard, MLIRSCFToStandard, etc.).
# `get_property`: Save these two lists into the variables `dialect_libs` and `conversion_libs` respectively.
get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

# Merge the dialect library, conversion library,
# and a series of explicitly specified library names into the LIBS variable
set (LIBS
    ${dialect_libs}
    ${conversion_libs}
    AffineFullUnroll
    MLIROptLib
    MLIRPass
    MLIRPoly
    MulToAdd
    PolyToStandard
)

# Create an executable target named 'tutorial-opt' that builds from 'tutorial-opt.cpp'.
add_llvm_executable(tutorial-opt tutorial-opt.cpp)

# Invoke LLVM helper functions to add common compilation flags
# (such as -fno-rtti, -fPIC, etc.) for the tutorial-opt target.
llvm_update_compile_flags(tutorial-opt)
# Link the tutorial-opt target to the libraries specified in the LIBS variable privately.
target_link_libraries(tutorial-opt PRIVATE ${LIBS})

# Check if all needed libraries are linked correctly.
mlir_check_all_link_libraries(tutorial-opt)
