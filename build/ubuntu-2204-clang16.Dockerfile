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
ADD data/llvm-16.list /etc/apt/sources.list.d/
ADD data/llvm-snapshot.gpg.key.gpg /etc/apt/trusted.gpg.d/
RUN mv /etc/apt/sources.list.d/llvm-16.list /etc/apt/sources.list.d/llvm.list
RUN apt-get update
RUN apt-get install -y clang-16
RUN apt-get install -y clang-tools-16
RUN apt-get install -y clang-format-16
RUN apt-get install -y libfuzzer-16-dev
RUN apt-get install -y lldb-16
RUN apt-get install -y lld-16
RUN apt-get install -y libc++-16-dev
RUN apt-get install -y libc++abi-16-dev
RUN apt-get install -y libomp-16-dev
RUN apt-get install -y libunwind-16-dev
RUN apt-get install -y libpolly-16-dev
RUN apt-get install -y libclc-16-dev
RUN ln -s /usr/bin/clang++-16 /usr/bin/clang++
RUN ln -s /usr/bin/clang-16 /usr/bin/clang

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

ENV CMAKE_EXPORT_COMPILE_COMMANDS=1

# Prepare the build settings
COPY data/build.sh /
