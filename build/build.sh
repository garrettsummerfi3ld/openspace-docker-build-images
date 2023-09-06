#!/bin/bash

args_array=("$@")
if [ ${#args_array[@]} -eq 0 ]; then
  args_array+=("master")
fi

git clone --recursive --jobs 8 --depth 1 --branch "${args_array[0]}" https://github.com/OpenSpace/OpenSpace
cd OpenSpace
mkdir build

cmake -S . -B ./build
cmake --build build --parallel 16
