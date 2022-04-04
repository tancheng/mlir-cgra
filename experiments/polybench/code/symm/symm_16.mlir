func @symm_16( %alpha: f32, 
              %beta: f32, 
              %C: memref<16x16xf32>, 
              %A: memref<16x16xf32>, 
              %B: memref<16x16xf32>
  ) {
  affine.for %i = 0 to 16 {
    affine.for %j = 0 to 16 {
      %temp2 = memref.alloca() : memref<f32>
      %c0 = arith.constant 0.0 : f32
      affine.store %c0, %temp2[] : memref<f32>
      affine.for %k = 0 to %i {
        %0 = affine.load %A[%i, %k] : memref<16x16xf32>
        %1 = affine.load %B[%i, %j] : memref<16x16xf32>
        %2 = affine.load %C[%k, %j] : memref<16x16xf32>
        %3 = arith.mulf %alpha, %1 : f32
        %4 = arith.mulf %0, %3 : f32
        %5 = arith.addf %2, %4 : f32
        affine.store %5, %C[%k, %j] : memref<16x16xf32>
        
        %6 = affine.load %temp2[] : memref<f32>
        %7 = affine.load %B[%k, %j] : memref<16x16xf32>
        %8 = arith.mulf %0, %7 : f32
        %9 = arith.addf %6, %8 : f32
        affine.store %9, %temp2[] : memref<f32>
      }

      //C[i][j] = beta * C[i][j] + alpha*B[i][j] * A[i][i] + alpha * temp2;
      %0 = affine.load %A[%i, %i] : memref<16x16xf32>
      %1 = affine.load %B[%i, %j] : memref<16x16xf32>
      %2 = affine.load %C[%i, %j] : memref<16x16xf32>
      %3 = affine.load %temp2[] : memref<f32>
      %4 = arith.mulf %alpha, %3 : f32
      %5 = arith.mulf %0, %1 : f32
      %6 = arith.mulf %alpha, %5 : f32
      %7 = arith.mulf %beta, %2 : f32
      %8 = arith.addf %4, %6 : f32
      %9 = arith.addf %7, %8 : f32
      affine.store %9, %C[%i, %j] : memref<16x16xf32>
    }
  }
  return
}
