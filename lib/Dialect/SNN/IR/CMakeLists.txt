add_mlir_dialect_library(MLIRSNNOps
  SNNDialect.cpp
  SNNOps.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/soda/Dialect/SNN

  DEPENDS
  MLIRSNNOpsIncGen
  #MLIRSNNOpInterfacesIncGen

  LINK_COMPONENTS
  Core

  LINK_LIBS PUBLIC
  MLIRDialectUtils
  MLIRIR
  MLIRTensorDialect
  MLIRInferTypeOpInterface
  MLIRSideEffectInterfaces
  MLIRSupport
  MLIRFuncDialect
  MLIRViewLikeInterface
  )
