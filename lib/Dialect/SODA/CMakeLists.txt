add_mlir_dialect_library(MLIRSODA
  IR/SODADialect.cpp
  Transforms/KernelOutlining.cpp
  Transforms/KernelGeneration.cpp
  Transforms/HostGeneration.cpp
  Transforms/AsyncRegionRewriter.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/soda/Dialect/SODA

  DEPENDS
  MLIRSODAOpsIncGen
  MLIRSODAOpInterfacesIncGen
  MLIRSODAPassIncGen

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRLLVMIR
  MLIRSCF
  MLIRPass
  MLIRSideEffectInterfaces
  MLIRStandard
  MLIRSupport
  MLIRTransformUtils
  )
