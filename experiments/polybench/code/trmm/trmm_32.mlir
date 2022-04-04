#map = affine_map<(d0) -> (d0 + 1)>
func @trmm_32(%alpha: f32, %A: memref<32x32xf32>, %B: memref<32x32xf32>) {
  affine.for %i = 0 to 32 {
    affine.for %j = 0 to 32 {
      affine.for %k = #map(%i) to 32 {
        %2 = affine.load %A[%k, %i] : memref<32x32xf32>
        %3 = affine.load %B[%k, %j] : memref<32x32xf32>
        %4 = affine.load %B[%i, %j] : memref<32x32xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %B[%i, %j] : memref<32x32xf32>
      }
      %0 = affine.load %B[%i, %j] : memref<32x32xf32>
      %1 = arith.mulf %alpha, %0 : f32
      affine.store %1, %B[%i, %j] : memref<32x32xf32>
    }
  }
  return
}
