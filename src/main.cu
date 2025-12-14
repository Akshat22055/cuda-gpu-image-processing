#include <iostream>
#include <vector>
#include <cuda_runtime.h>
#include "image_io.h"

__global__ void blurKernel(unsigned char*, unsigned char*, int, int);

int main(int argc, char** argv) {
    int numImages = 200;
    int width = 256;
    int height = 256;

    if (argc > 1) numImages = atoi(argv[1]);

    std::cout << "Processing " << numImages << " images on GPU\n";

    size_t imgSize = width * height * 3;
    unsigned char *d_in, *d_out;

    cudaMalloc(&d_in, imgSize);
    cudaMalloc(&d_out, imgSize);

    dim3 block(16, 16);
    dim3 grid((width + 15) / 16, (height + 15) / 16);

    for (int i = 0; i < numImages; i++) {
        Image img = loadDummyImage(width, height);

        cudaMemcpy(d_in, img.data.data(), imgSize, cudaMemcpyHostToDevice);

        blurKernel<<<grid, block>>>(d_in, d_out, width, height);
        cudaDeviceSynchronize();

        cudaMemcpy(img.data.data(), d_out, imgSize, cudaMemcpyDeviceToHost);

        saveDummyImage(img, "data/output/output_" + std::to_string(i) + ".txt");
    }

    cudaFree(d_in);
    cudaFree(d_out);

    std::cout << "GPU processing completed successfully\n";
    return 0;
}
