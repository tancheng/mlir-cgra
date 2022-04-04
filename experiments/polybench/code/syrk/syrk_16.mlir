#map = affine_map<(d0) -> (d0 + 1)>
func @syrk_16(%alpha: f32, %beta: f32, %C: memref<16x16xf32>, %A: memref<16x16xf32>) {
  affine.for %i = 0 to 16 {
    affine.for %j = 0 to #map(%i) {
      %0 = affine.load %C[%i, %j] : memref<16x16xf32>
      %1 = arith.mulf %beta, %0 : f32
      affine.store %1, %C[%i, %j] : memref<16x16xf32>
      affine.for %k = 0 to 16 {
        %2 = affine.load %A[%i, %k] : memref<16x16xf32>
        %3 = affine.load %A[%j, %k] : memref<16x16xf32>
        %4 = affine.load %C[%i, %j] : memref<16x16xf32>
        %5 = arith.mulf %alpha, %2 : f32
        %6 = arith.mulf %5, %3 : f32
        %7 = arith.addf %4, %6 : f32
        affine.store %7, %C[%i, %j] : memref<16x16xf32>
      }
    }
  }
  return
}
