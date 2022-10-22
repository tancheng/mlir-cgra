#include <iostream>

using namespace std;

extern "C" void cgra_matmul(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                 float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                 float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1) {
  for (int i=0; i<c_size0; ++i) {
    for (int j=0; j<c_size1; ++j) {
      c_allocated[i*c_size1 + j] = 1;
    }
  }
  cout<<"calculated output for cgra_matmul()"<<endl;
}

extern "C" void cgra_fusion(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                 float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                 float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1,
                 float* d_allocated, float* d_aligned, int64_t d_offset, int64_t d_size0, int64_t d_size1, int64_t d_stride0, int64_t d_stride1) {
  for (int i=0; i<d_size0; ++i) {
    for (int j=0; j<d_size1; ++j) {
      d_allocated[i*d_size1 + j] = 1;
    }
  }
  cout<<"calculated output for cgra_fusion()"<<endl;
}

