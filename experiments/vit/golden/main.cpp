#include "Common.h"

#include <iostream>

template <typename T, size_t N> struct MemRefDescriptor {
  T *allocated;
  T *aligned;
  intptr_t offset;
  intptr_t sizes[N];
  intptr_t strides[N];
};

extern "C" {
  void *forward(int64_t* a_allocated, int64_t* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_size2, int64_t a_stride0, int64_t a_stride1, int64_t a_stride2,
                float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_size2, int64_t b_stride0, int64_t b_stride1, int64_t b_stride2);
}


Simulator* cgra;

int main(int argc, char *argv[]) {
    int64_t *a = new int64_t[197*768];
    float *b = new float[197*1000];

    for (int i=0;i<197*768;++i){
      a[i] = 1;
    }

    cgra = new Simulator(4, 4); // provide the x/y sizes of the CGRA

    // forward(a, a, 0, 1, 197, 768, 1, b, b, 0, 1, 197, 1000, 1);
    forward(a, a, 0, 1, 197, 768, 197*768, 768, 1, b, b, 0, 1, 197, 1000, 197*1000, 1000, 1);

    std::cout<<"check result: "<<std::endl;
    for (int i=0; i<197; ++i) {
      for (int j=0; j<768; ++j){
        std::cout<<b[i*768 + j]<<" ";
      }
      std::cout<<std::endl;
    }

    return 0;
}
