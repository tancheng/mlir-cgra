func @mvt_32(
  %x1: memref<32xf32>, 
  %x2: memref<32xf32>, 
  %y1: memref<32xf32>, 
  %y2: memref<32xf32>, 
  %A: memref<32x32xf32>) {
  affine.for %n = 0 to 1 {
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      %0 = affine.load %A[%i, %j] : memref<32x32xf32>
      %1 = affine.load %y1[%j] : memref<32xf32>
      %2 = affine.load %x1[%i] : memref<32xf32>
      %3 = mulf %0, %1 : f32
      %4 = addf %2, %3 : f32
      affine.store %4, %x1[%i] : memref<32xf32>
    }
  }
  
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      %0 = affine.load %A[%j, %i] : memref<32x32xf32>
      %1 = affine.load %y2[%j] : memref<32xf32>
      %2 = affine.load %x2[%i] : memref<32xf32>
      %3 = mulf %0, %1 : f32
      %4 = addf %2, %3 : f32
      affine.store %4, %x2[%i] : memref<32xf32>
    }
  }
  }
  return
}
