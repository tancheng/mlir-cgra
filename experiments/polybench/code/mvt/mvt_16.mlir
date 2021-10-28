func @mvt_16(
  %x1: memref<16xf32>, 
  %x2: memref<16xf32>, 
  %y1: memref<16xf32>, 
  %y2: memref<16xf32>, 
  %A: memref<16x16xf32>) {
  affine.for %n = 0 to 1 {
  affine.for %i = 0 to 16 {
    affine.for %j = 0 to 16 {
      %0 = affine.load %A[%i, %j] : memref<16x16xf32>
      %1 = affine.load %y1[%j] : memref<16xf32>
      %2 = affine.load %x1[%i] : memref<16xf32>
      %3 = mulf %0, %1 : f32
      %4 = addf %2, %3 : f32
      affine.store %4, %x1[%i] : memref<16xf32>
    }
  }
  
  affine.for %i = 0 to 16 {
    affine.for %j = 0 to 16 {
      %0 = affine.load %A[%j, %i] : memref<16x16xf32>
      %1 = affine.load %y2[%j] : memref<16xf32>
      %2 = affine.load %x2[%i] : memref<16xf32>
      %3 = mulf %0, %1 : f32
      %4 = addf %2, %3 : f32
      affine.store %4, %x2[%i] : memref<16xf32>
    }
  }
  }
  return
}
