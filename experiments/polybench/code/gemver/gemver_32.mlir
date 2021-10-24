func @gemver_32(%alpha: f32, %beta: f32, 
                %A: memref<32x32xf32>, 
                %u1: memref<32xf32>, 
                %v1: memref<32xf32>, 
                %u2: memref<32xf32>, 
                %v2: memref<32xf32>, 
                %w: memref<32xf32>, 
                %x: memref<32xf32>, 
                %y: memref<32xf32>,
                %z: memref<32xf32> 
                ) {
  affine.for %n = 0 to 1{
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      %0 = affine.load %A[%i, %j] : memref<32x32xf32>
      %1 = affine.load %u1[%i] : memref<32xf32>
      %2 = affine.load %v1[%j] : memref<32xf32>
      %3 = affine.load %u2[%i] : memref<32xf32>
      %4 = affine.load %v2[%j] : memref<32xf32>
      %5 = mulf %1, %2 : f32
      %6 = mulf %3, %4 : f32
      %7 = addf %0, %5 : f32
      %8 = addf %7, %6 : f32
      affine.store %8, %A[%i,%j] : memref<32x32xf32>
    }
  }
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      %0 = affine.load %x[%i] : memref<32xf32>
      %1 = affine.load %A[%i, %j] : memref<32x32xf32>
      %2 = affine.load %y[%j] : memref<32xf32>
      %3 = mulf %beta, %1 : f32
      %4 = mulf %2, %3 : f32
      %5 = addf %0, %4 : f32
      affine.store %5, %x[%i] : memref<32xf32>
    }
  }
  affine.for %i = 0 to 32 {
    %0 = affine.load %x[%i] : memref<32xf32>
    %1 = affine.load %z[%i] : memref<32xf32>
    %3 = addf %0, %1 : f32
    affine.store %3, %x[%i] : memref<32xf32>
  }
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      %0 = affine.load %w[%i] : memref<32xf32>
      %1 = affine.load %A[%i, %j] : memref<32x32xf32>
      %2 = affine.load %x[%j] : memref<32xf32>
      %3 = mulf %alpha, %1 : f32
      %4 = mulf %2, %3 : f32
      %5 = addf %0, %4 : f32
      affine.store %5, %w[%i] : memref<32xf32>
    }
  }
  }
  return
}
