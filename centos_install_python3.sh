#!/bin/bash

yum -y update
yum -y install yum-utils
yum -y groupinstall development
yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install python36u
yum -y install python36u-pip

ln -s -f /usr/bin/python3.6 /usr/bin/python
ln -s -f /usr/bin/pip3.6 /usr/bin/pip
