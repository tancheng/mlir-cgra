# perform operation fusion
mlir-opt --linalg-fuse-elementwise-ops 02-linalg.mlir > 03-fused.mlir

# perform finalization
mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse 03-fused.mlir > 04-finalized.mlir

# perform tiling
soda-opt --linalg-tiling-for-cgra=cgra-configs=4,4,1024,1024,1024,1024 04-finalized.mlir > 05-tiled.mlir

# locating target operations that will be offloaded onto CGRA
soda-opt --convert-linalg-matmul-to-cgra --convert-linalg-batch_matmul-to-cgra --convert-pattern-to-cgra=target-patterns="add-add" --convert-linalg-generic-to-cgra 05-tiled.mlir > 06-locating.mlir

# offload operations onto CGRA
soda-opt -outline-cgra-code -generate-cgra-hostcode 06-locating.mlir > 07-host.mlir

# lower to llvm mlir
soda-opt -lower-all-to-llvm 07-host.mlir > 09-host-llvm.mlir
soda-opt -lower-all-to-llvm 08-accel.mlir > 10-accel-llvm.mlir

# tailor the generated llvm mlir (i.e., remove redundant func declarations)
python ../../../tools/removeRedundantDeclares.py 09-host-llvm.mlir > 09-host-tailored.mlir

# lower to llvm ir
mlir-translate --mlir-to-llvmir 09-host-tailored.mlir > 11-model.ll
mlir-translate --mlir-to-llvmir 10-accel-llvm.mlir > 12-accel.ll

# generate obj
llc -filetype=obj 11-model.ll
llc -filetype=obj 12-accel.ll

# generate the CustomizedRuntime.cpp
python ../../../tools/generateCustomizedRuntime.py 08-accel.mlir > CustomizedRuntime.cpp

# compile for simulation
clang++-12 main.cpp 11-model.o 12-accel.o ../../../../llvm-project/build/lib/libmlir_c_runner_utils.so CustomizedRuntime.cpp -I../../../sim/ ../../../sim/*.cpp -o simulate
