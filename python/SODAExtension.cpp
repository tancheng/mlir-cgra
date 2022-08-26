//===- SODAExtension.cpp - Extension module -------------------------------===//

#include "soda-c/Dialect/SODA.h"
#include "mlir/Bindings/Python/PybindAdaptors.h"

namespace py = pybind11;
using namespace mlir::python::adaptors;

PYBIND11_MODULE(_sodaDialects, m) {
  //===--------------------------------------------------------------------===//
  // SODA dialect
  //===--------------------------------------------------------------------===//
  auto soda_m = m.def_submodule("soda");

  soda_m.def(
      "register_dialect",
      [](MlirContext context, bool load) {
        MlirDialectHandle handle = mlirGetDialectHandle__soda__();
        mlirDialectHandleRegisterDialect(handle, context);
        if (load) {
          mlirDialectHandleLoadDialect(handle, context);
        }
      },
      py::arg("context") = py::none(), py::arg("load") = true);
}
