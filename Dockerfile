FROM --platform=linux/amd64 emscripten/emsdk
LABEL maintainer="Emir Marques <emirdeliz@gmail.com>"

# https://www.geeksforgeeks.org/how-to-install-opencv-in-c-on-linux/

# # Install node
RUN apt-get -y update && apt-get -y install nodejs npm && npm install -g yarn

# Install OpenCV dependencies
RUN sudo apt-get -y update && apt-get install -y g++ cmake make git libgtk2.0-dev pkg-config

RUN mkdir main
WORKDIR /main

# Clone opencv from repo
RUN git clone https://github.com/opencv/opencv.git

RUN sh -c 'EMSCRIPTEN=/emsdk/upstream/emscripten python3 opencv/platforms/js/build_js.py opencv/build_wasm --build_wasm'