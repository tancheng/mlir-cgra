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

#include <iostream>
#include <algorithm>

using namespace std;

extern "C" void cgra_matmul(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                 float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                 float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1) {
  for (int i=0; i<c_size0; ++i) {
    for (int j=0; j<c_size1; ++j) {
      for (int k=0; k<b_size0; ++k) {
        c_aligned[c_offset+i*c_stride0+j] += a_aligned[a_offset+i*a_stride0+k] * b_aligned[b_offset+k*b_stride0+j];
      }
    }
  }
  cout<<"calculated output for cgra_matmul() c_size0: "<<c_size0<<"; c_size1: "<<c_size1<<"; c_stride0: "<<c_stride0<<"; c_stride1: "<<c_stride1<<endl;
}

// This fusion is an example for add+max+add. A robust fusion call should
// be able to figure out what type of operation chain is targeted.
extern "C" void cgra_fusion(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                 float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                 float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1,
                 float* d_allocated, float* d_aligned, int64_t d_offset, int64_t d_size0, int64_t d_size1, int64_t d_stride0, int64_t d_stride1) {
  for (int i=0; i<d_size0; ++i) {
    for (int j=0; j<d_size1; ++j) {
      d_aligned[d_offset+i*d_stride0+j] = max(float(0), a_aligned[a_offset+i*a_stride0+j] + b_aligned[b_offset+i*b_stride0+j]) + c_aligned[c_offset+i*c_stride0+j];
    }
  }
  cout<<"calculated output for cgra_fusion() d_size0: "<<d_size0<<"; d_size1: "<<d_size1<<"; d_stride0: "<<d_stride0<<"; d_stride1: "<<d_stride1<<endl;
}

// TODO: generic cgra_call. Some operations are also offloaded to CGRA without
// user pre-defined mapping, which requires lowering to LLVMIR.


// TODO: need to enable multi-threading for a data-communication overhead and
// synchronization awared simulation.

// TODO: need to invoke python test inside this runtime to enable more accurate
// simulation.

