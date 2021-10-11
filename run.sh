#!/usr/bin/env bash


DEBIAN_FRONTEND=noninteractive
GO_VERSION="${INPUT_GO_VERSION:-1.17.2}"
ARCH="${INPUT_ARCH:-amd64}"

WORKDIR=$(mktemp -d)

apt-get update -yqq
apt-get install -yqq curl

# Install Go
curl -sSL -o ${WORKDIR}/go${GO_VERSION}.linux-${ARCH}.tar.gz https://dl.google.com/go/go${GO_VERSION}.linux-${ARCH}.tar.gz
rm -rf /usr/local/go 
tar -C /usr/local -xzf ${WORKDIR}/go${GO_VERSION}.linux-${ARCH}.tar.gz

# Update $PATH
echo "PATH=$PATH:/usr/local/go/bin" >> /opt/stepssharedfolder/sharedEnv 

source /etc/profile

# Cleanup
rm -fr ${WORKDIR}
