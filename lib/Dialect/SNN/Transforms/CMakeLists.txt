add_mlir_dialect_library(MLIRSNNTransforms
  Print.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/soda/Dialect/SNN/Transforms

  DEPENDS
  MLIRSNNTransformsIncGen

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRPass
  MLIRTransforms
  )
