set(LLVM_LINK_COMPONENTS
  Core
  Support
  nativecodegen
  native
  )

add_llvm_executable(mlir-runner
  mlir-runner.cpp
  )
llvm_update_compile_flags(mlir-runner)
target_link_libraries(mlir-runner PRIVATE
  MLIRAnalysis
  MLIRExecutionEngine
  MLIRIR
  MLIRJitRunner
  MLIRLLVMDialect  
  MLIRLLVMToLLVMIRTranslation
  MLIRParser
  MLIRTargetLLVMIRExport
  MLIRSupport
  )
