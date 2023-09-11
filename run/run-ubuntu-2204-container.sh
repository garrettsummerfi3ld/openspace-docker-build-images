#!/bin/bash

imageToRun=$1
DisplayForwarding=" -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY"

if [ "${imageToRun}" = "" ]; then
  echo "Need docker image to run as arg 1." > /dev/stderr
  exit
fi

xhost +; docker run -ti --rm --gpus all --runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=graphics,display --privileged --cap-add SYS_ADMIN --cap-add MKNOD \
  --device /dev/fuse -v /dev:/dev \
  ${DisplayForwarding} \
  ${imageToRun} \
  bash
