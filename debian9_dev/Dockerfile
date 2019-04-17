FROM debian:9

# use UTC as localtime
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN	apt update && \
	apt install -y \
			git \
			wget \
			vim \
			python-dev \
			python-pip \
			debhelper \
			build-essential \
			cmake \
			gcc \
			g++ \
			postgresql-server-dev-all \
			protobuf-compiler \
			rabbitmq-server \
			libboost-all-dev \
			liblog4cplus-1.1-9 \
			liblog4cplus-dev \
			libprotobuf-dev \
			libproj-dev libpqxx3-dev \
			libgeos-c1v5 \
			libgoogle-perftools4 \
			libgoogle-perftools-dev \
			libzmq3-dev \
			libosmpbf-dev \
			libssl1.0-dev \
			python-protobuf

RUN pip install pip -U virtualenv  ujson==1.33 numpy==1.9 && \
	rm -rf /tmp/* /var/tmp/* ~/.cache/pip/* /var/lib/apt/lists/* 

# add user and group jenkins, with specific userid and groupid, never fail
RUN groupadd -g 115 jenkins; exit 0
RUN useradd -u 109 -g 115 jenkins | chpasswd; exit 0

CMD ["/usr/sbin/rabbitmq-server"]
