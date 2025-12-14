NVCC=nvcc
CFLAGS=-std=c++17

all:
	$(NVCC) $(CFLAGS) src/main.cu src/image_io.cpp kernels/blur_kernel.cu -o gpu_image_processing

clean:
	rm -f gpu_image_processing
