@echo off
docker build --tag openspace-fedora-38-default --file fedora-38-default.Dockerfile .
docker build --tag openspace-ubuntu-2204-clang14 --file ubuntu-2204-clang14.Dockerfile .
docker build --tag openspace-ubuntu-2204-clang15 --file ubuntu-2204-clang15.Dockerfile .
docker build --tag openspace-ubuntu-2204-clang17 --file ubuntu-2204-clang17.Dockerfile .
docker build --tag openspace-ubuntu-2204-default --file ubuntu-2204-default.Dockerfile .
docker build --tag openspace-ubuntu-2204-gcc11 --file ubuntu-2204-gcc11.Dockerfile .
docker build --tag openspace-ubuntu-2204-gcc12 --file ubuntu-2204-gcc12.Dockerfile .
