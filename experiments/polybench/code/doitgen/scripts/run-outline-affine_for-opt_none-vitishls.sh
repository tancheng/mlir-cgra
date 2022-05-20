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
NAME=doitgen
KSIZE=$1

# Getting the kernel directory
KERNELDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/..

# vitishls configs
source ${KERNELDIR}/../../scripts/vitishls-config-values.sh

# Execute
source ${KERNELDIR}/../../scripts/outline-affine_for-opt_none-vitishls.sh