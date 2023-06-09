#include <cuda_runtime.h>
#include <iostream>

__global__ void
kernel(int *array, int N)
{
	int index = blockIdx.x * blockDim.x + threadIdx.x;
	int stride = blockDim.x * gridDim.x;
	for (int i = index; i < N; i += stride)
		array[i] += i;
}

int
main(void)
{
	int N = 1 << 10;
    // 1k ints ~ 2 KB -- 1 page at most
	int *data;
	cudaMallocManaged(&data, N * sizeof(int));
	// the devices of compute capability 6.x and greater do not allocate physical memory when calling cudaMallocManaged():
	// in this case physical memory is populated on first touch and may be resident on the CPU or the GPU.

	int threadsPerBlock = 256;
	int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

	// Initialize data, so the data will be on CPU
	for (int i = 0; i < N; i ++)
		data[i] = i;

	// Launch kernel, this should pagefault, causing a page migration from CPU to GPU
	kernel<<<blocksPerGrid, threadsPerBlock>>>(data, N);

    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess)
        printf("Error: %s\n", cudaGetErrorString(err));

	// Wait for GPU to finish before accessing on host
	cudaDeviceSynchronize();

	// a migration from GPU back to CPU
	// Check for errors (all values should be 2i)
	for (int i = 0; i < N; i++)
	{
		if (data[i] != 2 * i)
		{
			std::cout << "Error: data[" << i << "] = " << data[i] << "\n";
			return -1;
		}
	}

	std::cout << "Correct!\n";

	// Free memory
	cudaFree(data);

	return 0;
}
