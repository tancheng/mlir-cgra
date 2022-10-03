
# [linalg tiling] tiling should be done after bufferization/finalization as scf dialect is not recognized by the linalg tranformation
mlir-opt --linalg-tile=tile-sizes=4 gemmreluadd.linalg.finalized.mlir > gemmreluadd.linalg.tiled.mlir

# [other possible/necessary optimizations/tranfomrations]

