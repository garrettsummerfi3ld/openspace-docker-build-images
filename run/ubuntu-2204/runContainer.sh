#!/bin/bash

docker build --tag ubuntu-2204-gcc11 --file ../build/ubuntu-2204-gcc11.Dockerfile .

imageToRun=$1
DisplayForwarding=" -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY"

if [ "${imageToRun}" = "" ]; then
  echo "Need docker image to run as arg 1." > /dev/stderr
  exit
fi

xhost +; docker run -ti --rm --build-arg IMAGE=openspace-ubuntu-2204-gcc11 --gpus all --runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=graphics,display --privileged --cap-add SYS_ADMIN --cap-add MKNOD \
  --device /dev/fuse -v /dev:/dev \
  ${DisplayForwarding} \
  ${imageToRun} \
  bash
