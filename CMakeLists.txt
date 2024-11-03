cmake_minimum_required(VERSION 3.20.0)
cmake_policy(SET CMP0116 NEW)

project(mlir-tutorial LANGUAGES CXX C)

set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
set(CMAKE_CXX_FLAGS "-Wfatal-errors -std=c++17")
add_compile_options(-w)

set(CMAKE_BUILD_TYPE Debug)

# set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
# set(CMAKE_POSITION_INDEPENDENT_CODE ON)
# set(BUILD_DEPS ON)

find_package(MLIR REQUIRED CONFIG)

message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/bin)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/lib)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)
include(TableGen)
include(AddMLIR)
include(HandleLLVMOptions)

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_BINARY_DIR}/include)
link_directories(${LLVM_BUILD_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

message(STATUS "Using Python binding")
include(MLIRDetectPythonEnv)
mlir_configure_python_dev_packages()

add_subdirectory(tests)
add_subdirectory(tools)
add_subdirectory(lib)


# list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
# include(AddMLIR)
# include_directories(${LLVM_INCLUDE_DIRS})
# include_directories(${MLIR_INCLUDE_DIRS})
# include_directories(${PROJECT_SOURCE_DIR})
# include_directories(${PROJECT_SOURCE_DIR}/externals/llvm-project)
# include_directories(${PROJECT_BINARY_DIR})

# message(STATUS "Fetching or-tools...")
# include(FetchContent)
# FetchContent_Declare(
#   or-tools
#   GIT_REPOSITORY https://gitee.com/tooqiu/or-tools.git #cannot connect https://github.com/google/or-tools.git
#   GIT_TAG        v9.0
# )
# FetchContent_MakeAvailable(or-tools)
# message(STATUS "Done fetching or-tools")

# add_subdirectory(tests)
# add_subdirectory(tools)
# add_subdirectory(lib)
# message(STATUS "Done building mlir-tutorial")