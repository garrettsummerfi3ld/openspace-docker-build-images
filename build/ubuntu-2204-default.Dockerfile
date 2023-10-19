FROM ubuntu:22.04

RUN apt-get update

# Get a supported version for CMake and install
RUN apt-get install -y ca-certificates gpg wget
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
RUN sudo rm /usr/share/keyrings/kitware-archive-keyring.gpg
RUN sudo apt-get install kitware-archive-keyring
RUN apt-get update
RUN apt-get install -y cmake

# Set up the compiler
RUN apt-get install -y build-essential
RUN apt-get install -y git

# Install the remaining OpenSpace dependencies
RUN apt-get install -y freeglut3-dev
RUN apt-get install -y libxrandr-dev
RUN apt-get install -y libxinerama-dev
RUN apt-get install -y xorg-dev
RUN apt-get install -y libxcursor-dev
RUN apt-get install -y libxi-dev
RUN apt-get install -y libasound2-dev
RUN apt-get install -y libgdal-dev
RUN apt-get install -y qt6-base-dev
RUN apt-get install -y libmpv-dev
RUN apt-get install -y libvulkan-dev

# Prepare the build settings
COPY data/build.sh /
