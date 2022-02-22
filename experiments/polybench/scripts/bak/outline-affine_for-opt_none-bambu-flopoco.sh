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

# Uncomment to see commands
set -x 

KERNEL=${NAME}_${KSIZE}
FILENAME=${KERNEL}.mlir
KERNELNAME=${KERNEL}_kernel

# Directories
ODIR=${KERNELDIR}/output/${KERNEL}
BAMBUDIR=${ODIR}/bambu

# Bambu configs
CLKPERIOD=${CLKPERIOD}
CHANNELSNUMBER=${CHANNELSNUMBER}

# Preparing folders
mkdir -p ${BAMBUDIR}
mkdir -p ${ODIR}


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

mv ${KERNELDIR}/${KERNELNAME}_test.xml ${ODIR}/${KERNELNAME}_test.xml
mv ${KERNELDIR}/${KERNELNAME}_interface.xml ${ODIR}/${KERNELNAME}_interface.xml

# # Isolate the outlined region in a separate file ###############################
soda-opt \
  -soda-generate-bambu-accelcode \
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
    -convert-std-to-llvm=use-bare-ptr-memref-call-conv  \
    -reconcile-unrealized-casts \
    -o ${ODIR}/07-llvm.mlir \
    -print-ir-before-all 2>&1 | cat > ${ODIR}/06-04-intermediate.mlir

# Translate llvm.mlir to model.ll ##############################################
mlir-translate \
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
  -lm --flopoco \
  --compiler=I386_CLANG10  \
  -O2 \
  --device=xc7z020-1clg484-VVD \
  --clock-period=${CLKPERIOD} --no-iob \
  --experimental-setup=BAMBU-BALANCED-MP -s \
  --channels-number=${CHANNELSNUMBER} \
  --memory-allocation-policy=ALL_BRAM \
  --disable-function-proxy \
  --generate-tb=${ODIR}/${KERNELNAME}_test.xml \
  --simulate --simulator=MODELSIM --mentor-root="/opt/modelsim_dlx" --mentor-optimizer=0 \
  --top-fname=${KERNELNAME} \
  --generate-interface=INFER --interface-xml-file=${ODIR}/${KERNELNAME}_interface.xml \
  ${ODIR}/model.ll 2>&1 | tee ${ODIR}/bambu-exec-log
popd

set +x