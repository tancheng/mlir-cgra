// RUN: soda-opt -soda-async-region %s | FileCheck %s

// CHECK: module attributes {soda.container_module}
module attributes {soda.container_module} {

  soda.module @kernels {
    soda.func @kernel() kernel { soda.return }
  }

  func.func private @foo() -> ()

  // CHECK-LABEL:func.func @async(%{{.*}}: index)
  func.func @async(%sz : index) {
    // CHECK: %[[t0:.*]] = soda.wait async
    // CHECK: %[[t1:.*]] = soda.launch_func async [%[[t0]]]
    soda.launch_func @kernels::@kernel
    // CHECK: %[[t2:.*]] = soda.launch_func async [%[[t1]]]
    soda.launch_func @kernels::@kernel
    // CHECK: soda.wait [%[[t2]]]
    // CHECK: call @foo
    call @foo() : () -> ()
    return
  }
}
