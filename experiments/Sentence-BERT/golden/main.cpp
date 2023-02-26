
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

  int64_t *a = new int64_t[14];
  float *b = new float[14*768];

  a[0] = 2;
  a[1] = 160;
  a[2] = 382;
  a[3] = 54;
  a[4] = 59;
  a[5] = 1377;
  a[6] = 48056;
  a[7] = 3;
  a[8] = 3998;
  a[9] = 1377;
  a[10] = 444;
  a[11] = 22594;
  a[12] = 10312;
  a[13] = 3;


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

  forward(a, a, 0, 1, 14, 1, 1, b, b, 0, 14, 768, 768, 1);

  cout<<"Check result: "<<endl;
  for (int i=0; i<14*768; ++i) {
    cout<<b[i]<<"\t";
  }
  cout<<endl;

  cout<<"Total cycles: "<<cgra->getTotalCycles()<<endl;

  return 0;
}
