
#include "Common.h"
#include "CGRAFunc.h"

#include <iostream>

Simulator::Simulator(bool enableDoubleBuffer) {
  // DMA speed in GB/s @1GHz => bytes/cycle
  DMASpeed = 1;
  this->enableDoubleBuffer = enableDoubleBuffer;
  registerPredefinedMappings();
}

void Simulator::registerPredefinedMappings() {
  exCycleMap.insert({"matmul", 20});
  exCycleMap.insert({"fusion_add_max_add", 20});
  exFuncMap["matmul"] = matmul;
  exFuncMap["fusion_add_max_add"] = fusion_add_max_add;
}

void Simulator::registerTraditionalMapping(string operation, int64_t cycles) {

  if (exCycleMap.find(operation) != exCycleMap.end()) {
    exCycleMap[operation] = cycles;
  } else {
    exCycleMap.insert({operation, cycles});
  }
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
  rdCycles = totalSize / DMASpeed;
  int64_t rdStartCycle = lastEXCompleteCycle[rdIndex];
  if (enableDoubleBuffer)
    rdStartCycle = max(lastRDCompleteCycle[rdIndex ^ 1], lastEXCompleteCycle[rdIndex]);
  lastRDCompleteCycle[rdIndex] = rdStartCycle + rdCycles;

  cout<<"issueRD: lastRDCompleteCycle["<<rdIndex<<"]: "<<lastRDCompleteCycle[rdIndex]<<"; totalSize: "<<totalSize<<endl;

  if (enableDoubleBuffer)
    rdIndex = rdIndex ^ 1;

}

void Simulator::issueEX(string operationType) {

  // calculate execution cycles (the computation is done during issueWR())
  currentOperation[exIndex] = operationType;
  int64_t exCycles = exCycleMap[operationType];
  int64_t exStartCycle = lastRDCompleteCycle[exIndex];
  if (enableDoubleBuffer)
    exStartCycle = max(lastRDCompleteCycle[exIndex], lastEXCompleteCycle[exIndex ^ 1]);
  lastEXCompleteCycle[exIndex] = exStartCycle + exCycles;

  cout<<"issueEX: lastEXCompleteCycle["<<exIndex<<"]: "<<lastEXCompleteCycle[exIndex]<<endl;

  if (enableDoubleBuffer)
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
  wrCycles = totalSize / DMASpeed;

  int64_t wrStartCycle = lastEXCompleteCycle[wrIndex];
  if (enableDoubleBuffer)
    wrStartCycle = max(lastWRCompleteCycle[wrIndex ^ 1], lastEXCompleteCycle[wrIndex]);
  lastWRCompleteCycle[wrIndex] = wrStartCycle + wrCycles;

  cout<<"issueWR: lastWRCompleteCycle["<<wrIndex<<"]: "<<lastWRCompleteCycle[wrIndex]<<"; totalSize: "<<totalSize<<endl;

  if (enableDoubleBuffer)
    wrIndex = wrIndex ^ 1;

}

int64_t Simulator::getTotalCycles() {
  return max(lastWRCompleteCycle[0], lastWRCompleteCycle[1]);
}
