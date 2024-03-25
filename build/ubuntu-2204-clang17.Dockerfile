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
ADD data/llvm-17.list /etc/apt/sources.list.d/
ADD data/llvm-snapshot.gpg.key.gpg /etc/apt/trusted.gpg.d/
RUN mv /etc/apt/sources.list.d/llvm-17.list /etc/apt/sources.list.d/llvm.list
RUN apt-get update
RUN apt-get install -y clang-17
RUN apt-get install -y clang-tools-17
RUN apt-get install -y clang-format-17
RUN apt-get install -y libfuzzer-17-dev
RUN apt-get install -y lldb-17
RUN apt-get install -y lld-17
RUN apt-get install -y libc++-17-dev
RUN apt-get install -y libc++abi-17-dev
RUN apt-get install -y libomp-17-dev
RUN apt-get install -y libunwind-17-dev
RUN apt-get install -y libpolly-17-dev
RUN apt-get install -y libclc-17-dev

RUN apt-get install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get install libstdc++6 libstdc++-13-dev

RUN ln -s /usr/bin/clang++-17 /usr/bin/clang++
RUN ln -s /usr/bin/clang-17 /usr/bin/clang

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

# Install dependencies for running unit tests
RUN apt-get install -y xvfb

ENV CMAKE_EXPORT_COMPILE_COMMANDS=1

# Prepare the build settings
COPY data/build.sh /
