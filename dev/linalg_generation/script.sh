# [onnx-mlir -> mhlo ]
onnx-mlir-opt -O3 --convert-onnx-to-mhlo gemmreluadd.onnx.mlir > gemmreluadd.mhlo.mlir

# [mhlo -> linalg]
iree-build/tools/iree-opt --iree-mhlo-to-linalg-on-tensors gemmreluadd.mhlo.mlir > gemmreluadd.linalg.mlir

mlir-opt --linalg-fuse-elementwise-ops gemmreluadd.linalg.mlir > gemmreluadd.linalg.fused.mlir

# [linalg transformation]
mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse gemmreluadd.linalg.fused.mlir > gemmreluadd.linalg.finalized.mlir
