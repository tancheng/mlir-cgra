
#include "Common.h"
#include <iostream>

using namespace std;

extern "C" {
  void *forward(int64_t* a_allocated, int64_t* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_size1, int64_t a_stride0, int64_t a_stride1,
                float* b_allocated, float* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_size1, int64_t b_stride0, int64_t b_stride1);
}


Simulator* cgra;

int main(int argc, char *argv[]) {

  if (argc < 4) {
    cout<<"Please provide `CGRA dim`, isDoubleBuffered`, and `runAsBaseline`..."<<endl;
    return 0;
  }

  int64_t *a = new int64_t[197*768];
  float *b = new float[197*1000];

  for (int i=0;i<197*768;i++){
    a[i] = 1;
  }

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

  forward(a, a, 1, 197, 768, 768, 1, b, b, 1, 197, 1000, 1000, 1);

  cout<<"Check result: "<<endl;
  for (int i=0; i<197*1000; ++i) {
    cout<<b[i]<<"\t";
  }
  cout<<endl;

  cout<<"Total cycles: "<<cgra->getTotalCycles()<<endl;

  return 0;
}
