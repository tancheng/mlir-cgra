add_mlir_conversion_library(SODAKERNELToSODA
  SCFToSODA.cpp
  SCFToSODAPass.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/soda/Conversion/KernelsToSODA
  ${PROJ_INCLUDE_DIR}/soda/Dialect/SODA

  DEPENDS
  SODAConversionPassIncGen

  LINK_LIBS PUBLIC
  MLIRAffine
  MLIRAffineToStandard
  MLIRGPU
  MLIRIR
  MLIRLinalg
  MLIRPass
  MLIRStandard
  MLIRSupport
  MLIRTransforms
  )
