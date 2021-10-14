#map = affine_map<(d0) -> (d0 + 1)>
func @trmm_8(%alpha: f32, %A: memref<8x8xf32>, %B: memref<8x8xf32>) {
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to 8 {
      affine.for %k = #map(%i) to 8 {
        %2 = affine.load %A[%k, %i] : memref<8x8xf32>
        %3 = affine.load %B[%k, %j] : memref<8x8xf32>
        %4 = affine.load %B[%i, %j] : memref<8x8xf32>
        %5 = mulf %2, %3 : f32
        %6 = addf %4, %5 : f32
        affine.store %6, %B[%i, %j] : memref<8x8xf32>
      }
      %0 = affine.load %B[%i, %j] : memref<8x8xf32>
      %1 = mulf %alpha, %0 : f32
      affine.store %1, %B[%i, %j] : memref<8x8xf32>
    }
  }
  return
}
