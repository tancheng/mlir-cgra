#!/usr/bin/python

import sys

if len(sys.argv) != 2:
    print('provide the source llvm-mlir file name')

else:
  sourceFileName = sys.argv[1]
  
  declares = set()
  calls = {}
  declares.add('llvm.func @cgra_matmul_')
  declares.add('llvm.func @cgra_batch_matmul_')
  calls['llvm.call @cgra_matmul_'] = 'llvm.call @cgra_matmul'
  calls['llvm.call @cgra_batch_matmul_'] = 'llvm.call @cgra_batch_matmul'
  
  with open(sourceFileName) as sourceFile:
      lines = sourceFile.readlines()
      for line in lines:
          skip = False
          for keyword in declares:
              if keyword in line:
                  skip = True
                  break
  
          if not skip:
              for keyword in calls.keys():
                  if keyword in line:
                      start = line.index(keyword)
                      end = start + len(keyword)
                      while line[end] == '_':
                          end += 1
                      line = line[:start] + calls[keyword] + line[end:]
                      break
      
              print(line[:-1])
  
