// RUN: soda-opt -allow-unregistered-dialect %s | FileCheck %s

module attributes {soda.container_module} {

  // CHECK-LABEL:func @no_args(%{{.*}}: index)
  func.func @no_args(%sz : index) {
    // CHECK: soda.launch {
    soda.launch {
      // CHECK: soda.terminator
      soda.terminator
    }
    return
  }

  // CHECK-LABEL:func @args(%{{.*}}: index, %{{.*}}: index, %{{.*}}: f32, %{{.*}}: memref<?xf32, 1>) {
  func.func @args(%blk : index, %thrd : index, %float : f32, %data : memref<?xf32,1>) {
    // CHECK: soda.launch {
    soda.launch {
      "use"(%float) : (f32) -> ()
      "use"(%data) : (memref<?xf32,1>) -> ()
      // CHECK: soda.terminator
      soda.terminator
    }
    return
  }

  soda.module @kernels {
    // CHECK: soda.func @kernel_1
    soda.func @kernel_1(%arg0 : f32, %arg1 : memref<?xf32, 1>) kernel {

      %bIdX = arith.constant 1 : index
      %one = arith.constant 1.0 : f32
      %sum = "another_op"(%one) : (f32) -> (f32)

      %width = arith.constant 7 : i32
      %offset = arith.constant 3 : i32

      "soda.barrier"() : () -> ()

      %42 = memref.load %arg1[%bIdX] : memref<?xf32, 1>
      soda.return
    }

    // CHECK: soda.func @kernel_2
    soda.func @kernel_2() kernel {
      soda.return
    }
  }

  func.func @foo() {
    %0 = "op"() : () -> (f32)
    %1 = "op"() : () -> (memref<?xf32, 1>)
    // CHECK: %{{.*}} = arith.constant 8
    %cst = arith.constant 8 : index
    %t0 = soda.wait async

    // CHECK: soda.launch_func @kernels::@kernel_1 args(%{{.*}} : f32, %{{.*}} : memref<?xf32, 1>)
    soda.launch_func @kernels::@kernel_1 args(%0 : f32, %1 : memref<?xf32, 1>)

    // CHECK: soda.launch_func @kernels::@kernel_2
    soda.launch_func @kernels::@kernel_2
    
    // CHECK: %{{.*}} = soda.launch_func async [%{{.*}}] @kernels::@kernel_2
    %t1 = soda.launch_func async [%t0] @kernels::@kernel_2

    return
  }

  soda.module @soda_funcs {

    // CHECK-LABEL: soda.func @no_attribution
    // CHECK: {
    soda.func @no_attribution(%arg0: f32) {
      soda.return
    }

    // CHECK-LABEL: @no_attribution_attrs
    // CHECK:       attributes
    // CHECK:       {
    soda.func @no_attribution_attrs(%arg0: f32) attributes {foo="bar"} {
      soda.return
    }

    // CHECK-LABEL: @private_only
    // CHECK:       private({{.*}}: {{.*}})
    // CHECK:       {
    soda.func @private_only() private(%arg0: memref<2xf32, 5>) {
      soda.return
    }

    // CHECK-LABEL: @empty_attribution
    // CHECK:       {
    soda.func @empty_attribution(%arg0: f32) workgroup() private() {
      soda.return
    }
  }

  soda.module @explicit_attributions {
    // CHECK-LABEL: soda.func @kernel_1({{.*}}: f32, {{.*}}: memref<?xf32>) workgroup({{.*}}: memref<5xf32, 3>) private({{.*}}: memref<5xf32, 5>)
    "soda.func"() ( {
    ^bb0(%arg0: f32, %arg1: memref<?xf32>, %arg2: memref<5xf32, 3>, %arg3: memref<5xf32, 5>):
      "soda.return"() : () -> ()
    } ) {soda.kernel, sym_name = "kernel_1", function_type = (f32, memref<?xf32>) -> (), workgroup_attributions = 1: i64} : () -> ()
  }

  func.func @async_token(%arg0 : !soda.async.token) -> !soda.async.token {
    // CHECK-LABEL: func.func @async_token({{.*}}: !soda.async.token)
    // CHECK: return {{.*}} : !soda.async.token
    return %arg0 : !soda.async.token
  }

  func.func @async_wait() {
    // CHECK-LABEL: func.func @async_wait
    // CHECK: %[[t0:.*]] = soda.wait async
    %0 = soda.wait async
    // CHECK: %[[t1:.*]] = soda.wait async [%[[t0]]]
    %1 = soda.wait async [%0]
    // CHECK: %{{.*}} = soda.wait async [%[[t0]], %[[t1]]]
    %2 = soda.wait async [%0, %1]
    // CHECK: soda.wait [%[[t0]], %[[t1]]]
    // CHECK-NOT: async
    soda.wait [%0, %1]
    // CHECK: soda.wait
    // CHECK-NOT: async
    soda.wait // Valid, but a no-op.
    return
  }
}
