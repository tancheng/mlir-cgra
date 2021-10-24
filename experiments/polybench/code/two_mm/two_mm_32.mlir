func @two_mm_32( %alpha: f32, 
              %beta: f32, 
              %tmp: memref<32x32xf32>, 
              %A: memref<32x32xf32>, 
              %B: memref<32x32xf32>,
              %C: memref<32x32xf32>, 
              %D: memref<32x32xf32>
  ) {
  affine.for %n = 0 to 1 {
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      %c0 = constant 0.0 : f32
      affine.store %c0, %tmp[%i, %j] : memref<32x32xf32>
      affine.for %k = 0 to 32 {
        %2 = affine.load %A[%i, %k] : memref<32x32xf32>
        %3 = affine.load %B[%k, %j] : memref<32x32xf32>
        %4 = affine.load %tmp[%i, %j] : memref<32x32xf32>
        %5 = mulf %alpha, %2 : f32
        %6 = mulf %5, %3 : f32
        %7 = addf %4, %6 : f32
        affine.store %7, %tmp[%i, %j] : memref<32x32xf32>
      }
    }
  }
  
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      %0 = affine.load %D[%i, %j] : memref<32x32xf32>
      %1 = mulf %beta, %0 : f32
      affine.store %1, %D[%i, %j] : memref<32x32xf32>
      affine.for %k = 0 to 32 {
        %2 = affine.load %tmp[%i, %k] : memref<32x32xf32>
        %3 = affine.load %C[%k, %j] : memref<32x32xf32>
        %4 = affine.load %D[%i, %j] : memref<32x32xf32>
        %5 = mulf %2, %3 : f32
        %6 = addf %4, %5 : f32
        affine.store %6, %D[%i, %j] : memref<32x32xf32>
      }
    }
  }
  }
  return
}
