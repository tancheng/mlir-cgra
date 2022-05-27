#!/bin/bash

# Verify that bambu and vivado are installed
command -v bambu >/dev/null 2>&1 || { echo >&2 "Warning: This script requires bambu installed locally. Place and route not performed."; exit 1; }

BAMBUDIR=output/$1
pushd $BAMBUDIR

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
  --xilinx-root=$2 \
  2>&1 | tee synth-log

popd