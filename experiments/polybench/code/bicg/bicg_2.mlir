func.func @bicg_2(%A: memref<2x2xf32>, %s: memref<2xf32>, %q: memref<2xf32>, %p: memref<2xf32>, %r: memref<2xf32>) {
  affine.for %i = 0 to 2 {
    affine.for %j = 0 to 2 {
      %0 = affine.load %s[%j] : memref<2xf32>
      %1 = affine.load %r[%i] : memref<2xf32>
      %2 = affine.load %A[%i, %j] : memref<2x2xf32>
      %3 = arith.mulf %1, %2 : f32
      %4 = arith.addf %0, %3 : f32
      affine.store %4, %s[%j] : memref<2xf32>
      %5 = affine.load %q[%i] : memref<2xf32>
      %6 = affine.load %p[%j] : memref<2xf32>
      %7 = arith.mulf %2, %6 : f32
      %8 = arith.addf %5, %7 : f32
      affine.store %8, %q[%i] : memref<2xf32>
    }
  }
  return
}
