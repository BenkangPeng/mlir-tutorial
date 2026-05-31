# MLIR For Beginners

This is the code repository for a series of articles on the
[MLIR framework](https://mlir.llvm.org/) for building compilers.

## Articles

1.  [Build System (Getting Started)](https://jeremykun.com/2023/08/10/mlir-getting-started/)
2.  [Running and Testing a Lowering](https://jeremykun.com/2023/08/10/mlir-running-and-testing-a-lowering/)
3.  [Writing Our First Pass](https://jeremykun.com/2023/08/10/mlir-writing-our-first-pass/)
4.  [Using Tablegen for Passes](https://jeremykun.com/2023/08/10/mlir-using-tablegen-for-passes/)
5.  [Defining a New Dialect](https://jeremykun.com/2023/08/21/mlir-defining-a-new-dialect/)
6.  [Using Traits](https://jeremykun.com/2023/09/07/mlir-using-traits/)
7.  [Folders and Constant Propagation](https://jeremykun.com/2023/09/11/mlir-folders/)
8.  [Verifiers](https://jeremykun.com/2023/09/13/mlir-verifiers/)
9.  [Canonicalizers and Declarative Rewrite Patterns](https://jeremykun.com/2023/09/20/mlir-canonicalizers-and-declarative-rewrite-patterns/)
10. [Dialect Conversion](https://jeremykun.com/2023/10/23/mlir-dialect-conversion/)
11. [Lowering through LLVM](https://jeremykun.com/2023/11/01/mlir-lowering-through-llvm/)

The codes of the below 2 articles are not included in this repository.
Since they rely on the heavy OR-Tools library, so I just skip them as a newbie. 
12. [A Global Optimization and Dataflow Analysis](https://jeremykun.com/2023/11/15/mlir-a-global-optimization-and-dataflow-analysis/)
12. [Defining Patterns with PDLL](https://www.jeremykun.com/2024/08/04/mlir-pdll/)

## CMake build

CMake is one of two supported build systems for this tutorial. The other is
Bazel. If you're unfamiliar with CMake, you can read the tutorials at
[https://cmake.org/getting-started/](https://cmake.org/getting-started/). The
CMake build is maintained, but was added at article 10 (Dialect Conversion) and
will not be explained in the articles.

### Prerequisites

*   Make sure you have installed everything needed to build LLVM
    https://llvm.org/docs/GettingStarted.html#software
*   For this recipe Ninja is used so be sure to have it as well installed
    https://github.com/ninja-build/ninja/wiki/Pre-built-Ninja-packages

### Checking out the code

Checkout the tutorial including the LLVM dependency (submodules):

```bash
git clone https://github.com/BenkangPeng/mlir-tutorial.git
cd mlir-tutorial
```

### Building dependencies

Note: The following steps are suitable for Ubuntu24.04 and use ninja as building
system, they should not be hard to adapt for your environment.

*Build LLVM/MLIR*
Please refer to the official documentation of LLVM: https://llvm.org/docs/GettingStarted.html to build/install LLVM.
LLVM 20.1.7 is used in this repository.


### Build and test

```bash
#!/bin/sh

rm -rf build/
mkdir build/
cd build/

LLVM_BUILD_DIR=/path/to/your/llvm/build
# If you install the LLVM to the specific path, the $LLVM_BUILD_DIR also should be replaced with 
# the install path. e.g., /usr/local/llvm-20.1.7
cmake -G Ninja .. \
    -DLLVM_DIR="$LLVM_BUILD_DIR/lib/cmake/llvm" \
    -DMLIR_DIR="$LLVM_BUILD_DIR/lib/cmake/mlir" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cmake --build .
```
Run tests:
```bash
ninja check-mlir-tutorial
```