#!/bin/bash
make clean
make
./gpu_image_processing 200 | tee logs/execution_log.txt
