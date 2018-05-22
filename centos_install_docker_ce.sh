#!/bin/bash

# Uninstall old versions
yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-selinux \
           docker-engine-selinux \
           docker-engine

# SET UP THE REPOSITORY
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# INSTALL DOCKER CE
yum install -y docker-ce

# start and run
systemctl start docker
docker run hello-world
