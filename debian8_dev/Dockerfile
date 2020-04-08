FROM debian:8

# use UTC as localtime
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN echo "deb http://apt.canaltp.local/debian/repositories jessie-dev main" > /etc/apt/sources.list.d/canaltp.list

RUN apt-get update && \
	apt-get install -y python-pip \
		git \
		postgresql-server-dev-all \
		libsqlite3-dev \
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
		libprotobuf-dev \
		protobuf-compiler \
		libproj0 \
		libproj-dev \
		libpqxx3-dev \
		rabbitmq-server \
		libgeos-c1 \
		libgoogle-perftools4 \
		libgoogle-perftools-dev \
		vim && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Python 3.6
RUN curl 'https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tgz' | tar -xz -C /tmp/      \
    && cd /tmp/Python-3.6.8     \
    && ./configure              \
    && make -j$(nproc)          \
    && make altinstall		\
    && rm -rf /tmp/*

# Add address of the canaltp.local apt server
RUN echo "nameserver 10.50.83.15" > /etc/resolv.conf \
		&& apt-get update \
		&& apt-get install -y wget \
		# Get the gpg key to authorize downloads from local apt server
		&& wget --output-document=- http://apt.canaltp.local/debian/repositories/canaltp.gpg.key | apt-key add - \
		&& apt-get -y --force-yes -t jessie-dev install libosmpbf-dev python-protobuf \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install pip virtualenv pipenv -U && \
	# install dependancies for libc
	pip install ujson==1.33 numpy==1.9 && \
	rm -rf /tmp/* /var/tmp/* ~/.cache/pip/*

# add user and group jenkins, with specific userid and groupid, never fail
RUN groupadd -g 115 jenkins; exit 0
RUN useradd -u 109 -g 115 jenkins | chpasswd; exit 0

CMD ["/usr/sbin/rabbitmq-server"]
