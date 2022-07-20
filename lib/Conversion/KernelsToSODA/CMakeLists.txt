add_mlir_conversion_library(SODAKERNELToSODA
  SCFToSODA.cpp
  SCFToSODAPass.cpp
  
  LinalgToSODA.cpp
  LinalgToSODAPass.cpp
  
  OperationToSODA.cpp
  OperationToSODAPass.cpp
  
  AllToSODAPass.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/soda/Conversion/KernelsToSODA
  ${PROJ_INCLUDE_DIR}/soda/Dialect/SODA

  DEPENDS
  SODAConversionPassIncGen

  LINK_LIBS PUBLIC
  MLIRAffineDialect
  MLIRAffineToStandard
  MLIRIR
  MLIRLinalgDialect
  MLIRMemRefDialect
  MLIRPass
  MLIRFuncDialect
  MLIRSupport
  MLIRTransforms
  )
