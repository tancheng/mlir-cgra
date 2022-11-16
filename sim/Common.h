
#ifndef COMMON_H
#define COMMON_H

#include <vector>
#include <map>
#include <set>
#include <iostream>

using namespace std;

class MemRef {
public:
  MemRef(float* allocated, float* aligned, int64_t offset, vector<int64_t>& sizes, vector<int64_t>& strides, int dim) {
    this->allocated = allocated;
    this->aligned = aligned;
    this->offset = offset;
    this->sizes = sizes;
    this->strides = strides;
    this->dim = dim;
  }

  float* allocated;
  float* aligned;
  int64_t offset;
  vector<int64_t> sizes;
  vector<int64_t> strides;
  int dim;
};

class DataReq {
public:
  DataReq(){}
  void assembleReq(MemRef& memRef) {
    memRefs.push_back(memRef);
  }

  vector<MemRef> memRefs;
};

class Simulator;

using pfunc = void (*)(DataReq&, DataReq&, Simulator&);

class Simulator {
public:
  Simulator(int, int);
  void enableDoubleBuffer();
  void issueRD(DataReq&);
  void issueEX(string, int64_t);
  void issueWR(DataReq&, bool);
  int64_t getTotalCycles();
  map<string, int> matmulLocCount;
  int dimX;
  int dimY;
  bool isBaselineMode;
  void runAsBaseline();
  int traditionalII;

private:
  bool doubleBufferEnabled;
  // These data struct could be replaced by queue if
  // we are targeting multi-threading
  DataReq currentInput[2];
  string currentOperation[2];
  
  int64_t lastRDCompleteCycle[2];
  int64_t lastEXCompleteCycle[2];
  int64_t lastWRCompleteCycle[2];
  int rdIndex = 0;
  int exIndex = 0;
  int wrIndex = 0;
  // A typical DMA @ 400MHz (32b/cycle)
  float DMASpeed = 32;
  map<string, pfunc> exFuncMap;
};

#endif
