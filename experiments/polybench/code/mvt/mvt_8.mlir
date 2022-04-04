func @mvt_8(
  %x1: memref<8xf32>, 
  %x2: memref<8xf32>, 
  %y1: memref<8xf32>, 
  %y2: memref<8xf32>, 
  %A: memref<8x8xf32>) {
  affine.for %n = 0 to 1 {
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %0 = affine.load %A[%i, %j] : memref<8x8xf32>
      %1 = affine.load %y1[%j] : memref<8xf32>
      %2 = affine.load %x1[%i] : memref<8xf32>
      %3 = arith.mulf %0, %1 : f32
      %4 = arith.addf %2, %3 : f32
      affine.store %4, %x1[%i] : memref<8xf32>
    }
  }
  
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %0 = affine.load %A[%j, %i] : memref<8x8xf32>
      %1 = affine.load %y2[%j] : memref<8xf32>
      %2 = affine.load %x2[%i] : memref<8xf32>
      %3 = arith.mulf %0, %1 : f32
      %4 = arith.addf %2, %3 : f32
      affine.store %4, %x2[%i] : memref<8xf32>
    }
  }
  }
  return
}
