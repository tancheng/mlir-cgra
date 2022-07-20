func.func @two_mm_8( %alpha: f32, 
              %beta: f32, 
              %tmp: memref<8x8xf32>, 
              %A: memref<8x8xf32>, 
              %B: memref<8x8xf32>,
              %C: memref<8x8xf32>, 
              %D: memref<8x8xf32>
  ) {
  affine.for %n = 0 to 1 {
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %c0 = arith.constant 0.0 : f32
      affine.store %c0, %tmp[%i, %j] : memref<8x8xf32>
      affine.for %k = 0 to 8 {
        %2 = affine.load %A[%i, %k] : memref<8x8xf32>
        %3 = affine.load %B[%k, %j] : memref<8x8xf32>
        %4 = affine.load %tmp[%i, %j] : memref<8x8xf32>
        %5 = arith.mulf %alpha, %2 : f32
        %6 = arith.mulf %5, %3 : f32
        %7 = arith.addf %4, %6 : f32
        affine.store %7, %tmp[%i, %j] : memref<8x8xf32>
      }
    }
  }
  
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %0 = affine.load %D[%i, %j] : memref<8x8xf32>
      %1 = arith.mulf %beta, %0 : f32
      affine.store %1, %D[%i, %j] : memref<8x8xf32>
      affine.for %k = 0 to 8 {
        %2 = affine.load %tmp[%i, %k] : memref<8x8xf32>
        %3 = affine.load %C[%k, %j] : memref<8x8xf32>
        %4 = affine.load %D[%i, %j] : memref<8x8xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %D[%i, %j] : memref<8x8xf32>
      }
    }
  }
  }
  return
}
