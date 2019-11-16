FROM docker.elastic.co/logstash/logstash:7.4.2

USER root

RUN yum -y install iproute \
    tcpdump \
    net-tools \
    vim

# Fixing user variable at the end so GNS3 can catch proper user
USER logstash
