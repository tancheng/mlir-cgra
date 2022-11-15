
#include "Common.h"
#include "CGRAFunc.h"

#include <iostream>

Simulator::Simulator(int dimX, int dimY) {
  // DMA speed in GB/s @1GHz => bytes/cycle
  this->doubleBufferEnabled = false;
  this->dimX = dimX;
  this->dimY = dimY;
  // Usually, the II increases along with the size of the CGRA
  // as larger CGRA lowers vectorized kernels. And vectorization
  // leads to longer critical path (i.e., recII).
  traditionalII = dimX;
  isBaselineMode = false;
  registerPredefinedMappingKernels();
}

void Simulator::enableDoubleBuffer() {
  this->doubleBufferEnabled = true;
}

// For baseline, all the kernels are mapped in the
// traditional way.
void Simulator::runAsBaseline() {
  isBaselineMode = true;
}

void Simulator::registerPredefinedMappingKernels() {
  predefinedMappingKernels.insert("matmul");
  predefinedMappingKernels.insert("batch_matmul");
  predefinedMappingKernels.insert("fusion_add_max_add");

  exFuncMap["matmul"] = matmul;
  exFuncMap["batch_matmul"] = batch_matmul;
  exFuncMap["fusion_add_max_add"] = fusion_add_max_add;
}


void Simulator::registerPredefinedMappingKernel(string kernel) {
  predefinedMappingKernels.insert(kernel);
}

void Simulator::issueRD(DataReq& input) {

  // prepare data for computation
  currentInput[rdIndex] = input;

  // calculate data communication (host->CGRA) cycles
  int64_t rdCycles = 0;
  int64_t totalSize = 0;
  for (auto& dataReq: input.memRefs) {
    int64_t tensorSize = 1;
    for (auto& size: dataReq.sizes) {
      tensorSize *= size;
    }
    totalSize += tensorSize;
  }
  rdCycles = totalSize * 4 / DMASpeed * 2; // assume 400MHz DMA (32b/cycle), the CGRA is 800MHz.
  int64_t rdStartCycle = lastEXCompleteCycle[rdIndex];
  if (doubleBufferEnabled)
    rdStartCycle = max(lastRDCompleteCycle[rdIndex ^ 1], lastEXCompleteCycle[rdIndex]);
  lastRDCompleteCycle[rdIndex] = rdStartCycle + rdCycles;

  // cout<<"issueRD: lastRDCompleteCycle["<<rdIndex<<"]: "<<lastRDCompleteCycle[rdIndex]<<"; totalSize: "<<totalSize<<endl;

  if (doubleBufferEnabled)
    rdIndex = rdIndex ^ 1;

}

void Simulator::issueEX(string operationType, int64_t loopBounds) {

  // calculate execution cycles (the computation is done during issueWR())
  currentOperation[exIndex] = operationType;
  int64_t exCycles = 0;

  if (operationType == "matmul" || operationType == "batch_matmul") {
    if (isBaselineMode || predefinedMappingKernels.find(operationType) == predefinedMappingKernels.end()) {
      exCycles = loopBounds * traditionalII;
    } else {
      exCycles = loopBounds + this->dimX - 1;
    }
  } else {
    if (isBaselineMode || predefinedMappingKernels.find(operationType) == predefinedMappingKernels.end()) {

      // assume unrolling factor is the same as the dimX
      exCycles = loopBounds / this->dimX * traditionalII;
    } else {

      // for generic op
      // in this prototype, we only target 3-opt chain
      exCycles = loopBounds / this->dimX + 2 * (this->dimX -1);
    }
  }

  // int64_t exCycles = exCycleMap[operationType];
  int64_t exStartCycle = lastRDCompleteCycle[exIndex];
  if (doubleBufferEnabled)
    exStartCycle = max(lastRDCompleteCycle[exIndex], lastEXCompleteCycle[exIndex ^ 1]);
  lastEXCompleteCycle[exIndex] = exStartCycle + exCycles;

  // cout<<"issueEX: lastEXCompleteCycle["<<exIndex<<"]: "<<lastEXCompleteCycle[exIndex]<<endl;

  if (doubleBufferEnabled)
    exIndex = exIndex ^ 1;


}

void Simulator::issueWR(DataReq& output, bool computeHere) {

  // prepare input and output for computation
  DataReq& input = currentInput[wrIndex];
  string operation = currentOperation[wrIndex];

  // perform computation
  if (computeHere) {
    pfunc f = exFuncMap[operation];
    (*f)(input, output, *this);
  }

  // calculate data communication (CGRA->host) cycles
  int64_t wrCycles = 0;
  int64_t totalSize = 0;
  for (auto& dataReq: output.memRefs) {
    int64_t tensorSize = 1;
    for (auto& size: dataReq.sizes) {
      tensorSize *= size;
    }
    totalSize += tensorSize;
  }
  wrCycles = totalSize * 4 / DMASpeed * 2;

  int64_t wrStartCycle = lastEXCompleteCycle[wrIndex];
  if (doubleBufferEnabled)
    wrStartCycle = max(lastWRCompleteCycle[wrIndex ^ 1], lastEXCompleteCycle[wrIndex]);
  lastWRCompleteCycle[wrIndex] = wrStartCycle + wrCycles;

  // cout<<"issueWR: lastWRCompleteCycle["<<wrIndex<<"]: "<<lastWRCompleteCycle[wrIndex]<<"; totalSize: "<<totalSize<<endl;

  if (doubleBufferEnabled)
    wrIndex = wrIndex ^ 1;

}

int64_t Simulator::getTotalCycles() {
  return max(lastWRCompleteCycle[0], lastWRCompleteCycle[1]);
}
