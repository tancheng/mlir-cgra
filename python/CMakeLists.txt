include(AddMLIRPython)

# Specifies that all MLIR packages are co-located under the `mlir_soda`
# top level package (the API has been embedded in a relocatable way).
# TODO: Add an upstream cmake param for this vs having a global here.
add_compile_definitions("MLIR_PYTHON_PACKAGE_PREFIX=mlir_soda.")


################################################################################
# Sources
################################################################################

declare_mlir_python_sources(SODAPythonSources)

declare_mlir_dialect_python_bindings(
  ADD_TO_PARENT SODAPythonSources
  ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/mlir_soda"
  TD_FILE dialects/SODAOps.td
  SOURCES
    dialects/soda.py
  DIALECT_NAME soda)

declare_mlir_python_extension(SODAPythonSources.Extension
  MODULE_NAME _sodaDialects
  ADD_TO_PARENT SODAPythonSources
  SOURCES
    SODAExtension.cpp
  EMBED_CAPI_LINK_LIBS
    SODACAPI
)

################################################################################
# Common CAPI
################################################################################

add_mlir_python_common_capi_library(SODAPythonCAPI
  INSTALL_COMPONENT SODAPythonModules
  INSTALL_DESTINATION python_packages/soda/mlir_soda/_mlir_libs
  OUTPUT_DIRECTORY "${MLIR_BINARY_DIR}/python_packages/soda/mlir_soda/_mlir_libs"
  RELATIVE_INSTALL_ROOT "../../../.."
  DECLARED_SOURCES
    SODAPythonSources
    MLIRPythonExtension.RegisterEverything
    MLIRPythonSources.Core
)

################################################################################
# Instantiation of all Python modules
################################################################################

add_mlir_python_modules(SODAPythonModules
  ROOT_PREFIX "${MLIR_BINARY_DIR}/python_packages/soda/mlir_soda"
  INSTALL_PREFIX "python_packages/soda/mlir_soda"
  DECLARED_SOURCES
    SODAPythonSources
    MLIRPythonExtension.RegisterEverything
    MLIRPythonSources
  COMMON_CAPI_LINK_LIBS
    SODAPythonCAPI
  )
