set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name SNN)
add_public_tablegen_target(MLIRSNNTransformsIncGen)

add_mlir_doc(Passes SNNPasses ./ -gen-pass-doc)
