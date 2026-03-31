#include <stdio.h>

__global__ void
helloWorld() { //__global__ -> indicates that function runs of GPU
  printf("Hello World from the RTX 3050\n");
}

int main() {
  helloWorld<<<1, 1>>>();  // <<<1,1>>> -> kernel launch configuration
  cudaDeviceSynchronize(); // ensures that the GPU has finished executing the
                           // kernel

  return 0;
}
