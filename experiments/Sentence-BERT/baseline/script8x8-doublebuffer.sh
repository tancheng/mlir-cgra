# perform operation fusion
mlir-opt --linalg-fuse-elementwise-ops 02-linalg.mlir > 03-fused.mlir

# perform finalization
mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse 03-fused.mlir > 04-finalized.mlir

# perform tiling
soda-opt --linalg-tiling-for-cgra=cgra-configs=8,8,2048,2048,2048,2048 04-finalized.mlir > 05-tiled-8.mlir

# locating target operations that will be offloaded onto CGRA
soda-opt --convert-linalg-matmul-to-cgra --convert-linalg-batch_matmul-to-cgra --convert-linalg-generic-to-cgra 05-tiled-8.mlir > 06-locating-8.mlir

# offload operations onto CGRA
soda-opt -outline-cgra-code -generate-cgra-hostcode 06-locating-8.mlir > 07-host-8.mlir

# generate CGRA accelerated code (conventional way)
soda-opt -outline-cgra-code -generate-cgra-accelcode 06-locating-8.mlir > 08-accel-8.mlir

# lower to llvm mlir
soda-opt -lower-all-to-llvm 07-host-8.mlir > 09-host-llvm-8.mlir
soda-opt -lower-all-to-llvm 08-accel-8.mlir > 10-accel-llvm-8.mlir

# tailor the generated llvm mlir (i.e., remove redundant func declarations)
python ../../../tools/removeRedundantDeclares.py 09-host-llvm-8.mlir > 09-host-tailored-8.mlir

# lower to llvm ir
mlir-translate --mlir-to-llvmir 09-host-tailored-8.mlir > 11-model-8.ll
mlir-translate --mlir-to-llvmir 10-accel-llvm-8.mlir > 12-accel-8.ll

# generate obj
llc -filetype=obj 11-model-8.ll
llc -filetype=obj 12-accel-8.ll

# generate the CustomizedRuntime.cpp
python ../../../tools/generateCustomizedRuntime.py 08-accel-8.mlir > CustomizedRuntime-8.cpp

# compile for simulation
clang++-12 main.cpp 11-model-8.o 12-accel-8.o ../../../../llvm-project/build/lib/libmlir_c_runner_utils.so CustomizedRuntime-8.cpp -I../../../sim/ ../../../sim/*.cpp -o simulate_8

./simulate_8 8 true true


# run CGRA-Mapper to get the execution cycles for each generic kernel, and register in the simulator
# not necessary for now
# llvm-as 12-accel.ll
# opt -load ../build/src/libmapperPass.so -mapperPass 12-accel.bc
