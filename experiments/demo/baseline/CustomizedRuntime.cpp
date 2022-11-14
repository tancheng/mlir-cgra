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

#include "Common.h"

#include <iostream>
#include <algorithm>

using namespace std;

extern Simulator* cgra;

extern "C" {
  void *generic_0(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                  float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                  float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1,
                  float* d_allocated, float* d_aligned, int64_t d_offset, int64_t d_size0, int64_t d_size1, int64_t d_stride0, int64_t d_stride1);
}

// generic cgra_call. Some operations are also offloaded to CGRA without
// user pre-defined mapping, which requires lowering to LLVMIR.
extern "C" void cgra_generic_0(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
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
  cgra->issueEX("generic_0", a_size0 * a_size1);
  cgra->issueWR(output, false); // false indicates there is no related predefined operation, so need to run the lowered llvm ir code

  generic_0(a_allocated, a_aligned, a_offset, a_size0, a_size1, a_stride0, a_stride1,
            b_allocated, b_aligned, b_offset, b_size0, b_size1, b_stride0, b_stride1,
            c_allocated, c_aligned, c_offset, c_size0, c_size1, c_stride0, c_stride1,
            d_allocated, d_aligned, d_offset, d_size0, d_size1, d_stride0, d_stride1);
}

