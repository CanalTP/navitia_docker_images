FROM ubuntu:18.04

# use UTC as localtime
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN apt-get update \
 && apt-get install -y \
	 	build-essential \
	 	git \
	 	gcc \
	 	g++ \
	 	cmake \
	 	protobuf-compiler \
	 	libosmpbf-dev \
	 	libboost-all-dev \
	 	libgoogle-perftools-dev \
	 	libprotobuf-dev \
	 	libproj-dev \
	 	libzmq3-dev \
	 	libpqxx-dev \
	 	libssl-dev \
		liblog4cplus-dev \
		libgeos-dev \
	 	python \
	 	python-pip \
	 	rabbitmq-server \
	 	clang-format-6.0 \
	 	curl 	\
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -q https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
    && python /tmp/get-pip.py               \
    && pip install -U virtualenv pipenv     \
 	# install dependancies for libc         \
    && pip install ujson==1.33 numpy==1.9	\
    && rm -rf /tmp/* /var/tmp/* ~/.cache/pip/*

# add user and group jenkins, with specific userid and groupid, never fail
RUN groupadd -g 115 jenkins; exit 0
RUN useradd -u 109 -g 115 jenkins | chpasswd; exit 0

CMD ["/usr/sbin/rabbitmq-server"]
