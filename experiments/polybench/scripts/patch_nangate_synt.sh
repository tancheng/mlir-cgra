#!/bin/bash

# This file is supposed to be executed after bambu nangate synthesis by:
#  outline-affine_for-opt_none_nangate-bambu-soft_float-no_ssdcs.sh
#  outline-affine_for-opt_full_nangate-bambu-soft_float-no_ssdcs.sh
#  outline-affine_for-opt_nbt_nangate-bambu-soft_float-no_ssdcs.sh

cp ${SCRIPTDIR}/to_copy/config.mk ${BAMBUDIR}/config.mk
sed -i "s/kernelname/${KERNELNAME}/g" ${BAMBUDIR}/config.mk
cp ${SCRIPTDIR}/to_copy/synthesize_Synthesis_kernelname.sh ${BAMBUDIR}/synthesize_Synthesis_${KERNELNAME}.sh