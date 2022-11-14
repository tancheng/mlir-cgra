
#include "Common.h"

void matmul(DataReq& input, DataReq& output, Simulator& sim) {


  MemRef inA = input.memRefs[0];
  MemRef inB = input.memRefs[1];
  MemRef out = output.memRefs[0];

  // walk-around for the current bug in MLIR tiling memref
  int row = out.offset / (out.sizes[0] * out.strides[0]);
  int col = out.offset % (out.sizes[0] * out.strides[0]) / out.sizes[1];
  string locKey = to_string(row) + "," + to_string(col);
  if (sim.matmulLocCount.find(locKey) == sim.matmulLocCount.end()) {
    sim.matmulLocCount.insert({locKey, -1});
  }
  sim.matmulLocCount[locKey] += 1;

  int64_t offsetA = row * inA.sizes[0] * inA.strides[0] + sim.matmulLocCount[locKey] * inA.sizes[1];
  int64_t offsetB = col * inB.sizes[1] + sim.matmulLocCount[locKey] * inB.sizes[0] * inB.strides[0];

  for (int i=0; i<out.sizes[0]; ++i) {
    for (int j=0; j<out.sizes[1]; ++j) {
      for (int k=0; k<inB.sizes[0]; ++k) {
        out.aligned[out.offset+i*out.strides[0]+j] += inA.aligned[offsetA+i*inA.strides[0]+k] * inB.aligned[offsetB+k*inB.strides[0]+j];
      }
    }
  }

  // reset the locCount
  if (sim.matmulLocCount[locKey] == inA.strides[0] / inA.sizes[1] - 1) {
    sim.matmulLocCount[locKey] = -1;
  }
}

void batch_matmul(DataReq& input, DataReq& output, Simulator& sim) {


  MemRef inA = input.memRefs[0];
  MemRef inB = input.memRefs[1];
  MemRef out = output.memRefs[0];

  for (int b=0; b<out.sizes[0]; ++b) {
    for (int i=0; i<out.sizes[1]; ++i) {
      for (int j=0; j<out.sizes[2]; ++j) {
        for (int k=0; k<inB.sizes[1]; ++k) {
          out.aligned[b*out.strides[0]+out.offset+i*out.strides[1]+j] += inA.aligned[b*inA.strides[0]+inA.offset+i*inA.strides[1]+k] * inB.aligned[b*inB.strides[0]+inB.offset+k*inB.strides[1]+j];
        }
      }
    }
  }
}

void fusion_add_max_add(DataReq& input, DataReq& output, Simulator& sim) {

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

