FROM ubuntu:22.04

ARG BACKY2_VERSION=0.0.0

RUN \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ >/etc/timezone && \
    apt update && \
    apt install -y wget python3-pip gettext-base && \
    pip3 install pycryptodome zstandard boto && \
    wget https://github.com/wamdam/backy2/releases/download/${BACKY2_VERSION}/backy2_${BACKY2_VERSION}_all.deb \
        --output-document /tmp/backy2.deb && \
    apt install -y /tmp/backy2.deb
