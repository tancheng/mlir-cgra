add_mlir_dialect(SODAOps soda)
add_mlir_doc(SODAOps SODAOps Dialects/ -gen-op-doc )

set(LLVM_TARGET_DEFINITIONS SODABase.td)
mlir_tablegen(SODAOpInterfaces.h.inc -gen-op-interface-decls)
mlir_tablegen(SODAOpInterfaces.cpp.inc -gen-op-interface-defs)
add_public_tablegen_target(MLIRSODAOpInterfacesIncGen)

set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name SODA)
add_public_tablegen_target(MLIRSODAPassIncGen)

set(LLVM_TARGET_DEFINITIONS SODAOps.td)
mlir_tablegen(SODAOpsEnums.h.inc -gen-enum-decls)
mlir_tablegen(SODAOpsEnums.cpp.inc -gen-enum-defs)
add_public_tablegen_target(MLIRSODAOpsEnumsGen)

set(LLVM_TARGET_DEFINITIONS SODAOps.td)
mlir_tablegen(SODAOpsAttributes.h.inc -gen-attrdef-decls -attrdefs-dialect=soda)
mlir_tablegen(SODAOpsAttributes.cpp.inc -gen-attrdef-defs -attrdefs-dialect=soda)
add_public_tablegen_target(MLIRSODAOpsAttributesIncGen)

add_mlir_doc(Passes SODAPasses ./ -gen-pass-doc)
