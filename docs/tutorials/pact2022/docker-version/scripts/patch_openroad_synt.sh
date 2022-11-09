#!/bin/bash

# This file is supposed to be executed after bambu targeting a openroad device

cp ${SCRIPTDIR}/to_copy/${PLATFORM}_config.mk ${BAMBUDIR}/config.mk
sed -i "s/kernelname/${KERNELNAME}/g" ${BAMBUDIR}/config.mk
cp ${SCRIPTDIR}/to_copy/synthesize_Synthesis_kernelname.sh ${BAMBUDIR}/synthesize_Synthesis_${KERNELNAME}.sh
sed -i "s/platformname/${PLATFORM}/g" ${BAMBUDIR}/synthesize_Synthesis_${KERNELNAME}.sh
cp ${SCRIPTDIR}/to_copy/${PLATFORM}_constraints.sdc ${BAMBUDIR}/HLS_output/Synthesis/${PLATFORM}_constraints.sdc 
sed -i "s/kernelname/${KERNELNAME}/g" ${BAMBUDIR}/HLS_output/Synthesis/${PLATFORM}_constraints.sdc 
