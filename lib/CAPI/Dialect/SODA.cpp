//===- SODAc.cpp - C Interface for SODA dialect ---------------------------===//

#include "soda-c/Dialect/SODA.h"

#include "soda/Dialect/SODA/SODADialect.h"
#include "mlir/CAPI/Registration.h"

MLIR_DEFINE_CAPI_DIALECT_REGISTRATION(SODA, soda, mlir::soda::SODADialect)