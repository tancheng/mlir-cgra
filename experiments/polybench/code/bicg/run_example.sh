#!/bin/bash

# USAGE
#  This file is supposed to be run in the same folder where it exists.

# Kernel configs
NAME=bicg
KSIZE=2

# Directories
KERNELDIR=$(pwd)

# Bambu configs
CLKPERIOD=10
CHANNELSNUMBER=2

# Load debug flags for bambu
source ${KERNELDIR}/../../scripts/bambu-debug-flags.sh

# Perform the synthesis
# source ${KERNELDIR}/../../scripts/outline-affine_for-opt_full-bambu-flopoco.sh

# With SSDCS
source ${KERNELDIR}/../../scripts/outline-affine_for-opt_full-bambu-soft_float-with_ssdcs.sh
source ${KERNELDIR}/../../scripts/outline-affine_for-opt_none-bambu-soft_float-with_ssdcs.sh

# NO SSDCS
source ${KERNELDIR}/../../scripts/outline-affine_for-opt_full-bambu-soft_float-no_ssdcs.sh
source ${KERNELDIR}/../../scripts/outline-affine_for-opt_none-bambu-soft_float-no_ssdcs.sh