FROM ubuntu:22.04

RUN apt-get update

# Get a supported version for CMake and install
RUN apt-get install -y wget
RUN wget https://github.com/Kitware/CMake/releases/download/v3.25.0/cmake-3.25.0-linux-x86_64.sh -q -O /tmp/cmake-install.sh
RUN chmod u+x /tmp/cmake-install.sh
RUN mkdir /opt/cmake
RUN /tmp/cmake-install.sh --skip-license --prefix=/opt/cmake
RUN ln -s /opt/cmake/bin/* /usr/local/bin

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

# Install dependencies for running unit tests
RUN apt-get install -y xvfb

ENV CMAKE_EXPORT_COMPILE_COMMANDS=1

# Prepare the build settings
COPY data/build.sh /
