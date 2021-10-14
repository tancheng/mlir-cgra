#!/bin/bash

# USAGE
#  This file is supposed to be run in the same folder where it exists.

# Kernel configs
NAME=gesummv

KS=("2" "4" "8")
# CN=("2" "4")
CN=("2")
 
for x in "${KS[@]}"
do
	for y in "${CN[@]}"
	do
    KSIZE=$x

    # Directories
    KERNELDIR=$(pwd)

    # Bambu configs
    CLKPERIOD=10
    CHANNELSNUMBER=$y

    # Load debug flags for bambu
    source ${KERNELDIR}/../../scripts/bambu-debug-flags.sh

    # Perform the synthesis

    # FLOPOCO
    # source ${KERNELDIR}/../../scripts/outline-affine-for-optimize-full-bambu-flopoco.sh

    # SOFT-FLOAT
    # With SSDCS
    source ${KERNELDIR}/../../scripts/outline-affine-for-optimize-full-bambu-soft-float-with-ssdcs.sh
    source ${KERNELDIR}/../../scripts/outline-affine-for-optimize-none-bambu-soft-float-with-ssdcs.sh

    # NO SSDCS
    source ${KERNELDIR}/../../scripts/outline-affine-for-optimize-full-bambu-soft-float-no-ssdcs.sh
    source ${KERNELDIR}/../../scripts/outline-affine-for-optimize-none-bambu-soft-float-no-ssdcs.sh
  done
done