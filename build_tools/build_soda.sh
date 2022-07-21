#!/bin/bash

set -e

if [[ $# -ne 5 ]] ; then
  echo "Usage: $0 <source_dir> <build_dir> <install_dir> <path/to/llvm/build/dir> <path/to/llvm/install/dir>"
  exit 1
fi

# LLVM source
MY_SOURCE_DIR="$1"
MY_BUILD_DIR="$2"
MY_INSTALL_DIR="$3"
LLVM_BUILD_DIR="$4"
LLVM_INSTALL_DIR="$5"


if ! [ -f "$LLVM_BUILD_DIR/bin/llvm-lit" ]; then
  echo "Expected the path to LLVM BUILD to be set correctly (got '$LLVM_BUILD_DIR'): can't find llvm-lit"
  exit 1
fi
echo "Using LLVM BUILD dir: $LLVM_BUILD_DIR"


if ! [ -f "$LLVM_INSTALL_DIR/lib/cmake/mlir/MLIRTargets.cmake" ]; then
  echo "Expected the path to LLVM INSTALL to be set correctly (got '$LLVM_INSTALL_DIR'): can't find MLIRTargets.cmake"
  exit 1
fi
echo "Using LLVM INSTALL dir: $LLVM_INSTALL_DIR"

# Setup directories.
echo "Building project in $MY_BUILD_DIR"
mkdir -p "$MY_BUILD_DIR"

echo "Beginning build (commands will echo)"
set -x

cmake -GNinja \
  "-H$MY_SOURCE_DIR" \
  "-B$MY_BUILD_DIR" \
  -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR  \
  -DCMAKE_BUILD_TYPE=Debug \
  -DLLVM_EXTERNAL_LIT=$LLVM_BUILD_DIR/bin/llvm-lit \
  -DMLIR_DIR=$LLVM_INSTALL_DIR/lib/cmake/mlir \
  -DMLIR_ENABLE_BINDINGS_PYTHON=ON

cmake --build "$MY_BUILD_DIR" --target soda-opt soda-translate mlir-runner AllocaNamer XMLWriter SODAPythonModules VhlsLLVMRewriter