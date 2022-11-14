/*
 * ======================================================================
 * runtime.cpp
 * ======================================================================
 * This file includes the interfaces to call OpenCGRA (pymtl test) or C
 * code running on native machine for simulation the CGRA offloading.
 *
 * Author : Cheng Tan
 *   Date : Oct 22, 2022
 */

#include "Common.h"

#include <iostream>
#include <algorithm>

using namespace std;

extern Simulator* cgra;

extern "C" void cgra_matmul(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                 float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                 float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1) {

  // prepare inputs
  vector<int64_t> a_sizes = {a_size0, a_size1};
  vector<int64_t> a_strides = {a_stride0, a_stride1};
  MemRef memRef0(a_allocated, a_aligned, a_offset, a_sizes, a_strides, 2);

  vector<int64_t> b_sizes = {b_size0, b_size1};
  vector<int64_t> b_strides = {b_stride0, b_stride1};
  MemRef memRef1(b_allocated, b_aligned, b_offset, b_sizes, b_strides, 2);

  DataReq input;
  input.assembleReq(memRef0);
  input.assembleReq(memRef1);

  // prepare outputs
  vector<int64_t> c_sizes = {c_size0, c_size1};
  vector<int64_t> c_strides = {c_stride0, c_stride1};
  MemRef memRef2(c_allocated, c_aligned, c_offset, c_sizes, c_strides, 2);

  DataReq output;
  output.assembleReq(memRef2);

  // issue READ/EXECUTE/WRITE requests for simulation
  cgra->issueRD(input);
  cgra->issueEX("matmul");
  cgra->issueWR(output, true);
}

extern "C" void cgra_batch_matmul(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_size2, int64_t a_stride0, int64_t a_stride1, int64_t a_stride2,
                            float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_size2, int64_t b_stride0, int64_t b_stride1, int64_t b_stride2,
                            float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_size2, int64_t c_stride0, int64_t c_stride1, int64_t c_stride2) {

  // prepare inputs
  vector<int64_t> a_sizes = {a_size0, a_size1, a_size2};
  vector<int64_t> a_strides = {a_stride0, a_stride1, a_stride2};
  MemRef memRef0(a_allocated, a_aligned, a_offset, a_sizes, a_strides, 3);

  vector<int64_t> b_sizes = {b_size0, b_size1, b_size2};
  vector<int64_t> b_strides = {b_stride0, b_stride1, b_stride2};
  MemRef memRef1(b_allocated, b_aligned, b_offset, b_sizes, b_strides, 3);

  DataReq input;
  input.assembleReq(memRef0);
  input.assembleReq(memRef1);

  // prepare outputs
  vector<int64_t> c_sizes = {c_size0, c_size1, c_size2};
  vector<int64_t> c_strides = {c_stride0, c_stride1, c_stride2};
  MemRef memRef2(c_allocated, c_aligned, c_offset, c_sizes, c_strides, 3);

  DataReq output;
  output.assembleReq(memRef2);

  // issue READ/EXECUTE/WRITE requests for simulation
  cgra->issueRD(input);
  cgra->issueEX("batch_matmul");
  cgra->issueWR(output, true);

  /*
  cout<<"calculated output for cgra_batch_matmul() a_alloc: "<<a_allocated<<"; a_aligned: "<<a_aligned<<"; a_offset: "<<a_offset<<"; a_size0: "<<a_size0<<"; a_size1: "<<a_size1<<"; a_size2: "<<a_size2<<"; a_stride0: "<<a_stride0<<"; a_stride1: "<<a_stride1<<"; a_stride2: "<<a_stride2<<endl;
  cout<<"calculated output for cgra_batch_matmul() b_alloc: "<<b_allocated<<"; b_aligned: "<<b_aligned<<"; b_offset: "<<b_offset<<"; b_size0: "<<b_size0<<"; b_size1: "<<b_size1<<"; b_size2: "<<b_size2<<"; b_stride0: "<<b_stride0<<"; b_stride1: "<<b_stride1<<"; b_stride2: "<<b_stride2<<endl;
  cout<<"calculated output for cgra_batch_matmul() c_alloc: "<<c_allocated<<"; c_aligned: "<<c_aligned<<"; c_offset: "<<c_offset<<"; c_size0: "<<c_size0<<"; c_size1: "<<c_size1<<"; c_size2: "<<c_size2<<"; c_stride0: "<<c_stride0<<"; c_stride1: "<<c_stride1<<"; c_stride2: "<<c_stride2<<endl;
  cout<<"check total cycles: "<<cgra->getTotalCycles()<<endl;
  */
}

// This fusion is an example for add+max+add. A robust fusion call should
// be able to figure out what type of operation chain is targeted.
extern "C" void cgra_fusion_add_max_add(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                 float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                 float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1,
                 float* d_allocated, float* d_aligned, int64_t d_offset, int64_t d_size0, int64_t d_size1, int64_t d_stride0, int64_t d_stride1) {

  // prepare inputs
  vector<int64_t> a_sizes = {a_size0, a_size1};
  vector<int64_t> a_strides = {a_stride0, a_stride1};
  MemRef memRef0(a_allocated, a_aligned, a_offset, a_sizes, a_strides, 2);

  vector<int64_t> b_sizes = {b_size0, b_size1};
  vector<int64_t> b_strides = {b_stride0, b_stride1};
  MemRef memRef1(b_allocated, b_aligned, b_offset, b_sizes, b_strides, 2);

  vector<int64_t> c_sizes = {c_size0, c_size1};
  vector<int64_t> c_strides = {c_stride0, c_stride1};
  MemRef memRef2(c_allocated, c_aligned, c_offset, c_sizes, c_strides, 2);

  DataReq input;
  input.assembleReq(memRef0);
  input.assembleReq(memRef1);
  input.assembleReq(memRef2);

  // prepare outputs
  vector<int64_t> d_sizes = {d_size0, d_size1};
  vector<int64_t> d_strides = {d_stride0, d_stride1};
  MemRef memRef3(d_allocated, d_aligned, d_offset, d_sizes, d_strides, 2);

  DataReq output;
  output.assembleReq(memRef3);

  // issue READ/EXECUTE/WRITE requests for simulation
  cgra->issueRD(input);
  cgra->issueEX("fusion_add_max_add");
  cgra->issueWR(output, true); // true indicates there is a predefined mapping in the CGRAFunc.h

  // cout<<"calculated output for cgra_fusion() d_size0: "<<d_size0<<"; d_size1: "<<d_size1<<"; d_stride0: "<<d_stride0<<"; d_stride1: "<<d_stride1<<endl;
}

// TODO: need to invoke python test inside this runtime to enable more accurate
// simulation.

