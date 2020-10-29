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


## How to build

This setup assumes that you have built LLVM and MLIR in `$BUILD_DIR` and
installed it to `$PREFIX`. To build and launch the tests of this project, run:

```sh
mkdir build && cd build
cmake -G Ninja .. \
    -DLLVM_EXTERNAL_LIT=$BUILD_DIR/bin/llvm-lit \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir

cmake --build . --target check-soda
```

**Note**: Make sure to pass `-DLLVM_INSTALL_UTILS=ON` when building LLVM with
CMake so that it installs `FileCheck` to the chosen installation prefix.

Alternatively it is possible to use the build helper: `build_tools/build_proj.sh`

```sh
./build_tools/build_proj.sh <source_dir> <build_dir> <path/to/llvm/build/dir> <path/to/llvm/install/dir>
```

### How to generate docs?

To build the documentation from the TableGen description of the dialect
operations, run
```sh
cmake --build . --target mlir-doc
```

### Building LLVM with Helper Script

LLVM can be build with the helper `build_tools/build_mlir.sh`.
The current version of the project was tested with `llvm-project` commit:
`1ce5f8bbb6f3fb581fd4c5905e5574c8b9a09268`.
Make sure you have the correct commit checked-out.

```bash
# To configure and build
./build_mlir.sh <path/to/llvm> <llvm_build_dir> <llvm_install_dir>

# To install
cmake --build <llvm_build_dir> --target install
```

## License

This project is made available under the Apache License 2.0 with LLVM
Exceptions. See the `LICENSE.txt` file for more details.

## Credits

This project was build on top of the mlir out-of-tree template available here:

- Original author: https://github.com/jmgorius/mlir-standalone-template
- LLVM Mirror: https://github.com/llvm/llvm-project/tree/master/mlir/examples/standalone
