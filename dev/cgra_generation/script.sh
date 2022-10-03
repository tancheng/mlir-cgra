
# [linalg -> cgra]
soda-opt --convert-linalg-matmul-to-soda --convert-linalg-generic-to-soda gemmreluadd.linalg.tiled.mlir > gemmreluadd.cgra.mlir
