FROM debian:9

# Setup time
ENV TZ=Europe/Paris
RUN rm -f /etc/localtime \
    && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Install backport to install clang-format-6.0
RUN echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backport.list
RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        build-essential \
        ca-certificates \
        cmake \
        cmake-curses-gui \
        clang-format-6.0 \
        curl \
        debhelper \
        g++ \
        gcc \
        git \
        libboost-all-dev \
        liblog4cplus-1.1-9 \
        liblog4cplus-dev \
        libgeos-c1v5 \
        libgoogle-perftools4 \
        libgoogle-perftools-dev \
        libosmpbf-dev \
        libproj12 \
        libproj-dev \
        libprotobuf-dev \
        libpqxx3-dev \
        libssl-dev \
        libzmq3-dev \
        postgresql-server-dev-all \
        protobuf-compiler \
        python-dev \
        python-protobuf \
        rabbitmq-server \
        software-properties-common \
        vim \
        virtualenvwrapper \
        wget

# Install Docker (because no "docker" binary is present with the package from standard repository)
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\") $(lsb_release -cs) stable"
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN apt-get update \
    && apt-get install -y docker-ce \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    

# Install Python 3.6 needed by black for our pre-commits
RUN curl 'https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tgz' | tar -xz -C /tmp/ \
    && cd /tmp/Python-3.6.8 \
    && ./configure \
    && make -j$(nproc) \
    && make altinstall \
    && rm -rf /tmp/*

# Can't use pip from system (too old)
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && pip install -U virtualenv pipenv \
    # install dependancies for libc
    && pip install ujson==1.33 numpy==1.9 \
    && rm -rf /tmp/* /var/tmp/* ~/.cache/pip/*

# Add a user "nav-dev" to avoid being "root" all the time and to map the system's user in Docker
RUN groupadd -g 1000 nav-dev
RUN useradd -l -m -u 1000 -g 1000 -s /bin/bash nav-dev
RUN groupmod -g 965 docker
RUN usermod -aG docker nav-dev

# Extract Python virtual environment requirements from Navitia repository
RUN wget -P /tmp https://raw.githubusercontent.com/CanalTP/navitia/dev/requirements_pre-commit.txt \
    && wget -P /tmp/source/eitri https://raw.githubusercontent.com/CanalTP/navitia/dev/source/eitri/requirements.txt \
    && wget -P /tmp/source/cities https://raw.githubusercontent.com/CanalTP/navitia/dev/source/cities/requirements.txt \
    && wget -P /tmp/source/tyr https://raw.githubusercontent.com/CanalTP/navitia/dev/source/tyr/requirements.txt \
    && wget -P /tmp/source/tyr https://raw.githubusercontent.com/CanalTP/navitia/dev/source/tyr/requirements_dev.txt \
    && wget -P /tmp/source/monitor https://raw.githubusercontent.com/CanalTP/navitia/dev/source/monitor/requirements.txt \
    && wget -P /tmp/source/jormungandr https://raw.githubusercontent.com/CanalTP/navitia/dev/source/jormungandr/requirements.txt \
    && wget -P /tmp/source/jormungandr https://raw.githubusercontent.com/CanalTP/navitia/dev/source/jormungandr/requirements_dev.txt \
    && wget -P /tmp/source/sql https://raw.githubusercontent.com/CanalTP/navitia/dev/source/sql/requirements.txt

# Create Python virtual environment
RUN cd /home/nav-dev \
    && su - nav-dev -c "/bin/bash -c \"source /usr/share/virtualenvwrapper/virtualenvwrapper.sh && mkvirtualenv -p /usr/bin/python2 nav-py2 && pip install -r /tmp/source/eitri/requirements.txt && pip install -r /tmp/source/cities/requirements.txt && pip install -r /tmp/source/tyr/requirements_dev.txt && pip install -r /tmp/source/monitor/requirements.txt && pip install -r /tmp/source/jormungandr/requirements_dev.txt && pip install -r /tmp/source/sql/requirements.txt\"" \
    && rm -rf /tmp/*

# Add basic aliases
RUN echo "" >> /home/nav-dev/.bashrc
RUN echo "alias l='ls'" >> /home/nav-dev/.bashrc
RUN echo "alias ll='ls -la'" >> /home/nav-dev/.bashrc
# Embed Navitia environment
RUN echo "" >> /home/nav-dev/.bashrc
RUN echo "source ~/env_kisio.sh" >> /home/nav-dev/.bashrc
COPY ./env_kisio.sh /home/nav-dev/env_kisio.sh
 
# Add entry point script for everyone
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN passwd -d root

ENTRYPOINT ["/entrypoint.sh"]
