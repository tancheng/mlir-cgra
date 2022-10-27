
# [linalg -> cgra]
soda-opt --convert-linalg-matmul-to-cgra --convert-pattern-to-cgra=target-patterns="add-max-add" gemmreluadd.linalg.tiled.mlir > gemmreluadd.cgra.mlir
