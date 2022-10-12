
# [linalg -> cgra]
soda-opt --convert-linalg-matmul-to-cgra --convert-pattern-to-cgra=target-patterns="arith.addf-arith.maxf-arith.addf-linalg.yield" gemmreluadd.linalg.tiled.mlir > gemmreluadd.cgra.mlir
