func @atax_4( 
              %A: memref<4x4xf32>, 
              %x: memref<4xf32>,
              %y: memref<4xf32>, 
              %tmp: memref<4xf32>
  ) {
  affine.for %n = 0 to 1 {

  affine.for %i = 0 to 4 {
      %c0 = constant 0.0 : f32
      affine.store %c0, %y[%i] : memref<4xf32>
  }
  affine.for %i = 0 to 4 {
    %c0 = constant 0.0 : f32
    affine.store %c0, %tmp[%i] : memref<4xf32>
    
    affine.for %j = 0 to 4 {
      %2 = affine.load %A[%i, %j] : memref<4x4xf32>
      %3 = affine.load %x[%j] : memref<4xf32>
      %4 = affine.load %tmp[%i] : memref<4xf32>
      %5 = mulf %2, %3 : f32
      %6 = addf %4, %5 : f32
      affine.store %6, %tmp[%i] : memref<4xf32>
    }
    
    affine.for %j = 0 to 4 {
      %2 = affine.load %A[%i, %j] : memref<4x4xf32>
      %3 = affine.load %tmp[%i] : memref<4xf32>
      %4 = affine.load %y[%j] : memref<4xf32>
      %5 = mulf %2, %3 : f32
      %6 = addf %4, %5 : f32
      affine.store %6, %y[%j] : memref<4xf32>
    }
  }
  }
  return
}
