
#include "Common.h"
#include <iostream>

using namespace std;

template <typename T, size_t N> struct MemRefDescriptor {
  T *allocated;
  T *aligned;
  intptr_t offset;
  intptr_t sizes[N];
  intptr_t strides[N];
};

extern "C" {
  void *forward(int64_t* a_allocated, int64_t* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1);
}


Simulator* cgra;

int main(int argc, char *argv[]) {

  if (argc < 4) {
    cout<<"Please provide `CGRA dim`, isDoubleBuffered`, `common mapping II`, and `runAsBaseline`..."<<endl;
    return 0;
  }

  int64_t *a = new int64_t[12];
  float *b = new float[2];

  a[0] = 101;
  a[1] = 1996;
  a[2] = 4248;
  a[3] = 2829;
  a[4] = 4419;
  a[5] = 14523;
  a[6] = 2058;
  a[7] = 1996;
  a[8] = 13971;
  a[9] = 3899;
  a[10] = 1012;
  a[11] = 102;

  int dim = stoi(argv[1]);
  cout<<"CGRA configurations -- size: "<<dim<<"x"<<dim<<", support double buffer: ";
  cgra = new Simulator(dim, dim);

  string isDoubleBuffered(argv[2]);
  if (isDoubleBuffered == "true") {
    cout<<"true, ";
    cgra->enableDoubleBuffer();
  } else {
    cout<<"false, ";
  }

  cout<<"evaluate baseline: ";

  string runAsBaseline(argv[3]);
  if (runAsBaseline == "true") {
    cout<<"true."<<endl;
    cgra->runAsBaseline();
  } else {
    cout<<"false."<<endl;
  }

  forward(a, a, 0, 1, 12, 1, 1, b, b, 0, 1, 2, 1, 1);

  cout<<"Check result: "<<endl;
  for (int i=0; i<2; ++i) {
    cout<<b[i]<<"\t";
  }
  cout<<endl;

  cout<<"Total cycles: "<<cgra->getTotalCycles()<<endl;

  return 0;
}
