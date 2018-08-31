FROM debian:9

ENV TZ=Europe/Paris
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN apt-get update && \
	apt-get install -y \
		git \
		postgresql-server-dev-all \
		python-dev \
		libzmq3-dev \
		debhelper \
		build-essential \
		cmake \
		gcc \
		g++ \
		libboost-all-dev \
        liblog4cplus-1.1-9 \
		liblog4cplus-dev \
		libprotobuf-dev \
		protobuf-compiler \
		libproj12 \
		libproj-dev \
		libpqxx3-dev \
		rabbitmq-server \
		libgeos-c1v5 \
		libgoogle-perftools4 \
		libgoogle-perftools-dev \
		vim \
        libosmpbf-dev \
        python-protobuf \
        libssl-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# we can't use pip from system it's too old
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py \
    && pip install -U virtualenv  && \
	# install dependancies for libc
	pip install ujson==1.33 numpy==1.9 && \
	rm -rf /tmp/* /var/tmp/* ~/.cache/pip/*

# add user and group jenkins, with specific userid and groupid, never fail
RUN groupadd -g 115 jenkins; exit 0
RUN useradd -u 109 -g 115 jenkins | chpasswd; exit 0

CMD ["/usr/sbin/rabbitmq-server"]
