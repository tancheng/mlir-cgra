#map = affine_map<(d0) -> (d0 + 1)>
func.func @syr2k_8(%alpha: f32, %beta: f32, %C: memref<8x8xf32>, %A: memref<8x8xf32>, %B: memref<8x8xf32>) {
  affine.for %i = 0 to 8 {
    affine.for %j = 0 to #map(%i) {
      %0 = affine.load %C[%i, %j] : memref<8x8xf32>
      %1 = arith.mulf %beta, %0 : f32
      affine.store %1, %C[%i, %j] : memref<8x8xf32>
      affine.for %k = 0 to 8 {
        %2 = affine.load %A[%i, %k] : memref<8x8xf32>
        %3 = affine.load %B[%j, %k] : memref<8x8xf32>
        %4 = affine.load %B[%i, %k] : memref<8x8xf32>
        %5 = affine.load %A[%j, %k] : memref<8x8xf32>
        %6 = affine.load %C[%i, %j] : memref<8x8xf32>
        %7 = arith.mulf %2, %3 : f32
        %8 = arith.mulf %4, %5 : f32
        %9 = arith.addf %7, %8 : f32
        %10 = arith.mulf %alpha, %9 : f32
        %11 = arith.addf %6, %10 : f32
        affine.store %11, %C[%i, %j] : memref<8x8xf32>
      }
    }
  }
  return
}
