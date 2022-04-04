#map = affine_map<(d0) -> (d0 + 1)>
func @trmm_4(%alpha: f32, %A: memref<4x4xf32>, %B: memref<4x4xf32>) {
  affine.for %i = 0 to 4 {
    affine.for %j = 0 to 4 {
      affine.for %k = #map(%i) to 4 {
        %2 = affine.load %A[%k, %i] : memref<4x4xf32>
        %3 = affine.load %B[%k, %j] : memref<4x4xf32>
        %4 = affine.load %B[%i, %j] : memref<4x4xf32>
        %5 = arith.mulf %2, %3 : f32
        %6 = arith.addf %4, %5 : f32
        affine.store %6, %B[%i, %j] : memref<4x4xf32>
      }
      %0 = affine.load %B[%i, %j] : memref<4x4xf32>
      %1 = arith.mulf %alpha, %0 : f32
      affine.store %1, %B[%i, %j] : memref<4x4xf32>
    }
  }
  return
}
