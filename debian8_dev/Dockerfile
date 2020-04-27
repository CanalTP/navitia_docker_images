FROM debian:8

# use UTC as localtime
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN apt-get update && \
	apt-get install -y python-pip \
        wget \
		postgresql-server-dev-all \
		python-dev \
		libzmq-dev \
		debhelper \
		build-essential \
		cmake \
		gcc \
		g++ \
		libboost-all-dev \
		liblog4cplus-1.0-4 \
		liblog4cplus-dev && \
	apt-get install -y --force-yes \
		libproj0 \
		libproj-dev \
		libpqxx3-dev \
		rabbitmq-server \
		libgeos-c1 \
		libgoogle-perftools4 \
		libgoogle-perftools-dev \
		vim && \
    apt-get install -y autoconf automake libtool curl make g++ unzip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Python 3.6 needed by black for our pre-commits
RUN wget 'https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tgz' -O - | tar -xz -C /tmp/      \
    && cd /tmp/Python-3.6.8     \
    && ./configure              \
    && make -j$(nproc)          \
    && make altinstall		\
    && rm -rf /tmp/*

# Build and Install Protobuf
RUN wget 'https://github.com/protocolbuffers/protobuf/archive/v3.3.1.tar.gz' -O - | tar -xz -C /tmp/ \
    && cd /tmp/protobuf-3.3.1/  \
    && ./autogen.sh \ 
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && ldconfig \
    && rm -rf /tmp/*

## Compile and Install Open Street Map protobuf
RUN wget 'https://github.com/openstreetmap/OSM-binary/archive/v1.3.3.tar.gz' -O - | tar -xz -C /tmp/  \
    && cd /tmp/OSM-binary-1.3.3/ \
    && make -C src \
    && make -C src install \
    && rm -rf /tmp/*

# Install the latest and Greatest of Git !
RUN apt-get update \
    && apt-get install -y dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* 
RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.26.2.tar.xz -O - | tar -xJ -C /tmp/ \
    && cd /tmp/git-2.26.2/ \
    && make configure \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && rm -rf /tmp/* /var/tmp/* \
    && git --version

RUN pip install pip virtualenv pipenv -U && \
	# install dependancies for libc
	pip install ujson==1.33 numpy==1.9 && \
	rm -rf /tmp/* /var/tmp/* ~/.cache/pip/*

# add user and group jenkins, with specific userid and groupid, never fail
RUN groupadd -g 115 jenkins; exit 0
RUN useradd -u 109 -g 115 jenkins | chpasswd; exit 0

CMD ["/usr/sbin/rabbitmq-server"]
