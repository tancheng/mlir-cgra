#!/bin/bash

docker run -u $(id -u):$(id -g) -v $(pwd):/working_dir --rm agostini01/soda \
mlir-opt \
  -pass-pipeline="any( tosa-to-arith, tosa-to-linalg-named, tosa-to-linalg)" \
  --canonicalize \
  -convert-tensor-to-linalg \
  -linalg-init-tensor-to-alloc-tensor \
  -eliminate-alloc-tensors \
  -linalg-bufferize -arith-bufferize \
  -tensor-bufferize -func-bufferize \
  -finalizing-bufferize -buffer-deallocation \
  --buffer-results-to-out-params \
  --canonicalize -cse \
$1 \
-o $2
