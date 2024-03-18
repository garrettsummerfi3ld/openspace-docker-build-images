#!/bin/bash

# First run the normal build
./build.sh $@

cd OpenSpace
cp build/compile_commands.json .

# Filter the compile_commands to remove files we are not interested in
python3 ../filter_compile_commands.py

# And then run clang-tidy using the .clang_tidy file in the repository
run-clang-tidy-17 -config-file .clang_tidy


