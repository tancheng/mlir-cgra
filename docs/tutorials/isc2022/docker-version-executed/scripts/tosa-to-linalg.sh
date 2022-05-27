#!/bin/bash

docker run -u $(id -u):$(id -g) -v $(pwd):/working_dir --rm agostini01/soda \
mlir-opt \
--tosa-to-standard \
--tosa-to-linalg-named \
--tosa-to-linalg \
--test-linalg-transform-patterns="test-generalize-pad-tensor" \
--canonicalize \
-linalg-bufferize -arith-bufferize \
-tensor-bufferize -func-bufferize -finalizing-bufferize -buffer-deallocation \
--buffer-results-to-out-params \
--canonicalize -cse \
$1 \
-o $2
