func @bicg_8(%A: memref<8x8xf32>, %s: memref<8xf32>, %q: memref<8xf32>, %p: memref<8xf32>, %r: memref<8xf32>) {
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      %0 = affine.load %s[%j] : memref<8xf32>
      %1 = affine.load %r[%i] : memref<8xf32>
      %2 = affine.load %A[%i, %j] : memref<8x8xf32>
      %3 = arith.mulf %1, %2 : f32
      %4 = arith.addf %0, %3 : f32
      affine.store %4, %s[%j] : memref<8xf32>
      %5 = affine.load %q[%i] : memref<8xf32>
      %6 = affine.load %p[%j] : memref<8xf32>
      %7 = arith.mulf %2, %6 : f32
      %8 = arith.addf %5, %7 : f32
      affine.store %8, %q[%i] : memref<8xf32>
    }
  }
  return
}
