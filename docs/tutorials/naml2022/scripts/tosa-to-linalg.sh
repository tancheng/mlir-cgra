#!/bin/bash

docker run -u $(id -u):$(id -g) -v $(pwd):/working_dir --rm soda/soda \
mlir-opt \
--tosa-to-standard \
--tosa-to-linalg \
--canonicalize \
--tensor-constant-bufferize \
--func-bufferize \
--linalg-bufferize \
--tensor-bufferize \
--buffer-results-to-out-params \
--canonicalize -cse \
$1 \
-o $2



# --linalg-generalize-named-ops \