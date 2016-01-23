#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "handle_error.h"
#include <stdio.h>
#include <iostream>

__global__ void kernel(void) {
}

int main(void){
	cudaDeviceProp prop;
	int count;
	HANDLE_ERROR(cudaGetDeviceCount(&count));
	for (int i = 0; i < count; i++) {
		HANDLE_ERROR(cudaGetDeviceProperties(&prop, i));
	}
	//kernel << <1, 1 >> >();

	printf("hello world");
	system("PAUSE");
	return 0;

}