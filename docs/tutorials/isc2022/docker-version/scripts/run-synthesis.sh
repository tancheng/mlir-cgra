#!/bin/bash

BAMBUDIR=output/$1
pushd $BAMBUDIR


# TODO - Make sure xilinx path exists

bambu \
  -v3 \
  --print-dot -lm --soft-float \
  --compiler=I386_CLANG10 \
  -O2 \
  --device-name=xc7vx690t-3ffg1930-VVD \
  --clock-period=5 --no-iob \
  --experimental-setup=BAMBU-BALANCED-MP \
  --channels-number=2 \
  --memory-allocation-policy=ALL_BRAM \
  --disable-function-proxy \
  --generate-tb=main_kernel_test.xml \
  --simulate \
  --simulator=VERILATOR \
  --evaluation \
  --top-fname=main_kernel input.ll \
  --xilinx-root=/files0/Xilinx/Vivado/2020.2 \
  2>&1 | tee synth-log

popd