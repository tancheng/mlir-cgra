# [onnx -> onnx-mlir] or choose any front-end framework (e.g., pytorch-mlir)
onnx-mlir --EmitONNXIR ./gemmreluadd.onnx
onnx-mlir-opt -O3 --convert-onnx-to-mhlo 00-onnx.mlir > 01-mhlo.mlir
iree-opt --iree-mhlo-to-linalg-on-tensors 01-mhlo.mlir > 02-linalg.mlir
