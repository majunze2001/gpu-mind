#include <cuda_runtime.h>
#include <iostream>

__global__ void kernel(int *array, int N)
{
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    if (idx < N) {
        array[idx] = idx;
    }
}

int main(void)
{
    int N = 1 << 20;
    int *data;
    cudaMallocManaged(&data, N*sizeof(int));

    // Launch kernel to initialize data - this will page fault
    kernel<<<1, 256>>>(data, N);

    // Wait for GPU to finish before accessing on host
    cudaDeviceSynchronize();

    // Check for errors (all values should be i)
    for (int i = 0; i < N; i++) {
        if (data[i] != i) {
            std::cout << "Error: data[" << i << "] = " << data[i] << "\n";
            return -1;
        }
    }

    std::cout << "Correct!\n";

    // Free memory
    cudaFree(data);

    return 0;
}
