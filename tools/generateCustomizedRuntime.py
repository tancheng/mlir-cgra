#!/usr/bin/python

import sys

class Declare:
    def __init__(self, funcName, numOfTensors, tensorDims):
        self.funcName = funcName
        self.numOfTensors = numOfTensors
        self.tensorDims = tensorDims

    def toCString(self):
        line = "void *" + self.funcName + "("
        for i in range(self.numOfTensors):
            addrType = "float*"
            paramsPerTensor = addrType + ", " + addrType + ", int64_t, "
            for j in range(self.tensorDims[i]):
                paramsPerTensor += "int64_t, int64_t, "
            line += paramsPerTensor
        line = line[:-2] + ");"
        return line

class Define:
    def __init__(self, funcName, numOfTensors, tensorDims):
        self.funcName = funcName
        self.numOfTensors = numOfTensors
        self.tensorDims = tensorDims

    def assembleTensor(self, index, numOfDims, isInput = True):
        lines = []
        var = "i" if isInput else "o"

        if numOfDims == 0:
            sizes = "\tvector<int64_t> " + var + str(index) + "_sizes = {};"
            lines.append(sizes)
            strides = "\tvector<int64_t> " + var + str(index) + "_strides = {};"
            lines.append(strides)
        else:
          sizes = "\tvector<int64_t> " + var + str(index) + "_sizes = {"
          for i in range(numOfDims):
              sizes += var + str(index) + "_size" + str(i) + ", "
          sizes = sizes[:-2] + "};"
          lines.append(sizes)

          strides = "\tvector<int64_t> " + var + str(index) + "_strides = {"
          for i in range(numOfDims):
              strides += var + str(index) + "_stride" + str(i) + ", "
          strides = strides[:-2] + "};"
          lines.append(strides)

        memref = "\tMemRef memRef" + str(index) + "(" + var + str(index) + "_allocated, "
        memref += var + str(index) + "_aligned, "
        memref += var + str(index) + "_offset, "
        memref += var + str(index) + "_sizes, "
        memref += var + str(index) + "_strides, "
        memref += str(numOfDims) + ");"
        lines.append(memref)

        return lines

    def toCString(self):
        lines = []
        head = "extern \"C\" void cgra_" + self.funcName + "("

        for i in range(self.numOfTensors - 1):
            head += "float* i" + str(i) + "_allocated, float* i" + str(i) + "_aligned, int64_t i" + str(i) + "_offset, "
            for j in range(self.tensorDims[i]):
                head += "int64_t i" + str(i) + "_size" + str(j) + ", "
            for j in range(self.tensorDims[i]):
                head += "int64_t i" + str(i) + "_stride" + str(j) + ", "

        i = self.numOfTensors - 1
        head += "float* o" + str(i) + "_allocated, float* o" + str(i) + "_aligned, int64_t o" + str(i) + "_offset, "
        for j in range(self.tensorDims[i]):
            head += "int64_t o" + str(i) + "_size" + str(j) + ", "
        for j in range(self.tensorDims[i]):
            head += "int64_t o" + str(i) + "_stride" + str(j) + ", "

        head = head[:-2] + ") {"
        lines.append(head)
        lines.append("")

        for i in range(self.numOfTensors-1):
            lines.extend(self.assembleTensor(i, self.tensorDims[i], True))
            lines.append("")

        lines.append("\tDataReq input;")
        for i in range(self.numOfTensors-1):
            lines.append("\tinput.assembleReq(memRef" + str(i) + ");")
        lines.append("\t")


        i = self.numOfTensors - 1
        lines.extend(self.assembleTensor(i, self.tensorDims[i], False))
        lines.append("")

        lines.append("\tDataReq output;")
        lines.append("\toutput.assembleReq(memRef" + str(i) + ");")


        lines.append("\tcgra->issueRD(input);")
        accum = "int accum = 1"
        for j in range(self.tensorDims[0]):
            accum += " * i0_size" + str(j)
        accum += ";"
        lines.append("\t" + accum)
        lines.append("\tcgra->issueEX(\"" + self.funcName + "\", accum);")
        lines.append("\tcgra->issueWR(output, false);")

        call = self.funcName + "("
        for i in range(self.numOfTensors - 1):
            call += "i" + str(i) + "_allocated, i" + str(i) + "_aligned, i" + str(i) + "_offset, "
            for j in range(self.tensorDims[i]):
                call += "i" + str(i) + "_size" + str(j) + ", "
            for j in range(self.tensorDims[i]):
                call += "i" + str(i) + "_stride" + str(j) + ", "

        i = self.numOfTensors - 1
        call += "o" + str(i) + "_allocated, o" + str(i) + "_aligned, o" + str(i) + "_offset, "
        for j in range(self.tensorDims[i]):
            call += "o" + str(i) + "_size" + str(j) + ", "
        for j in range(self.tensorDims[i]):
            call += "o" + str(i) + "_stride" + str(j) + ", "
        call = call[:-2] + ");"

        lines.append("\t" + call)
        lines.append("}")

        outStr = ""
        for line in lines:
            outStr += line + "\n"
        return outStr

def codeGenHeader():
    print("""
/*
 * ======================================================================
 * CutomizedRuntime.cpp
 * ======================================================================
 * This file includes the interfaces to call OpenCGRA (pymtl test) or C
 * code running on native machine for simulation the CGRA offloading.
 *
 * Author : Cheng Tan
 *   Date : Nov 6, 2022
*/

#include \"Common.h\"

#include <iostream>
#include <algorithm>

using namespace std;

extern Simulator* cgra;""")

def codeGenGenericDeclares(declares):
    print("extern \"C\" {")
    for dec in declares:
        print("\t" + dec.toCString())
    print("}")
    print()


def codeGenGenericDefines(defines):
    for define in defines:
        print(define.toCString())
        print()


if len(sys.argv) != 2:
    print('provide the source llvm-mlir file name')

else:
    sourceFileName = sys.argv[1]
    
    with open(sourceFileName) as sourceFile:


        codeGenHeader()

        declares = []
        defines = []

        lines = sourceFile.readlines()
        for line in lines:

            if "func.func " in line:
                funcName = line.split("@")[1].split("(")[0]
                numOfTensors = line.count("memref")
                phrases = line.split("memref")
                tensorDims = []
                for phrase in phrases[1:]:
                    dim = phrase.split("<")[1].split(">")[0].count("x")
                    tensorDims.append(dim)
                dec = Declare(funcName, numOfTensors, tensorDims)
                define = Define(funcName, numOfTensors, tensorDims)
                declares.append(dec)
                defines.append(define)

        codeGenGenericDeclares(declares)
        codeGenGenericDefines(defines)
  
