# perform operation fusion
mlir-opt --linalg-fuse-elementwise-ops 02-linalg.mlir > 03-fused.mlir

# perform finalization
mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse 03-fused.mlir > 04-finalized.mlir

# perform tiling
soda-opt --linalg-tiling-for-cgra=cgra-configs=4,4,1024,1024,1024,1024 04-finalized.mlir > 05-tiled.mlir

# locating target operations that will be offloaded onto CGRA
soda-opt --convert-linalg-matmul-to-cgra --convert-pattern-to-cgra=target-patterns="add-max-add" 05-tiled.mlir > 06-locating.mlir

# offload operations onto CGRA
soda-opt -outline-cgra-code -generate-cgra-hostcode 06-locating.mlir > 07-host.mlir

# lower to llvm mlir
soda-opt -lower-all-to-llvm 07-host.mlir > 08-llvm.mlir

# lower to llvm ir
mlir-translate --mlir-to-llvmir 08-llvm.mlir > 09-model.ll

# generate obj
llc -filetype=obj 09-model.ll

# compile for simulation
clang++-12 main.cpp 09-model.o -I../../../sim/ ../../../sim/*.cpp -o simulate
