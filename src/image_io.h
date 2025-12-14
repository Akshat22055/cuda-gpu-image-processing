#ifndef IMAGE_IO_H
#define IMAGE_IO_H

#include <vector>
#include <string>

struct Image {
    int width;
    int height;
    std::vector<unsigned char> data;
};

Image loadDummyImage(int width, int height);
void saveDummyImage(const Image& img, const std::string& filename);

#endif
