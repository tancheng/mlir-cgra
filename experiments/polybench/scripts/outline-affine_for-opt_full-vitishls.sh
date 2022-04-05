#!/bin/bash

# USAGE
#   This file is supposed to be sourced from a file that includes the following
#   run configurations.

####
# # Kernel configs
# NAME=bicg
# KSIZE=2

# # Directories
# KERNELDIR=$(pwd)

# # Bambu configs
# CLKPERIOD=10
# CHANNELSNUMBER=2

# source ${KERNELDIR}/../../../scripts/<name-of-this-file>.sh
####

KERNEL=${NAME}_${KSIZE}
FILENAME=${KERNEL}.mlir
KERNELNAME=${KERNEL}_kernel

# Directories
WORKDIR=$(pwd)
ODIR=${KERNELDIR}/output/${KERNEL}/opt_full-vitishls
BAMBUDIR=${ODIR}/vitishls
SCRIPTDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Bambu configs
CLKPERIOD=${CLKPERIOD}
CHANNELSNUMBER=${CHANNELSNUMBER}

# Preparing folders
mkdir -p ${BAMBUDIR}
mkdir -p ${ODIR}

# Decide if needs rerun
source ${SCRIPTDIR}/needs_rerun.sh

LIST1=(
  # Generic compilation scripts
  ${SCRIPTDIR}/vitishls-config-values.sh
  ${SCRIPTDIR}/needs_rerun.sh
  ${SCRIPTDIR}/outline-affine_for-opt_full-vitishls.sh

  # Kernel Specific
  ${KERNELDIR}/${FILENAME}
)
  
LIST2=(
  # Output files of the kernel
  ${ODIR}/model.ll
  ${BAMBUDIR}/results.txt
)

RERUN=false
needs_rerun LIST1 LIST2

if [ "$RERUN" = true ]; then

# Uncomment to see commands
set -x 

# ==============================================================================
# SODA Search, Outiline
# ==============================================================================

# Mark region with soda.launch ############################################
soda-opt \
  --convert-affine-for-to-soda \
  ${KERNELDIR}/${FILENAME} \
  -o ${ODIR}/06-01-searched.mlir

# Outline region inside soda.launch ############################################
soda-opt \
  --soda-outline-bambu-code \
  ${ODIR}/06-01-searched.mlir \
  -o ${ODIR}/06-02-outlined.mlir

# # Isolate the outlined region in a separate file ###############################
soda-opt \
  -soda-generate-bambu-accelcode=no-aa \
  ${ODIR}/06-02-outlined.mlir \
  -o ${ODIR}/06-03-isolated.mlir

# ==============================================================================
# These can be replaced by - soda-opt --soda-opt-pipeline
# ==============================================================================
# Optimize the isolated code
soda-opt \
    ${ODIR}/06-03-isolated.mlir \
    -convert-linalg-to-affine-loops \
    --soda-opt-pipeline-for-bambu=use-bare-ptr-memref-call-conv \
    -reconcile-unrealized-casts \
    -o ${ODIR}/07-llvm.mlir \
    -print-ir-before-all 2>&1 | cat > ${ODIR}/06-04-intermediate.mlir

# Translate llvm.mlir to model.ll ##############################################
mlir-translate \
  --mlir-to-llvmir \
  ${ODIR}/07-llvm.mlir \
  -o ${ODIR}/08-model.ll

cp ${ODIR}/08-model.ll ${ODIR}/model.ll

# ==============================================================================
# Vitis passes
# ==============================================================================

pushd ${BAMBUDIR}

opt ${ODIR}/model.ll \
  -S \
  -enable-new-pm=0 \
  -strip-debug \
  -instcombine \
  -load "${LIBDIR}/VhlsLLVMRewriter.so" \
  -xlnname \
  -xlnanno -xlntop $KERNELNAME \
  -xlntbgen -xlntbdummynames="$KERNELNAME.dummy.c" \
  -xlntbtclnames="$KERNELNAME.run.tcl" \
  -xlnllvm="$KERNELNAME.opt.ll" -xlnpath=$HLS_PATH \
  > $KERNELNAME.opt.ll

export LD_LIBRARY_PATH=$HLS_PATH/ext/sqlite-3.28.0/lib/lnx64/:$LD_LIBRARY_PATH
source /opt/Xilinx/Vitis_HLS/2021.1/settings64.sh

vitis_hls $KERNELNAME.run.tcl

source /opt/Xilinx/Vivado/2021.1/settings64.sh
vivado -mode batch -nojournal -nolog -source extract_results.tcl -tclargs $KERNELNAME

popd

set +x
else
  echo "ALREADY COMPLETED (and did not rerun): ${KERNELDIR}/${FILENAME}"
fi