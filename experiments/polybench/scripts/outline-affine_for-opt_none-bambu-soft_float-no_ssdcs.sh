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
ODIR=${KERNELDIR}/output/${KERNEL}/opt_none-soft_float-no_ssdcs
BAMBUDIR=${ODIR}/bambu
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
  ${SCRIPTDIR}/bambu-config-values.sh
  ${SCRIPTDIR}/bambu-debug-flags.sh
  ${SCRIPTDIR}/needs_rerun.sh
  ${SCRIPTDIR}/outline-affine_for-opt_none-bambu-soft_float-no_ssdcs.sh

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
  --soda-extract-arguments-to-xml=using-bare-ptr \
  ${ODIR}/06-01-searched.mlir \
  -o ${ODIR}/06-02-outlined.mlir

mv ${WORKDIR}/${KERNELNAME}_test.xml ${ODIR}/${KERNELNAME}_test.xml
mv ${WORKDIR}/${KERNELNAME}_interface.xml ${ODIR}/${KERNELNAME}_interface.xml

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
    -lower-affine -convert-scf-to-cf -convert-memref-to-llvm \
    --convert-math-to-llvm --convert-math-to-libm \
    -arith-expand \
    -memref-expand \
    --convert-arith-to-llvm \
    -convert-func-to-llvm=use-bare-ptr-memref-call-conv  \
    -reconcile-unrealized-casts \
    -o ${ODIR}/07-llvm.mlir \
    -mlir-print-ir-before-all 2>&1 | cat > ${ODIR}/06-04-intermediate.mlir

# Translate llvm.mlir to model.ll ##############################################
mlir-translate -opaque-pointers=0 \
  --mlir-to-llvmir \
  ${ODIR}/07-llvm.mlir \
  -o ${ODIR}/08-model.ll

# Remove debug info to make output file smaller ################################
opt-10 \
  --strip-debug -O2 \
  ${ODIR}/08-model.ll \
  -S -o ${ODIR}/model.ll


# ==============================================================================
# Bambu passes
# ==============================================================================

pushd ${BAMBUDIR}
bambu \
  ${BAMBUDEBUGFLAGS} \
  -lm --soft-float \
  --compiler=I386_CLANG10  \
  -O2 \
  --device=xc7vx690t-3ffg1930-VVD \
  --clock-period=${CLKPERIOD} --no-iob \
  --experimental-setup=BAMBU-BALANCED-MP \
  --channels-number=${CHANNELSNUMBER} \
  --memory-allocation-policy=ALL_BRAM \
  --disable-function-proxy \
  --generate-tb=${ODIR}/${KERNELNAME}_test.xml \
  --simulate --simulator=VERILATOR \
  --top-fname=${KERNELNAME} \
  ${ODIR}/model.ll 2>&1 | tee ${ODIR}/bambu-exec-log
popd

set +x
else
  echo "ALREADY COMPLETED (and did not rerun): ${KERNELDIR}/${FILENAME}"
fi