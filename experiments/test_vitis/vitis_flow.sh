#!/bin/bash

# Script to run VitisHLS on generated llvm IR files
# Must export XILINX license path prior to execution:
#    export XILINXD_LICENSE_FILE=XXXX@XXXX

PROJ_ROOT=/files0/extended/curz959/soda
SODA_OPT_NAME=soda-opt-vitis

# PROJ_ROOT=/working_dir
# SODA_OPT_NAME=soda-opt

# PROJ_ROOT=/files0/extended/bohm747/Development/soda
# SODA_OPT_NAME=soda-opt

LLVMDIR=$PROJ_ROOT/builds/llvm-project/build/bin
LIBDIR=$PROJ_ROOT/builds/$SODA_OPT_NAME/build/lib
SODAOPTDIR=$PROJ_ROOT/builds/$SODA_OPT_NAME/build/bin
HLS_PATH=/files0/extended/shared/HLS

KERNEL_NAME=atax_8
IN_MLIR=$KERNEL_NAME.mlir
TOP_NAME=${KERNEL_NAME}_kernel

$SODAOPTDIR/soda-opt \
  --convert-affine-for-to-soda \
  $IN_MLIR \
  -o $KERNEL_NAME.searched.mlir

$SODAOPTDIR/soda-opt \
  --soda-outline-bambu-code \
  $KERNEL_NAME.searched.mlir \
  -o $KERNEL_NAME.outlined.mlir

$SODAOPTDIR/soda-opt \
  --soda-generate-bambu-accelcode="no-aa" \
  $KERNEL_NAME.outlined.mlir \
  -o $KERNEL_NAME.isolated.mlir

# baseline
#$SODAOPTDIR/soda-opt --lower-all-to-llvm='use-bare-ptr-memref-call-conv' -reconcile-unrealized-casts $KERNEL_NAME.isolated.mlir -o $KERNEL_NAME.llvm.mlir

# optimized (not full pipeline)
$SODAOPTDIR/soda-opt -convert-linalg-to-affine-loops \
  -affine-loop-unroll="unroll-full" \
  -affine-loop-unroll="unroll-factor=2" \
  -affine-scalrep -cse \
  -lower-affine -convert-scf-to-cf -convert-memref-to-llvm \
  --convert-math-to-llvm --convert-math-to-libm \
  -arith-expand \
  -memref-expand \
  --convert-arith-to-llvm \
  -convert-std-to-llvm='use-bare-ptr-memref-call-conv' \
  -reconcile-unrealized-casts $KERNEL_NAME.isolated.mlir -o $KERNEL_NAME.llvm.mlir

$LLVMDIR/mlir-translate -mlir-to-llvmir $KERNEL_NAME.llvm.mlir -o $KERNEL_NAME.plain.ll

"${LLVMDIR}/opt" $KERNEL_NAME.plain.ll \
  -S \
  -enable-new-pm=0 \
  -strip-debug \
  -instcombine \
  -load "${LIBDIR}/VhlsLLVMRewriter.so" \
  -xlnname \
  -xlnanno -xlntop $TOP_NAME \
  -xlntbgen -xlntbdummynames="$KERNEL_NAME.dummy.c" \
  -xlntbtclnames="$KERNEL_NAME.run.tcl" \
  -xlnllvm="$KERNEL_NAME.opt.ll" -xlnpath=$HLS_PATH \
  > $KERNEL_NAME.opt.ll

# -xlnname is needed to rename basic blocks, function arguments, and values
# -xlnanno is needed to annotate the top function, requires -xlntop
# -xlntbgen creates TCL and testbench, requires -xlntbdummynames, -xlntbtclnames, -xlnllvm, -xlnpath

# other available phism options: -mem2arr -mem2ptr -xlnmath -strip-attr -xlnunroll -xlnarraypartition -subview  
#                                -xlnram2p -anno-noinline -xlnloopname -select-pointer

#not needed?
#export XILINX_LICENSE_FILE=2100@lion

export LD_LIBRARY_PATH=$HLS_PATH/ext/sqlite-3.28.0/lib/lnx64/:$LD_LIBRARY_PATH
source /opt/Xilinx/Vitis_HLS/2021.1/settings64.sh

vitis_hls $KERNEL_NAME.run.tcl

source /opt/Xilinx/Vivado/2021.1/settings64.sh
vivado -mode batch -nojournal -nolog -source extract_results.tcl -tclargs $KERNEL_NAME
