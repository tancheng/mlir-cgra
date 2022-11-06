onnx-mlir-opt -O3 --convert-onnx-to-mhlo 00-onnx.mlir > 01-mhlo.mlir
iree-opt --iree-mhlo-to-linalg-on-tensors 01-mhlo.mlir > 02-linalg.mlir
mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse 02-linalg.mlir > 03-finalized.mlir
soda-opt -lower-all-to-llvm 03-finalized.mlir > 04-llvm.mlir
mlir-translate --mlir-to-llvmir 04-llvm.mlir > 05-model.ll
llc -filetype=obj 05-model.ll
clang++-12 main.cpp 05-model.o -I../../../sim/ ../../../sim/*.cpp -o simulate
