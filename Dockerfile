FROM --platform=linux/amd64 emscripten/emsdk
LABEL maintainer="Emir Marques <emirdeliz@gmail.com>"

RUN apt-get update && \
    apt-get install -y \
    g++ git wget cmake sudo

RUN apt-get install -y \
    build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
    python3-dev python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev \
    libcanberra-gtk-module libcanberra-gtk3-module libprotobuf-dev protobuf-compiler

RUN git clone https://github.com/opencv/opencv.git && ls && \
    cd opencv && mkdir build && cd build && \
    cmake -D BUILD_opencv_python2=OFF -D BUILD_opencv_java=OFF -D BUILD_PROTOBUF=ON -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j"$(nproc)" && \
    make install && ldconfig

# Install node
RUN apt-get -y update && apt-get -y install nodejs npm && npm install -g yarn

RUN mkdir main
WORKDIR /main