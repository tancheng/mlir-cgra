#!/bin/bash

if [ -d output/$1 ] 
then
    rm -rf output/$1
    mkdir -p output/$1
else
    mkdir -p output/$1
fi

cp output/05$1.ll output/$1/input.ll
cp main_kernel_test.xml output/$1/main_kernel_test.xml

pushd output/$1;

docker run -u $(id -u):$(id -g) -v $(pwd):/working_dir --rm agostini01/soda \
opt -O2 -strip-debug input.ll \
  -S -o visualize.ll

docker run -u $(id -u):$(id -g) -v $(pwd):/working_dir --rm agostini01/soda \
bambu -v3 --print-dot \
  -lm --soft-float \
--compiler=I386_CLANG12  \
-O2 \
--device=nangate45 \
--clock-period=5 --no-iob \
--experimental-setup=BAMBU-BALANCED-MP \
--channels-number=2 \
--memory-allocation-policy=ALL_BRAM \
--disable-function-proxy \
--generate-tb=main_kernel_test.xml \
--simulate --simulator=VERILATOR \
--top-fname=main_kernel \
input.ll 2>&1 | tee bambu-log


popd

# Patch nangate
SCRIPTDIR=scripts
BAMBUDIR=output/$1
KERNELNAME=main_kernel
source ${SCRIPTDIR}/patch_nangate_synt.sh