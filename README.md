<pre>
========================================================
    __  _____    ________        ________________  ___ 
   /  |/  / /   /  _/ __ \      / ____/ ____/ __ \/   |
  / /|_/ / /    / // /_/ /_____/ /   / / __/ /_/ / /| |
 / /  / / /____/ // _, _/_____/ /___/ /_/ / _, _/ ___ |
/_/  /_/_____/___/_/ |_|      \____/\____/_/ |_/_/  |_|
                                                       
========================================================
</pre>
[![Github Action](https://github.com/tancheng/mlir-cgra/actions/workflows/main.yml/badge.svg)](https://github.com/tancheng/mlir-cgra/actions/workflows/main.yml)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

MLIR-CGRA is an MLIR dialect to enable the efficient acceleration of ML model on CGRAs.


Docker
--------------------------------------------------------
The docker image is available [here](https://hub.docker.com/repository/docker/cgra/mlir-cgra/general). Development can be performed in the container:
```sh
 docker pull cgra/mlir-cgra:demo
 docker run -it cgra/mlir-cgra:demo

 # Setup the environment once you are in the container:
 source /setup.sh
```


Execution
--------------------------------------------------------
In this repository, we provide scripts for 1 demo and 4 ML models (CamemBERT/MiniLM/SENTENCE-BERT/VIT).

To run the demo:

```sh
# baseline
cd experiments/demo/baseline

# all the scripts assume you have clang-12 and opt-12 installed and
# both the mlir-opt and soda-opt are added into $PATH
sh script.sh
./simulate

# enable optimization
cd ../cgra
sh script.sh
./simulate
```
Note that the input is generated from `experiments/demo/model`, which requires `onnx-mlir` and `iree`. You can also play with the other front-end (e.g., torch-mlir, xla, mhlo) and it would work as long as the front-ends can lower the model into linalg dialect.

To run a MiniLM model:

```sh
cd experiments/MiniLM/model

# This step requires transformers, torch, and torch-mlir
python3.9 MiniLM.py

# mv the generated linalg.mlir into different folder (baseline or cgra) for evaluation
mv 02-linalg.mlir ../cgra/. && cd ../cgra

# there are multiple scripts indicating different configuration of the target CGRAs
sh script4x4.sh
./simulate
```


Installation
--------------------------------------------------------
In stead of using docker, you can build the required LLVM and MLIR manually. The current version of this project was tested with `llvm-project` commit:
`99020b3c73c1e22fa388be8fd0c44391d40b3a38`. Make sure you have the correct commit checked-out.

**Note**: Make sure to pass `-DLLVM_INSTALL_UTILS=ON` when building LLVM/MLIR with CMake so that it installs `FileCheck`.

To build LLVM, execute:
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
   -DLLVM_ENABLE_ASSERTIONS=ON \
   -DLLVM_INSTALL_UTILS=ON

# Run tests
cmake --build . --target check-mlir
```

Once you have built LLVM and MLIR in `$BUILD_DIR` and
installed it to `$PREFIX` (set both vars as "path/llvm-project/build"), to build mlir-cgra, go into the folder of this repo (`cd /path/mlir-cgra`) and execute:

```sh
mkdir build && cd build
cmake -G Ninja .. \
    -DLLVM_EXTERNAL_LIT=$BUILD_DIR/bin/llvm-lit \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir

# Run tests
cmake --build . --target check-soda
```

MLIR-CGRA leverages torch/torch-mlir/onnx-mlir as the front-ends to lower the (Hugging Face) models. You need to install the corresponding torch/torchmlir package in a specific version.
Pytorch version: `1.14.0.dev20221014+cpu`
torchmlir version: `20221015.627`
download link: `https://github.com/llvm/torch-mlir/releases/tag/snapshot-20221015.627`

```sh
# download the correspoding version || depends on your python version
# Here is for python 3.9
wget https://github.com/llvm/torch-mlir/releases/download/snapshot-20221015.627/torch-1.14.0.dev20221014+cpu-cp39-cp39-linux_x86_64.whl
wget https://github.com/llvm/torch-mlir/releases/download/snapshot-20221015.627/torch_mlir-20221015.627-cp39-cp39-linux_x86_64.whl

# install the packages
pip3.9 install torch-1.14.0.dev20221014+cpu-cp39-cp39-linux_x86_64.whl
pip3.9 install torch_mlir-20221015.627-cp39-cp39-linux_x86_64.whl

# install transformers
pip3.9 install transformers
```


Citation
--------------------------------------------------------------------------
- _"ML-CGRA: An Integrated Compilation Framework to Enable Efficient Machine Learning Acceleration on CGRAs."_ Yixuan Luo*, Cheng Tan*, Nicolas Bohm Agostini, Antonino Tumeo, Nirav Dave, Ang Li, Tong Geng. 60th ACM/IEEE Design Automation Conference (DAC), July 2023.


License
--------------------------------------------------------------------------

CGRA-Flow is offered under the terms of the Open Source Initiative BSD 3-Clause License. More information about this license can be found here:

  - http://choosealicense.com/licenses/bsd-3-clause
  - http://opensource.org/licenses/BSD-3-Clause

