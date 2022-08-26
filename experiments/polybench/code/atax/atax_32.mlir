func.func @atax_32( 
              %A: memref<32x32xf32>, 
              %x: memref<32xf32>,
              %y: memref<32xf32>, 
              %tmp: memref<32xf32>
  ) {
  affine.for %n = 0 to 1 {

  affine.for %i = 0 to 32 {
      %c0 = arith.constant 0.0 : f32
      affine.store %c0, %y[%i] : memref<32xf32>
  }
  affine.for %i = 0 to 32 {
    %c0 = arith.constant 0.0 : f32
    affine.store %c0, %tmp[%i] : memref<32xf32>
    
    affine.for %j = 0 to 32 {
      %2 = affine.load %A[%i, %j] : memref<32x32xf32>
      %3 = affine.load %x[%j] : memref<32xf32>
      %4 = affine.load %tmp[%i] : memref<32xf32>
      %5 = arith.mulf %2, %3 : f32
      %6 = arith.addf %4, %5 : f32
      affine.store %6, %tmp[%i] : memref<32xf32>
    }
    
    affine.for %j = 0 to 32 {
      %2 = affine.load %A[%i, %j] : memref<32x32xf32>
      %3 = affine.load %tmp[%i] : memref<32xf32>
      %4 = affine.load %y[%j] : memref<32xf32>
      %5 = arith.mulf %2, %3 : f32
      %6 = arith.addf %4, %5 : f32
      affine.store %6, %y[%j] : memref<32xf32>
    }
  }
  }
  return
}
