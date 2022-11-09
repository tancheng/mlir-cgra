#!/bin/bash

# USAGE
#  ./<file-name>.sh <kernel size>

# Definition
#  Calls the scripts to perform soda-opt compilation and bambu synthesis

if [ $# -ne 1 ]; then
    echo "This script requires exactly one argument."
    echo "usage:"
    echo "   $0 <kernel size>"
    exit -1
fi

# Kernel configs
NAME=three_mm
KSIZE=$1

# Getting the kernel directory
KERNELDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/..

# Bambu configs
source ${KERNELDIR}/../../scripts/bambu-config-values-openroad.sh

# Load debug flags for bambu
source ${KERNELDIR}/../../scripts/bambu-debug-flags-openroad.sh

# Execute
source ${KERNELDIR}/../../scripts/outline-affine_for-opt_none_openroad-bambu-soft_float-no_ssdcs.sh