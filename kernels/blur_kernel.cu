#include <cuda_runtime.h>

__global__ void blurKernel(unsigned char* input,
                           unsigned char* output,
                           int width,
                           int height) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x >= width || y >= height) return;

    int idx = (y * width + x) * 3;

    for (int c = 0; c < 3; c++) {
        int left  = max(x - 1, 0);
        int right = min(x + 1, width - 1);

        int idxL = (y * width + left) * 3 + c;
        int idxR = (y * width + right) * 3 + c;

        output[idx + c] =
            (input[idxL] + input[idx + c] + input[idxR]) / 3;
    }
}
