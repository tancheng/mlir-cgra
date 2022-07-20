//===- soda-translate.cpp ---------------------------------------*- C++ -*-===//
//===----------------------------------------------------------------------===//
//
// This is a command line utility that translates a file from/to MLIR using one
// of the registered translations.
//
//===----------------------------------------------------------------------===//

#include "mlir/InitAllTranslations.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Tools/mlir-translate/MlirTranslateMain.h"

int main(int argc, char **argv) {

  // Register translations here
  mlir::registerToLLVMIRTranslation();

  return failed(
      mlir::mlirTranslateMain(argc, argv, "SODA Translation Testing Tool"));
}
