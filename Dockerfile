FROM ubuntu:18.04 as base

RUN apt-get update -y
RUN apt-get install -y git 
RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y curl
RUN apt-get install -y gnupg

# Install Bazel
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list 
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN apt-get update && apt-get -y install bazel

RUN apt-get install -y clang
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y cmake
RUN apt-get install -y libgtest-dev
RUN apt-get install -y libssl-dev

# Install cpp-netlib
RUN git clone --branch 0.13-release https://github.com/cpp-netlib/cpp-netlib.git /tmp/cpp-netlib
RUN cd /tmp/cpp-netlib && git submodule init && git submodule update
RUN mkdir ~/cpp-netlib-build && cd ~/cpp-netlib-build && cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ /tmp/cpp-netlib
RUN cd ~/cpp-netlib-build && make && make install

# Install inja
RUN apt install -y python-pip
RUN pip install cget
RUN cget install pantor/inja@v2.1.0
RUN cget install nlohmann/json@v3.1.0

RUN apt install -y vim

RUN apt-get clean 

# ENTRYPOINT ["python3", "app.py"]
