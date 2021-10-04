# SODA-OPT - Enabling System Level Design in MLIR

This project aims to create `soda-opt`, a tool that leverages `mlir` to extract
pre-selected high-level code snippets, optimize, and translate these snippets to
LLVM IR, so they can be synthesized by our high-level synthesis tool of choice.

As a long term vision, the SODA-OPT project seeks to provide a set of
*compiler libraries* to perform the target optimizations; *runtime libraries* 
to offload the compute from host to the selected targets; and to be
*standalone*, being built on top of standard `mlir` tools and dialects, so
that any project (e.i. TF, ONNX, etc) could use the exposed optimization
passes to offload and perform HLS of selected code snippets. As a final
goal, `soda-opt` could later be merged into the main `llvm-project` codebase.


## How to build?

This setup assumes that you have built LLVM and MLIR in `$BUILD_DIR` and
installed it to `$PREFIX`. 
The current version of this project was tested with `llvm-project` commit:
`7eb899cbcdd15bd57e5630bb0c43163d0c992a82`.
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

LLVM can be built with the helper `build_tools/build_llvm.sh`.

```sh
# To configure, build, and install
./build_llvm.sh <path/to/llvm/src> <llvm_build_dir> <llvm_install_dir>
```

### Building soda-opt with Helper Script

Alternatively it is possible to use the helper script
`build_tools/build_soda.sh` to build this project:

```sh
# To configure, build, and install
./build_tools/build_soda.sh <source_dir> <install_dir> <build_dir> <path/to/llvm/build/dir> <path/to/llvm/install/dir>
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

Search passes can be executed with the following command:

```sh
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --convert-linalg-matmul-to-soda

# Other patterns can be marked for outlining with passes following the
# template:
# --convert-<dialect_name>-<op_name>-to-soda
```

Kernel outlining pass can be executed with the following command:

```sh
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/Dialect/SODA/outlining-matmul.mlir \
  --soda-outline-bambu-code

# In the future, searched coded can be outlined for other architectures
# following the pass template: 
# --soda-outline-<target_name>-code
```

Generation/extraction of kernel code exclusive for bambu can be obtained with
the following command:

```sh
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/Dialect/SODA/outlining-matmul.mlir \
  --soda-generate-bambu-accelcode

# In the future, outlined code can be extracted for other target architectures
# following the pass template:
# --soda-generate-<target_name>-accelcode
```

Generation of host code calls to the target accelerator api can be obtained
with the following command:

```sh
# Note this is still under development
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/Dialect/SODA/outlining-matmul.mlir \
  --soda-generate-bambu-hostcode

# In the future, additional host code generation for other accelerator apis
# will be performed by the following pass template:
# --soda-generate-<target_name>-hostcode
```

Optimizations passes and lowerings can be executed on a `.mlir` file with the
following command:

```sh
# With loop tiling to fit 512KiB "L1" memory
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --soda-opt-pipeline="cache-size=512"

# Without loop tiling
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --soda-opt-pipeline
```

## Credits

This project was build on top of the mlir out-of-tree template available here:

- Original author: https://github.com/jmgorius/mlir-standalone-template
- LLVM Mirror: https://github.com/llvm/llvm-project/tree/main/mlir/examples/standalone

---

## License

This project is made available under the BSD2 License.  See the
[LICENSE.txt](LICENSE.txt) file for more details.

### Software from third parties included in the SODA-OPT Project

The SODA-OPT Project contains third party software which is under different
license terms. All such code will be identified clearly using at least one of
two mechanisms:
1) It will be in a separate directory tree with its own `LICENSE.txt` or
   `LICENSE` file at the top containing the specific license and restrictions
   which apply to that software, or
2) It will contain specific license and restriction terms at the top of every
   file. 

---

# Disclaimer Notice

This material was prepared as an account of work sponsored by an agency of the
United States Government.  Neither the United States Government nor the United
States Department of Energy, nor Battelle, nor any of their employees, nor any
jurisdiction or organization that has cooperated in the development of these
materials, makes any warranty, express or implied, or assumes any legal
liability or responsibility for the accuracy, completeness, or usefulness or any
information, apparatus, product, software, or process disclosed, or represents
that its use would not infringe privately owned rights.

Reference herein to any specific commercial product, process, or service by
trade name, trademark, manufacturer, or otherwise does not necessarily
constitute or imply its endorsement, recommendation, or favoring by the United
States Government or any agency thereof, or Battelle Memorial Institute. The
views and opinions of authors expressed herein do not necessarily state or
reflect those of the United States Government or any agency thereof.


<div align=center>
<pre style="align-text:center">
PACIFIC NORTHWEST NATIONAL LABORATORY
operated by
BATTELLE
for the
UNITED STATES DEPARTMENT OF ENERGY
under Contract DE-AC05-76RL01830
</pre>
</div>
