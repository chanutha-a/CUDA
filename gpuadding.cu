
#include <cuda_runtime_api.h>
#include <iostream>
using namespace std;

__global__ void gpuadding(int *a, int *b, int *c, int N) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < N) {
    c[i] = a[i] + b[i];
  }
}

int main() {
  int N = 5;
  int a[] = {1, 2, 3, 4, 5};
  int b[] = {6, 7, 8, 9, 10};
  int c[5];

  // device pointers
  int *d_a, *d_b, *d_c;

  // allocate to gpu memory
  cudaMalloc((void **)&d_a, N * sizeof(int));
  cudaMalloc((void **)&d_b, N * sizeof(int));
  cudaMalloc((void **)&d_c, N * sizeof(int));

  // copy data from CPU → GPU
  cudaMemcpy(d_a, a, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, N * sizeof(int), cudaMemcpyHostToDevice);

  // lunch kernel
  gpuadding<<<1, N>>>(d_a, d_b, d_c, N);
  // wait for GPU to finish
  cudaDeviceSynchronize();

  // copy result back GPU → CPU
  cudaMemcpy(c, d_c, N * sizeof(int), cudaMemcpyDeviceToHost);

  // print result
  for (int i = 0; i < N; i++) {
    cout << c[i] << " ";
  }
  cout << endl;

  // free GPU memory
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  return 0;
}
