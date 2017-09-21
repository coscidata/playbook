#!/bin/bash

if [ ! -s "/root/.ssh/authorized_keys" ]; then
    echo "请先添加公钥到 ~/.ssh/authorized_keys"
fi


sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
service sshd restart
