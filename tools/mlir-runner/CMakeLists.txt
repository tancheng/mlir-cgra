set(LLVM_LINK_COMPONENTS
  Core
  Support
  nativecodegen
  )

get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(translation_libs GLOBAL PROPERTY MLIR_TRANSLATION_LIBS)

add_llvm_executable(mlir-runner
  mlir-runner.cpp
  )
llvm_update_compile_flags(mlir-runner)
target_link_libraries(mlir-runner
  PRIVATE
  ${dialect_libs}
  MLIRAnalysis
  MLIREDSC
  MLIRExecutionEngine
  MLIRIR
  MLIRJitRunner
  MLIRLLVMIR
  MLIRParser
  MLIRTargetLLVMIR
  MLIRSupport
  )

mlir_check_link_libraries(mlir-runner)