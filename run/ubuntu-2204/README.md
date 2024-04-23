# Instructions for building and running OpenSpace in an Ubuntu 22.04 container

## Verify host requirements

The host computer needs the following to start with:

* Ubuntu 22.04 OS
* Nvidia GPU hardware
* Nvidia display driver
* 30GB or more free hard drive space

## Install `nvidia-container-runtime` on the host

Follow the installation steps [here](https://nvidia.github.io/nvidia-container-runtime/) and also [here](https://github.com/NVIDIA/nvidia-container-runtime)

## Build the image

Use the docker build command (details of build are in the repo README.md file)

## Run the image in a container

The `runContainer.sh` bash script can be used to run the container, or as an example to use in forming a docker run command with other options.
The script's run command contains the necessary arguments for the host GPU access and host display manager access.
