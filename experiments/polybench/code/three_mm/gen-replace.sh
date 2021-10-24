#!/bin/bash

# USAGE: gen-replace <path-to-file_16.mlir>
#
#  Uses a file that based on 16 and generates 2, 4, 8, 32 versions for it

KERNEL=three_mm
FILE=${KERNEL}_16.mlir

KSIZES=(
  2
  4
  8
  32
)

for K in "${KSIZES[@]}"; do
  cp $FILE ${KERNEL}_${K}.mlir
  sed -i "s/16/${K}/g" ${KERNEL}_${K}.mlir
done

cp -r ../gemm/scripts scripts

FILES="scripts/*.sh"

for F in $FILES; do
  sed -i "s/gemm/${KERNEL}/g" $F
done
