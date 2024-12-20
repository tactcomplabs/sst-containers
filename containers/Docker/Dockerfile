# Use baseimage-docker which is a modified Ubuntu specifically for Docker
# https://hub.docker.com/r/phusion/baseimage
# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:jammy-1.0.4

# Update and install packages
RUN apt update && apt -y upgrade && apt -y install \
    build-essential \
    automake \
    openmpi-bin \
    libopenmpi-dev \
    python3 \
    python3-dev \
    python3-pip \
    doxygen \
    libjpeg8-dev \
    zlib1g-dev \
    valgrind

RUN python3 -m pip install --find-links=. \
    black 

ARG SSTver=14.1.0

RUN mkdir -p                      /opt/SST/${SSTver}/src
COPY sstcore-${SSTver}.tar.gz     /opt/SST/${SSTver}/src
COPY sstelements-${SSTver}.tar.gz /opt/SST/${SSTver}/src
WORKDIR                           /opt/SST/${SSTver}/src 
RUN tar --no-same-owner -xvzf sstcore-${SSTver}.tar.gz
WORKDIR /opt/SST/${SSTver}/src/sst-core
RUN ./configure --prefix=/opt/SST/${SSTver}; make -j4 all; make install

WORKDIR /opt/SST/${SSTver}/src
RUN tar --no-same-owner -xvzf sstelements-${SSTver}.tar.gz
WORKDIR /opt/SST/${SSTver}/src/sst-elements
RUN ./configure --prefix=/opt/SST/${SSTver}/elements -with-sst-core=/opt/SST/${SSTver}; make -j4 all; make install


