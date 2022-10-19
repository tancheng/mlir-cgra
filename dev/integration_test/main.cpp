#include <iostream>

template <typename T, size_t N> struct MemRefDescriptor {
  T *allocated;
  T *aligned;
  intptr_t offset;
  intptr_t sizes[N];
  intptr_t strides[N];
};

extern "C" {
  // void *main_graph(MemRefDescriptor<float, 2> input0, MemRefDescriptor<float, 2> input1, MemRefDescriptor<float, 2> input2, MemRefDescriptor<float, 2> input3, MemRefDescriptor<float, 2> output);
  void *main_graph(float* a_allocated, float* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                   float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1,
                   float* c_allocated, float* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_size1, int64_t c_stride0, int64_t c_stride1,
                   float* d_allocated, float* d_aligned, int64_t d_offset, int64_t d_size0, int64_t d_size1, int64_t d_stride0, int64_t d_stride1,
                   float* e_allocated, float* e_aligned, int64_t e_offset, int64_t e_size0, int64_t e_size1, int64_t e_stride0, int64_t e_stride1);
}

int main(int argc, char *argv[]) {
  float *a = new float[512];
  float *b = new float[512];
  float *c = new float[256];
  float *d = new float[256];
  float *e = new float[256];

  for (int i=0; i<512; ++i) {
    a[i] = i;
  }

  for (int i=0; i<512; ++i) {
    int x = i / 16;
    int y = i % 16;
    if (x == y)
      b[i] = 1;
  }

  for (int i=0; i<256; ++i) {
    d[i] = 1;
  }
  
  MemRefDescriptor<float, 2> memref = {
    a,    // allocated
    a,    // aligned
    0,    // offset
    {16, 32}, // sizes[N]
    {1, 1},  // strides[N]
  };

  // main_graph(memref0, memref1, memref2, memref3, memref4);
  main_graph(a, a, 0, 16, 32, 1, 1, b, b, 0, 32, 16, 1, 1, c, c, 0, 16, 16, 1, 1, d, d, 0, 16, 16, 1, 1, e, e, 0, 16, 16, 1, 1);

  std::cout<<"check result: "<<std::endl;
  for (int i=0; i<256; ++i) {
    std::cout<<e[i]<<"\t";
    if (i % 16 == 15) {
      std::cout<<std::endl;
    }
  }
  return 0;
}
