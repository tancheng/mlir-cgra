add_mlir_dialect_library(MLIRSODAOps
  IR/SODADialect.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/mlir/Dialect/SODA

  DEPENDS
  MLIRSODAOpsIncGen
  MLIRSODAOpsAttributesIncGen
  MLIRSODAOpsEnumsGen
  MLIRSODAOpInterfacesIncGen

  LINK_LIBS PUBLIC
  MLIRDLTIDialect
  MLIRIR
  MLIRMemRefDialect
  MLIRSideEffectInterfaces
  MLIRSupport
  )

add_mlir_dialect_library(MLIRSODATransforms

  Transforms/KernelOutlining.cpp
  Transforms/KernelGeneration.cpp
  Transforms/HostGeneration.cpp
  Transforms/AsyncRegionRewriter.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/soda/Dialect/SODA

  LINK_COMPONENTS
  Core
  MC

  DEPENDS
  MLIRSODAPassIncGen

  LINK_LIBS PUBLIC
  #MLIRAsync
  MLIRSODAOps
  MLIRIR
  MLIRPass
  MLIRSCFDialect
  MLIRFuncDialect
  MLIRSupport
  MLIRTransformUtils
  )
