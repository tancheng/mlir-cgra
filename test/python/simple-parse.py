# RUN: %PYTHON %s | FileCheck %s

from mlir_soda.ir import *
from mlir_soda.dialects import (
  builtin as builtin_d,
  soda as soda_d
)

with Context():
  soda_d.register_dialect()
  module = Module.parse("""
    func private @krnl_kernel_krnl_kernel(memref<?xf32>, memref<?xf32>)
    func private @dummy() -> memref<?xf32>
    func @krnl(%arg0: memref<?xf32>) {
      soda.launch {
        %0 = call @dummy() : () -> memref<?xf32>
        call @krnl_kernel_krnl_kernel(%arg0, %0) : (memref<?xf32>, memref<?xf32>) -> ()
        soda.terminator
      }
      return
    }
    """)
  # CHECK: soda.launch
  print(str(module))
