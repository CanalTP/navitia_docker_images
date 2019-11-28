FROM debian:8

LABEL "io.navitia.name"="navitia/python"

WORKDIR /

RUN apt-get update --fix-missing \
    &&  apt-get upgrade -y \
    &&  apt-get install -y \
        libpython2.7 \
        python \
        python-dev \
        python-pip \
        wget \
        curl \
        unzip \
        automake \
        autoconf \
        libtool \ 
	&&	pip install --upgrade pip && pip install uwsgi \
    &&  wget https://github.com/protocolbuffers/protobuf/archive/v3.3.2.tar.gz && tar -xf v3.3.2.tar.gz \
    &&  cd protobuf-3.3.2 \ 
    &&  ./autogen.sh && ./configure && make -j$(grep -c vendor_id /proc/cpuinfo) && make install \ 
    &&  cd python && python setup.py install --cpp_implementation \
    &&  cd / \
    &&  rm -f v3.3.2.tar.gz && rm -rf protobuf* \
    &&  apt-get autoremove -y \
        python-dev \
        python-pip \
        curl \
        unzip \
        automake \
        autoconf \
        libtool \
        wget
