
#include "Common.h"

void matmul(DataReq& input, DataReq& output) {

  MemRef inA = input.memRefs[0];
  MemRef inB = input.memRefs[1];
  MemRef out = output.memRefs[0];
  for (int i=0; i<out.sizes[0]; ++i) {
    for (int j=0; j<out.sizes[1]; ++j) {
      for (int k=0; k<inB.sizes[0]; ++k) {
        out.aligned[out.offset+i*out.strides[0]+j] += inA.aligned[inA.offset*inA.sizes[1]+i*inA.strides[0]+k] * inB.aligned[inB.offset+k*inB.strides[0]+j];
      }
    }
  }
}

void fusion_add_max_add(DataReq& input, DataReq& output) {

  MemRef inA = input.memRefs[0];
  MemRef inB = input.memRefs[1];
  MemRef inC = input.memRefs[2];
  MemRef out = output.memRefs[0];

  for (int i=0; i<out.sizes[0]; ++i) {
    for (int j=0; j<out.sizes[1]; ++j) {
      out.aligned[out.offset+i*out.strides[0]+j] = max(float(0), inA.aligned[inA.offset+i*inA.strides[0]+j] + inB.aligned[inB.offset+i*inB.strides[0]+j]) + inC.aligned[inC.offset+i*inC.strides[0]+j];
    }
  }
}

