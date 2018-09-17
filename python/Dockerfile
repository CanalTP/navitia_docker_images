FROM alpine:3.8

LABEL "io.navitia.name"="navitia/python"

WORKDIR /
RUN apk --update --no-cache add \
    g++ \
    build-base \
    libstdc++ \
    python \
    musl-dev \
    linux-headers \
    python-dev \
    py2-pip \
    git \
    curl \
    automake \
    autoconf \
    libtool && \
    pip install  --no-cache-dir -U pip && \
    pip install --no-cache-dir uwsgi && \
    git clone https://github.com/google/protobuf.git && cd protobuf && \
    git checkout v3.3.0 && ./autogen.sh && ./configure && make -j$(grep -c vendor_id /proc/cpuinfo) && \
    make install && \
    cd python && python setup.py install --cpp_implementation && \
    cd / && rm -rf protobuf && apk del \
        g++ \
        build-base \
        python-dev \
        git \
        curl \
        automake \
        autoconf \
        libtool \
        musl-dev \
        linux-headers
