add_mlir_dialect(SODAOps soda)
add_mlir_doc(SODAOps -gen-op-doc SODAOps Dialects/)

set(LLVM_TARGET_DEFINITIONS SODABase.td)
mlir_tablegen(SODAOpInterfaces.h.inc -gen-op-interface-decls)
mlir_tablegen(SODAOpInterfaces.cpp.inc -gen-op-interface-defs)
add_public_tablegen_target(MLIRSODAOpInterfacesIncGen)

set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name SODA)
add_public_tablegen_target(MLIRSODAPassIncGen)

add_mlir_doc(Passes -gen-pass-doc SODAPasses ./)