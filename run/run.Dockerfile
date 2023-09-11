ARG IMAGE
FROM ${IMAGE}

RUN export uid=1010 && \
    export gid=1000 && \
    mkdir -p /home/openspace && \
    mkdir -p /etc/sudoers.d && \
    echo "openspace:x:${uid}:${gid}:openspace,,,:/home/openspace:/bin/bash" >> /etc/passwd && \
    echo "openspace:x:${uid}:" >> /etc/group && \
    echo "openspacegroup:x:${gid}:" >> /etc/group && \
    echo "openspace ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/openspace

RUN echo "root:root" | chpasswd && \
    echo "openspace:openspace" | chpasswd

RUN chmod 0440 /etc/sudoers.d/openspace && \
    chown ${uid}:${gid} -R /home/openspace && \
    cd /home/openspace && \
    chown openspace:openspace -R .

# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get install -y tzdata
# RUN ln -fs /usr/share/zoneinfo/America/Denver /etc/localtime
# RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y x11-xserver-utils
RUN apt-get install -y xauth
# RUN apt-get install -y sudo
# RUN apt-get install -y gpg
# RUN apt-get install -y ca-certificates

RUN echo "user ALL=(ALL) ALL" >> /etc/sudoers

# RUN apt-get install -y software-properties-common
# RUN apt-get install -y synaptic
RUN apt-get install -y glew-utils
RUN apt-get install -y libpng-dev
RUN apt-get install -y libcurl4-openssl-dev

RUN su openspace;
RUN chown -R openspace:openspace .;
RUN mkdir -p /home/openspace

# Build OpenSpace
USER openspace

RUN su openspace; \
    chown -R openspace:openspace .; \
    mkdir -p /home/openspace/source; \
    cd /home/openspace/source; \
    git clone --recursive https://github.com/OpenSpace/OpenSpace; \
    mkdir /home/openspace/source/OpenSpace/build; \
    cd /home/openspace/source/OpenSpace/build; \
    cmake -DCMAKE_BUILD_TYPE:STRING="Release" \
    -DCMAKE_CXX_COMPILER:FILEPATH=/usr/bin/g++-11 \
    -DCMAKE_C_COMPILER:FILEPATH=/usr/bin/gcc-11 \
    -DASSIMP_BUILD_MINIZIP=1 /home/openspace/source/OpenSpace; \
    make -j4

ENV HOME /home/openspace
CMD /usr/bin/bash

