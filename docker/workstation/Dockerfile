FROM continuumio/miniconda3

ARG root_passwd=rooting

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    acl \
    bzip2 \
    curl \
    jq \
    tcptraceroute \
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
    telnet \
    iperf3 \
    mtr \
    snmpd \
    snmp \
    libsnmp-dev \
    && apt-get purge -y curl \
    && apt-get autoremove -y \
    && apt-get clean

# Upgrade pip and install poetry
RUN pip install pip --upgrade \
        && pip install --no-cache-dir --upgrade cryptography \
        ipython \
        poetry \
        && poetry config virtualenvs.create false \
        && poetry config virtualenvs.path /opt/conda/envs


# undo some leet hax of the base image
RUN rm /usr/sbin/policy-rc.d; \
	rm /sbin/initctl; dpkg-divert --rename --remove /sbin/initctl \
    && rm -rf /var/lib/apt/lists/*
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

RUN rm /etc/apt/apt.conf.d/docker-clean \
        && locale-gen en_US.UTF-8 \
        && ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa \
        && cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys \
        && for key in /etc/ssh/ssh_host_*_key.pub; do echo "localhost $(cat ${key})" >> /root/.ssh/known_hosts; done

WORKDIR /root

ENV container=docker
# terminal colors with xterm
ENV TERM xterm

# run the ohmyzsh installation script
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
    && sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="kphoen"/g' /root/.zshrc \
    && conda init zsh

# SSH part
RUN echo "root:$root_passwd" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ENTRYPOINT service ssh restart && zsh
