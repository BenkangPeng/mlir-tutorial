cmake_minimum_required(VERSION 3.20.0)

# Define the project name and the programming languages it uses.
project(mlir-tutorial LANGUAGES CXX C)

# `CACHE` means the variable is stored in the cache and can be overridden by the user.
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")

# Generate a 'compile_commands.json' file in the build directory.
# This file tells language servers (like clangd) how to index the project.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Locate the MLIR package. 'REQUIRED' means CMake will stop if it's not found.
# 'CONFIG' tells CMake to look for MLIRConfig.cmake.
find_package(MLIR REQUIRED CONFIG)
find_package(LLVM REQUIRED CONFIG)

# Print status messages showing where the MLIR and LLVM configurations were found.
message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# Include standard LLVM, TableGen and MLIR CMake modules which provide 
# helper functions for building LLVM-based projects.
include(AddLLVM)
include(TableGen)

# Add the directory containing MLIR's CMake modules to the search path.
# Then we can `include(AddMLIR)` to use the MLIR-specific CMake modules.
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
include(AddMLIR)

# Add include directories for the compiler to find header files.
include_directories(${LLVM_INCLUDE_DIRS})      # LLVM headers
include_directories(${MLIR_INCLUDE_DIRS})      # MLIR headers
include_directories(${PROJECT_SOURCE_DIR})     # This project's source headers
include_directories(${PROJECT_BINARY_DIR})    # Generated headers (from TableGen)

# Process the CMakeLists.txt files in these subdirectories.
add_subdirectory(tests)
add_subdirectory(tools)
add_subdirectory(lib)
