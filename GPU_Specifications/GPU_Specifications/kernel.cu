#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "handle_error.h"
#include <stdio.h>
#include <iostream>

__global__ void kernel(void) {
}
int getSPcores(cudaDeviceProp devProp)
{
	int cores = 0;
	int mp = devProp.multiProcessorCount;
	switch (devProp.major){
	case 2: // Fermi
		if (devProp.minor == 1) cores = mp * 48;
		else cores = mp * 32;
		break;
	case 3: // Kepler
		cores = mp * 192;
		break;
	case 5: // Maxwell
		cores = mp * 128;
		break;
	default:
		printf("Unknown device type\n");
		break;
	}
	return cores;
}
int main(void){
	
	int gpu_count;
	HANDLE_ERROR(cudaGetDeviceCount(&gpu_count));
	printf("This computer has %d CUDA capable GPU units\n", gpu_count);
	for (int i = 0; i < gpu_count; i++) {
		cudaDeviceProp prop;
		int cuda_cores;
		HANDLE_ERROR(cudaGetDeviceProperties(&prop, i));
		printf("---------------------------------------------\n");
		printf("GPU unit %d\n", i+1);
		printf("---------------------------------------------\n");
		printf("Name: %s\n", prop.name);
		cuda_cores = getSPcores(prop);
		printf("CUDA Cores %d\n", cuda_cores);
		printf("Total global mem: %d\n", prop.totalGlobalMem);
	}

	system("PAUSE");
	return 0;

}