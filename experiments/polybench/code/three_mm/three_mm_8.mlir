func.func @three_mm_8(
                  %E: memref<8x8xf32>, 
                  %A: memref<8x8xf32>, 
                  %B: memref<8x8xf32>,
                  %F: memref<8x8xf32>,
                  %C: memref<8x8xf32>, 
                  %D: memref<8x8xf32>,
                  %G: memref<8x8xf32>
  ) {
  affine.for %n = 0 to 1 {
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %c0 = arith.constant 0.0 : f32
      affine.store %c0, %E[%i, %j] : memref<8x8xf32>
      affine.for %k = 0 to 8 {
        %2 = affine.load %A[%i, %k] : memref<8x8xf32>
        %3 = affine.load %B[%k, %j] : memref<8x8xf32>
        %4 = affine.load %E[%i, %j] : memref<8x8xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %E[%i, %j] : memref<8x8xf32>
      }
    }
  }
  
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %c0 = arith.constant 0.0 : f32
      affine.store %c0, %F[%i, %j] : memref<8x8xf32>
      affine.for %k = 0 to 8 {
        %2 = affine.load %C[%i, %k] : memref<8x8xf32>
        %3 = affine.load %D[%k, %j] : memref<8x8xf32>
        %4 = affine.load %F[%i, %j] : memref<8x8xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %F[%i, %j] : memref<8x8xf32>
      }
    }
  }
  
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %c0 = arith.constant 0.0 : f32
      affine.store %c0, %G[%i, %j] : memref<8x8xf32>
      affine.for %k = 0 to 8 {
        %2 = affine.load %E[%i, %k] : memref<8x8xf32>
        %3 = affine.load %F[%k, %j] : memref<8x8xf32>
        %4 = affine.load %G[%i, %j] : memref<8x8xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %G[%i, %j] : memref<8x8xf32>
      }
    }
  }
  }
  return
}
