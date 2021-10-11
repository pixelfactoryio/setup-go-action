#!/usr/bin/env bash

set -xe

echo ${INPUT_GO_VERSION}

DEBIAN_FRONTEND=noninteractive
GO_VERSION="${INPUT_GO_VERSION:-1.17.2}"
WORKDIR=$(mktemp -d)

# https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
# rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
# export PATH=$PATH:/usr/local/go/bin

apt-get update -yqq
apt-get install -yqq curl

# Install Go
curl -sSL -o ${WORKDIR}/go${GO_VERSION}.linux-amd64.tar.gz https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go 
tar -C /usr/local -xzf ${WORKDIR}/go${GO_VERSION}.linux-amd64.tar.gz

# Update $PATH
echo "PATH=$PATH:/usr/local/go/bin" >> /opt/stepssharedfolder/sharedEnv 

source /etc/profile

# Cleanup
rm -fr ${WORKDIR}
