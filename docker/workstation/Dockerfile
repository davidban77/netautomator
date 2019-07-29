FROM continuumio/miniconda3

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    acl \
    bzip2 \
    curl \
    debhelper \
    debianutils \
    devscripts \
    dpkg-dev \
    gcc \
    git \
    libffi-dev \
    libssl-dev \
    libxml2-utils \
    locales \
    make \
    mercurial \
    openssh-client \
    openssh-server \
    pass \
    sudo \
    tzdata \
    unzip \
    zip \
    wget \
    sshpass \
    net-tools \
    vim \
    zsh \
    && \
    apt-get clean

RUN pip install pip --upgrade

RUN pip install --upgrade cryptography \
    ipython \
    poetry

# undo some leet hax of the base image
RUN rm /usr/sbin/policy-rc.d; \
	rm /sbin/initctl; dpkg-divert --rename --remove /sbin/initctl
# remove some pointless services
RUN /usr/sbin/update-rc.d -f ondemand remove; \
	for f in \
		/etc/init/u*.conf \
		/etc/init/mounted-dev.conf \
		/etc/init/mounted-proc.conf \
		/etc/init/mounted-run.conf \
		/etc/init/mounted-tmp.conf \
		/etc/init/mounted-var.conf \
		/etc/init/hostname.conf \
		/etc/init/networking.conf \
		/etc/init/tty*.conf \
		/etc/init/plymouth*.conf \
		/etc/init/hwclock*.conf \
		/etc/init/module*.conf\
	; do \
		dpkg-divert --local --rename --add "$f"; \
	done; \
	echo '# /lib/init/fstab: cleared out for bare-bones Docker' > /lib/init/fstab
# end things from ubuntu-upstart Dockerfile

RUN rm /etc/apt/apt.conf.d/docker-clean
RUN locale-gen en_US.UTF-8
RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    for key in /etc/ssh/ssh_host_*_key.pub; do echo "localhost $(cat ${key})" >> /root/.ssh/known_hosts; done

ENV container=docker
# terminal colors with xterm
ENV TERM xterm

# run the ohmyzsh installation script
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="kphoen"/g' /root/.zshrc

# AllowTcpForWarding
RUN sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
WORKDIR /root
ENTRYPOINT service ssh restart && zsh
