llvm_canonicalize_cmake_booleans(
        MLIR_ENABLE_BINDINGS_PYTHON
)

configure_lit_site_cfg(
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.site.cfg.py.in
        ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
        MAIN_CONFIG
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.cfg.py
)

set(SODA_TEST_DEPENDS
        FileCheck count not
        soda-opt
        soda-translate
        soda-capi-test
        mlir-runner
        AllocaNamer
        XMLWriter
        VhlsLLVMRewriter
        )

if(MLIR_ENABLE_BINDINGS_PYTHON)
        list(APPEND SODA_TEST_DEPENDS SODAPythonModules)
endif()

add_lit_testsuite(check-soda "Running the soda-opt regression tests"
        ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${SODA_TEST_DEPENDS}
        )
set_target_properties(check-soda PROPERTIES FOLDER "Tests")

add_lit_testsuites(SODA_OPT ${CMAKE_CURRENT_SOURCE_DIR} DEPENDS ${SODA_TEST_DEPENDS})

add_subdirectory(CAPI)
