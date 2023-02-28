# mlir-cgra
An MLIR dialect to enable the efficient acceleration of ML model on CGRAs. The entire flow depends on mlir, onnx-mlir, mlir-mhlo, and soda-opt.

## Getting started
Build the required LLVM and MLIR. The current version of this project was tested with `llvm-project` commit:
`99020b3c73c1e22fa388be8fd0c44391d40b3a38`. Make sure you have the correct commit checked-out.

**Note**: Make sure to pass `-DLLVM_INSTALL_UTILS=ON` when building LLVM/MLIR with CMake so that it installs `FileCheck`.

To build LLVM&MLIR, execute:
```sh
git clone https://github.com/llvm/llvm-project.git
cd llvm-project
git checkout 99020b3c73c1e22fa388be8fd0c44391d40b3a38
mkdir build
cd build
cmake -G Ninja ../llvm \
   -DLLVM_ENABLE_PROJECTS=mlir \
   -DLLVM_BUILD_EXAMPLES=ON \
   -DLLVM_TARGETS_TO_BUILD="X86;NVPTX;AMDGPU" \
   -DCMAKE_BUILD_TYPE=Release \
   -DLLVM_ENABLE_ASSERTIONS=ON
   -DLLVM_INSTALL_UTILS=ON
```
## How to build?

This setup assumes that you have built LLVM and MLIR in `$BUILD_DIR` and
installed it to `$PREFIX`. 

```sh
mkdir build && cd build
cmake -G Ninja .. \
    -DLLVM_EXTERNAL_LIT=$BUILD_DIR/bin/llvm-lit \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir

# Run tests
cmake --build . --target check-soda
```
## How to use?
In this repository, we provide scripts for 4 ML models (CamemBERT/MiniLM/SENTENCE-BERT/VIT). Assume the model name is `$MODELNAME`.

### generate the .mlir file from PyTorch model
In this step, you need to install the corresponding torch/torchmlir package in a specific version.
Pytorch version: `1.14.0.dev20221014+cpu`
torchmlir version: `20221015.627`
download link: `https://github.com/llvm/torch-mlir/releases/tag/snapshot-20221015.627`
```sh
python ../$MODELNAME/model/MODELNAME.py
```

### run the script 
Assume the cgra type is `CGRA_TYPE`.
sh ../experiments/MODELNAME/cgra/CGRA_TYPE


# SODA-OPT - Enabling System Level Design in MLIR

This project aims to create `soda-opt`, a tool that leverages `mlir` to extract, 
optimize, and translate high-level code snippets into LLVM IR, 
so that they can be synthesized by our high-level synthesis tool of choice.

As a long term vision, the SODA-OPT project seeks to provide a set of
*compiler libraries* to perform the target optimizations; *runtime libraries* 
to offload the compute from host to the selected targets; and to be
*standalone*, being built on top of standard `mlir` tools and dialects, so
that any project (e.i. TF, ONNX, etc) could use the exposed optimization
passes to offload and perform HLS of selected code snippets. As a final
goal, `soda-opt` could later be merged into the main `llvm-project` codebase.


## Getting started

Pull our production image on dockerhub:

- https://hub.docker.com/r/agostini01/soda

And follow one of our tutorials [here](docs/tutorials).


## How to build?

This setup assumes that you have built LLVM and MLIR in `$BUILD_DIR` and
installed it to `$PREFIX`. 
The current version of this project was tested with `llvm-project` commit:
`99020b3c73c1e22fa388be8fd0c44391d40b3a38`.
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

The passes and pipelines described below have several options,
check `soda-opt -h` for additional informaton.


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

The above command can include automatic XML test generation to be
later used during simulation:

```sh
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/Dialect/SODA/outlining-matmul.mlir \
  --soda-outline-bambu-code \
  --soda-extract-arguments-to-xml=using-bare-ptr
# This will generate an xml file for each outlined kernel in the
# folder in which was called
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
# Simply lower all operations to the llvm dialect
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --lower-all-to-llvm

# Perform loop tiling to fit 512KiB "L1" memory
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --soda-opt-pipeline="cache-size=512"

# Specfic pipeline for bambu (with bare pointer call convertion)
$PROJ_BUILD_DIR/bin/soda-opt \
  $PROJ_ROOT_DIR/test/soda-opt/linalg-matmul.mlir \
  --soda-opt-pipeline-for-bambu=use-bare-ptr-memref-call-conv

# Check other options in the -soda-opt-pipeline-for-bambu with
$PROJ_BUILD_DIR/bin/soda-opt -h | less

# In the future, additional pipelines for other target architectures
# will be performed by the following pass template:
 # --soda-opt-pipeline-for-<target_name>
```

To use python bindings, setup python lib path:

```
export PYTHONPATH=$PYTHONPATH:$MLIR_BUILD_DIR/tools/mlir/python_packages/mlir_core
export PYTHONPATH=$PYTHONPATH:$PROJ_BUILD_DIR/python_packages/soda
```

Import soda libraries like this:

```python
from mlir_soda.ir import *
from mlir_soda.dialects import (
  builtin as builtin_d,
  soda as soda_d
)
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

# Publications

[IEEE Micro 2022 (Early Access)](https://ieeexplore.ieee.org/abstract/document/9786533)

```
@ARTICLE{9786533,
  author={Bohm Agostini, Nicolas and Curzel, Serena and Zhang, Jeff and Limaye, Ankur and Tan, Cheng and Amatya, Vinay and Minutoli, Marco and Castellana, Vito Giovanni and Manzano, Joseph and Brooks, David and Wei, Gu-Yeon and Tumeo, Antonino},
  journal={IEEE Micro}, 
  title={Bridging Python to Silicon: The SODA Toolchain}, 
  year={2022},
  doi={10.1109/MM.2022.3178580}}
```

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
