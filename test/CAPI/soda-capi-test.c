//===- soda-cap-demo.c - Simple demo of C-API -----------------------------===//

// RUN: soda-capi-test 2>&1 | FileCheck %s

#include <stdio.h>

#include "mlir-c/IR.h"
#include "soda-c/Dialect/SODA.h"

int main(int argc, char **argv) {
  MlirContext ctx = mlirContextCreate();
  // TODO: Create the dialect handles for the builtin dialects and avoid this.
  // This adds dozens of MB of binary size over just the standalone dialect.
  mlirRegisterAllDialects(ctx);
  mlirDialectHandleRegisterDialect(mlirGetDialectHandle__soda__(), ctx);

  MlirModule module = mlirModuleCreateParse(
      ctx,
      mlirStringRefCreateFromCString(
          "func.func private @krnl_kernel_krnl_kernel(memref<?xf32>, "
          "memref<?xf32>)\n"
          "func.func private @dummy() -> memref<?xf32>\n"
          "func.func @krnl(%arg0: memref<?xf32>) {\n"
          "  soda.launch {\n"
          "    %0 = func.call @dummy() : () -> memref<?xf32>\n"
          "    func.call @krnl_kernel_krnl_kernel(%arg0, %0) : (memref<?xf32>, "
          "memref<?xf32>) -> ()\n"
          "    soda.terminator\n"
          "  }\n"
          "  return\n"
          "}\n"));
  if (mlirModuleIsNull(module)) {
    printf("ERROR: Could not parse.\n");
    mlirContextDestroy(ctx);
    return 1;
  }
  MlirOperation op = mlirModuleGetOperation(module);

  // CHECK: soda.launch
  mlirOperationDump(op);

  mlirModuleDestroy(module);
  mlirContextDestroy(ctx);
  return 0;
}
