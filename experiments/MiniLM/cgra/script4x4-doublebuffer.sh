# perform operation fusion
mlir-opt --linalg-fuse-elementwise-ops 02-linalg.mlir > 03-fused.mlir

# perform finalization
mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse 03-fused.mlir > 04-finalized.mlir

# perform tiling
soda-opt --linalg-tiling-for-cgra=cgra-configs=4,4,512,512,512,512 04-finalized.mlir > 05-tiled-4.mlir

# locating target operations that will be offloaded onto CGRA
soda-opt --convert-linalg-matmul-to-cgra --convert-linalg-batch_matmul-to-cgra --convert-pattern-to-cgra=target-patterns="add-add","div-sub","add","mul-add","trunc-div-add" --convert-linalg-generic-to-cgra 05-tiled-4.mlir > 06-locating-4.mlir

# offload operations onto CGRA
soda-opt -outline-cgra-code -generate-cgra-hostcode 06-locating-4.mlir > 07-host-4.mlir

# generate CGRA accelerated code (for both conventional mapped kernels and user predefined kernels)
soda-opt -outline-cgra-code -generate-cgra-accelcode 06-locating-4.mlir > 08-accel-4.mlir

# lower to llvm mlir
soda-opt -lower-all-to-llvm 07-host-4.mlir > 09-host-llvm-4.mlir
soda-opt -lower-all-to-llvm 08-accel-4.mlir > 10-accel-llvm-4.mlir

# tailor the generated llvm mlir (i.e., remove redundant func declarations)
python ../../../tools/removeRedundantDeclares.py 09-host-llvm-4.mlir > 09-host-tailored-4.mlir

# lower to llvm ir
mlir-translate --mlir-to-llvmir 09-host-tailored-4.mlir > 11-model-4.ll
mlir-translate --mlir-to-llvmir 10-accel-llvm-4.mlir > 12-accel-4.ll

# generate obj
llc -filetype=obj 11-model-4.ll
llc -filetype=obj 12-accel-4.ll

# generate the CustomizedRuntime.cpp
python ../../../tools/generateCustomizedRuntime.py 08-accel-4.mlir > CustomizedRuntime-4.cpp

# compile for simulation
clang++-12 main.cpp 11-model-4.o 12-accel-4.o ../../../../llvm-project/build/lib/libmlir_c_runner_utils.so CustomizedRuntime-4.cpp -I../../../sim/ ../../../sim/*.cpp -o simulate4

./simulate4 4 true false
