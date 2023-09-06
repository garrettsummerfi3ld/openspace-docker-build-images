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
RUN apt-get install -y software-properties-common
RUN apt-get install -y gnupg
RUN apt-get install -y apt-transport-https
RUN apt-get install -y ca-certificates
ADD data/llvm.list /etc/apt/sources.list.d/
ADD data/llvm-snapshot.gpg.key.gpg /etc/apt/trusted.gpg.d/
RUN apt-get update
RUN apt-get install -y clang-15
RUN apt-get install -y clang-tools-15
RUN apt-get install -y clang-format-15
RUN apt-get install -y libfuzzer-15-dev
RUN apt-get install -y lldb-15
RUN apt-get install -y lld-15
RUN apt-get install -y libc++-15-dev
RUN apt-get install -y libc++abi-15-dev
RUN apt-get install -y libomp-15-dev
RUN apt-get install -y libunwind-15-dev
RUN apt-get install -y libclc-15-dev
RUN ln -s /usr/bin/clang++-15 /usr/bin/clang++
RUN ln -s /usr/bin/clang-15 /usr/bin/clang

ENV CC=/usr/bin/clang
ENV CXX=/usr/bin/clang++


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
