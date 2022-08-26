#map = affine_map<(d0) -> (d0 + 1)>
func.func @trmm_2(%alpha: f32, %A: memref<2x2xf32>, %B: memref<2x2xf32>) {
  affine.for %i = 0 to 2 {
    affine.for %j = 0 to 2 {
      affine.for %k = #map(%i) to 2 {
        %2 = affine.load %A[%k, %i] : memref<2x2xf32>
        %3 = affine.load %B[%k, %j] : memref<2x2xf32>
        %4 = affine.load %B[%i, %j] : memref<2x2xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %B[%i, %j] : memref<2x2xf32>
      }
      %0 = affine.load %B[%i, %j] : memref<2x2xf32>
      %1 = arith.mulf %alpha, %0 : f32
      affine.store %1, %B[%i, %j] : memref<2x2xf32>
    }
  }
  return
}
