# Here we create a single aggregate shared library with the parts of the CAPI
# that we want to bundle together. Then we link a simple C executable
# against it to demonstrate that it does have the fully self contained
# core MLIR library and our own SODA dialect.
add_mlir_aggregate(SODACAPITestLib
  SHARED
  EMBED_LIBS
  MLIRCAPIIR
  MLIRCAPIRegistration
  SODACAPI
)

add_llvm_executable(soda-capi-test
  soda-capi-test.c
)
llvm_update_compile_flags(soda-capi-test)
target_link_libraries(soda-capi-test
  PRIVATE SODACAPITestLib)
