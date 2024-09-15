#
# blackbox_exporter Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV BLACKBOX_EXPORTER_VERSION=v0.25.0

# Create prometheus user
RUN useradd -ms /bin/bash prometheus

# Update & install needed packages
RUN apt-get update && \
    apt-get install -y wget

# missing folder created
RUN mkdir /etc/blackbox_exporter

# DL binary
RUN cd /tmp/ && \
    wget https://github.com/prometheus/blackbox_exporter/releases/download/${BLACKBOX_EXPORTER_VERSION}/blackbox_exporter-$(echo ${BLACKBOX_EXPORTER_VERSION} | sed 's/^v//').linux-amd64.tar.gz && \
    tar xf blackbox_exporter-$(echo ${BLACKBOX_EXPORTER_VERSION} | sed 's/^v//').linux-amd64.tar.gz && \
    cd blackbox_exporter-$(echo ${BLACKBOX_EXPORTER_VERSION} | sed 's/^v//').linux-amd64 && \
    mv blackbox_exporter /usr/local/sbin/blackbox_exporter && \
    mv blackbox.yml /etc/blackbox_exporter/blackbox.yml

CMD ["/usr/local/sbin/blackbox_exporter", "--config.file=/etc/blackbox_exporter/blackbox.yml" ]
