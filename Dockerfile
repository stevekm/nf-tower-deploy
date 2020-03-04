FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y \
    openjdk-8-jdk \
    git \
    make

RUN git clone https://github.com/seqeralabs/nf-tower.git && \
cd nf-tower && \
make build
