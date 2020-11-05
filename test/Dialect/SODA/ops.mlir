// RUN: soda-opt -allow-unregistered-dialect %s | FileCheck %s

module attributes {soda.container_module} {

  // CHECK-LABEL:func @no_args(%{{.*}}: index)
  func @no_args(%sz : index) {
    // CHECK: soda.launch blocks(%{{.*}}, %{{.*}}, %{{.*}}) in (%{{.*}} = %{{.*}}, %{{.*}} = %{{.*}}, %{{.*}} = %{{.*}}) threads(%{{.*}}, %{{.*}}, %{{.*}}) in (%{{.*}} = %{{.*}}, %{{.*}} = %{{.*}}, %{{.*}} = %{{.*}})
    soda.launch blocks(%bx, %by, %bz) in (%grid_x = %sz, %grid_y = %sz, %grid_z = %sz)
               threads(%tx, %ty, %tz) in (%block_x = %sz, %block_y = %sz, %block_z = %sz) {
      // CHECK: soda.terminator
      soda.terminator
    }
    return
  }

  // CHECK-LABEL:func @args(%{{.*}}: index, %{{.*}}: index, %{{.*}}: f32, %{{.*}}: memref<?xf32, 1>) {
  func @args(%blk : index, %thrd : index, %float : f32, %data : memref<?xf32,1>) {
    // CHECK: soda.launch blocks(%{{.*}}, %{{.*}}, %{{.*}}) in (%{{.*}} = %{{.*}}, %{{.*}} = %{{.*}}, %{{.*}} = %{{.*}}) threads(%{{.*}}, %{{.*}}, %{{.*}}) in (%{{.*}} = %{{.*}}, %{{.*}} = %{{.*}}, %{{.*}} = %{{.*}})
    soda.launch blocks(%bx, %by, %bz) in (%grid_x = %blk, %grid_y = %blk, %grid_z = %blk)
               threads(%tx, %ty, %tz) in (%block_x = %thrd, %block_y = %thrd, %block_z = %thrd) {
      "use"(%float) : (f32) -> ()
      "use"(%data) : (memref<?xf32,1>) -> ()
      // CHECK: soda.terminator
      soda.terminator
    }
    return
  }

  soda.module @kernels {
    soda.func @kernel_1(%arg0 : f32, %arg1 : memref<?xf32, 1>) kernel {
      %tIdX = "soda.thread_id"() {dimension = "x"} : () -> (index)
      %tIdY = "soda.thread_id"() {dimension = "y"} : () -> (index)
      %tIdZ = "soda.thread_id"() {dimension = "z"} : () -> (index)

      %bDimX = "soda.block_dim"() {dimension = "x"} : () -> (index)
      %bDimY = "soda.block_dim"() {dimension = "y"} : () -> (index)
      %bDimZ = "soda.block_dim"() {dimension = "z"} : () -> (index)

      %bIdX = "soda.block_id"() {dimension = "x"} : () -> (index)
      %bIdY = "soda.block_id"() {dimension = "y"} : () -> (index)
      %bIdZ = "soda.block_id"() {dimension = "z"} : () -> (index)

      %gDimX = "soda.grid_dim"() {dimension = "x"} : () -> (index)
      %gDimY = "soda.grid_dim"() {dimension = "y"} : () -> (index)
      %gDimZ = "soda.grid_dim"() {dimension = "z"} : () -> (index)

      %sgId = soda.subgroup_id : index
      %numSg = soda.num_subgroups : index
      %SgSi = soda.subgroup_size : index

      %one = constant 1.0 : f32
      %sum = "another_op"(%one) : (f32) -> (f32)

      %width = constant 7 : i32
      %offset = constant 3 : i32
      // CHECK: soda.shuffle %{{.*}}, %{{.*}}, %{{.*}} xor : f32
      %shfl, %pred = soda.shuffle %arg0, %offset, %width xor : f32

      "soda.barrier"() : () -> ()

      "some_op"(%bIdX, %tIdX) : (index, index) -> ()
      %42 = load %arg1[%bIdX] : memref<?xf32, 1>
      soda.return
    }

    soda.func @kernel_2() kernel {
      soda.return
    }
  }

  func @foo() {
    %0 = "op"() : () -> (f32)
    %1 = "op"() : () -> (memref<?xf32, 1>)
    // CHECK: %{{.*}} = constant 8
    %cst = constant 8 : index

    // CHECK: soda.launch_func @kernels::@kernel_1 blocks in (%{{.*}}, %{{.*}}, %{{.*}}) threads in (%{{.*}}, %{{.*}}, %{{.*}}) args(%{{.*}} : f32, %{{.*}} : memref<?xf32, 1>)
    soda.launch_func @kernels::@kernel_1 blocks in (%cst, %cst, %cst) threads in (%cst, %cst, %cst) args(%0 : f32, %1 : memref<?xf32, 1>)

    // CHECK: soda.launch_func @kernels::@kernel_2 blocks in (%{{.*}}, %{{.*}}, %{{.*}}) threads in (%{{.*}}, %{{.*}}, %{{.*}})
    soda.launch_func @kernels::@kernel_2 blocks in (%cst, %cst, %cst) threads in (%cst, %cst, %cst)

    return
  }

  soda.module @soda_funcs {
    // CHECK-LABEL: soda.func @kernel_1({{.*}}: f32)
    // CHECK:       workgroup
    // CHECK:       private
    // CHECK:       attributes
    soda.func @kernel_1(%arg0: f32)
        workgroup(%arg1: memref<42xf32, 3>)
        private(%arg2: memref<2xf32, 5>, %arg3: memref<1xf32, 5>)
        kernel
        attributes {foo="bar"} {
      "use"(%arg1) : (memref<42xf32, 3>) -> ()
      "use"(%arg2) : (memref<2xf32, 5>) -> ()
      "use"(%arg3) : (memref<1xf32, 5>) -> ()
      soda.return
    }

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

    // CHECK-LABEL: @workgroup_only
    // CHECK:       workgroup({{.*}}: {{.*}})
    // CHECK:       {
    soda.func @workgroup_only() workgroup(%arg0: memref<42xf32, 3>) {
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
    } ) {soda.kernel, sym_name = "kernel_1", type = (f32, memref<?xf32>) -> (), workgroup_attributions = 1: i64} : () -> ()
  }

  func @async_token(%arg0 : !soda.async.token) -> !soda.async.token {
    // CHECK-LABEL: func @async_token({{.*}}: !soda.async.token)
    // CHECK: return {{.*}} : !soda.async.token
    return %arg0 : !soda.async.token
  }

  func @async_wait() {
    // CHECK-LABEL: func @async_wait
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
