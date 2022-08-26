#map = affine_map<(d0) -> (d0 + 1)>
func.func @trmm_16(%alpha: f32, %A: memref<16x16xf32>, %B: memref<16x16xf32>) {
  affine.for %i = 0 to 16 {
    affine.for %j = 0 to 16 {
      affine.for %k = #map(%i) to 16 {
        %2 = affine.load %A[%k, %i] : memref<16x16xf32>
        %3 = affine.load %B[%k, %j] : memref<16x16xf32>
        %4 = affine.load %B[%i, %j] : memref<16x16xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %B[%i, %j] : memref<16x16xf32>
      }
      %0 = affine.load %B[%i, %j] : memref<16x16xf32>
      %1 = arith.mulf %alpha, %0 : f32
      affine.store %1, %B[%i, %j] : memref<16x16xf32>
    }
  }
  return
}
