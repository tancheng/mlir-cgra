func @gesummv_4(%alpha: f32, %beta: f32, %A: memref<4x4xf32>, %B: memref<4x4xf32>, %tmp: memref<4xf32>, %x: memref<4xf32>, %y: memref<4xf32>) {
  affine.for %i = 0 to 4 {
    affine.for %j = 0 to 4 {
      %0 = affine.load %A[%i, %j] : memref<4x4xf32>
      %1 = affine.load %x[%j] : memref<4xf32>
      %2 = affine.load %tmp[%i] : memref<4xf32>
      %3 = arith.mulf %0, %1 : f32
      %4 = arith.addf %2, %3 : f32
      affine.store %4, %tmp[%i] : memref<4xf32>
      %5 = affine.load %B[%i, %j] : memref<4x4xf32>
      %6 = affine.load %x[%j] : memref<4xf32>
      %7 = affine.load %y[%i] : memref<4xf32>
      %8 = arith.mulf %5, %6 : f32
      %9 = arith.addf %7, %8 : f32
      affine.store %9, %y[%i] : memref<4xf32>
    }
    %10 = affine.load %tmp[%i] : memref<4xf32>
    %11 = affine.load %y[%i] : memref<4xf32>
    %12 = arith.mulf %alpha, %10 : f32
    %13 = arith.mulf %beta, %11 : f32
    %14 = arith.addf %12, %13 : f32
    affine.store %14, %y[%i] : memref<4xf32>
  }
  return
}
