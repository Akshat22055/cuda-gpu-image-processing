#include "image_io.h"
#include <fstream>

Image loadDummyImage(int width, int height) {
    Image img;
    img.width = width;
    img.height = height;
    img.data.resize(width * height * 3);

    for (int i = 0; i < width * height * 3; i++) {
        img.data[i] = static_cast<unsigned char>(i % 255);
    }
    return img;
}

void saveDummyImage(const Image& img, const std::string& filename) {
    std::ofstream out(filename);
    out << "Dummy image saved: " << img.width << "x" << img.height << "\n";
    out.close();
}
