configure_lit_site_cfg(
    ${CMAKE_CURRENT_SOURCE_DIR}/lit.cmake.site.cfg.py.in
    ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
    MAIN_CONFIG
    ${CMAKE_CURRENT_SOURCE_DIR}/lit.cmake.cfg.py
)

# Tells cmake that the testsuite depends on the tutorial-opt tool.
set (MLIR_TUTORIAL_TEST_DEPENDS
    tutorial-opt
)

# Use `ninja check-mlir-tutorial` to run the tests.
add_lit_testsuite(check-mlir-tutorial "Running the MLIR tutorial regression tests"
    ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${MLIR_TUTORIAL_TEST_DEPENDS}
)