# soda-opt - Enabling System Level Design in MLIR

This project aims to create `soda-opt`, a tool that leverages `mlir` to
extract pre-selected high-level code snippets and compile these snippets to
llvm IR, so they can be synthesized by our high-level synthesis tool of choice.

As a long term vision, the `soda-opt` project seeks to provide a set of
*compiler libraries* to perform the target optimizations; *runtime libraries* 
to offload the compute from host to the selected targets; and to be
*standalone*, being built on top of standard `mlir` tools and dialects, so
that any project (e.i. TF, ONNX, etc) could use the exposed optimization
passes to offload and perform HLS of selected code snippets. As a final
goal, `soda-opt` could later be merged into the main `llvm-project` codebase.


## How to build?

This setup assumes that you have built LLVM and MLIR in `$BUILD_DIR` and
installed it to `$PREFIX`. 
The current version of the project was tested with `llvm-project` commit:
`bad0290ce3744d4f62dbe82380e6f648c1aa39c5`.
Make sure you have the correct commit checked-out.

**Note**: Make sure to pass `-DLLVM_INSTALL_UTILS=ON` when building LLVM/MLIR 
with CMake so that it installs `FileCheck`.

To build `soda-opt` and run the tests of this project, execute:

```sh
mkdir build && cd build
cmake -G Ninja .. \
    -DLLVM_EXTERNAL_LIT=$BUILD_DIR/bin/llvm-lit \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir

# Run tests
cmake --build . --target check-soda
```

### Building LLVM/MLIR with Helper Script

LLVM can be built with the helper `build_tools/build_mlir.sh`.

```sh
# To configure, build, and install
./build_mlir.sh <path/to/llvm/src> <llvm_build_dir> <llvm_install_dir>
```

### Building soda-opt with Helper Script

Alternatively it is possible to use the helper script
`build_tools/build_proj.sh` to build this project:

```sh
# To configure, build, and install
./build_tools/build_proj.sh <source_dir> <build_dir> <path/to/llvm/build/dir> <path/to/llvm/install/dir>
```

## How to generate the docs?

To build the documentation from the TableGen description of the dialect
operations, run
```sh
cmake --build . --target mlir-doc
```

## How to use this project?

After successful build, available passes can be displayed with:

```sh
$PROJ_BUILD_DIR/bin/soda-opt -h
```

Optimizations passes and lowerings can be executed on a `.mlir` file with the
following command:

```sh
# With loop tiling to fit 512KiB "L1" memory
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --soda-test-opt-pipeline="cache-size=512"

# Without loop tiling
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --soda-test-opt-pipeline
```

## License

This project is made available under the Apache License 2.0 with LLVM
Exceptions. See the `LICENSE.txt` file for more details.

## Credits

This project was build on top of the mlir out-of-tree template available here:

- Original author: https://github.com/jmgorius/mlir-standalone-template
- LLVM Mirror: https://github.com/llvm/llvm-project/tree/main/mlir/examples/standalone
