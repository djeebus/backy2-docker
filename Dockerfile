FROM debian:bullseye

# install backy2 deps
RUN \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ >/etc/timezone && \
    apt update && \
    apt install -y wget python3-pip gettext-base && \
    pip3 install pycryptodome zstandard boto

ARG BACKY2_VERSION=2.13.8

RUN \
    wget https://github.com/wamdam/backy2/releases/download/${BACKY2_VERSION}/backy2_${BACKY2_VERSION}_all.deb \
        --output-document /tmp/backy2.deb && \
    apt install -y /tmp/backy2.deb

ARG CEPH_VERSION=quincy
# install ceph
RUN \
    wget https://github.com/ceph/ceph/raw/${CEPH_VERSION}/src/cephadm/cephadm \
      --output-document ./cephadm && \
    chmod +x ./cephadm && \
    ./cephadm add-repo --release ${CEPH_VERSION} && \
    apt install -y ceph-common
