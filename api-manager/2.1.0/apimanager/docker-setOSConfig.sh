#!/bin/bash

# add line to the Linux configuration
echo "net.ipv4.tcp_fin_time = 30" >> /etc/sysctl.conf
echo "fs.file-max = 2097152" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
echo "net.core.rmem_default = 524288" >> /etc/sysctl.conf
echo "net.core.wmem_default = 524288" >> /etc/sysctl.conf
echo "net.core.rmem_max = 67108864" >> /etc/sysctl.conf
echo "net.core.wmem_max = 67108864" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 4096 87380 16777216" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 4096 87380 16777216" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 1024 65535" >> /etc/sysctl.conf


echo "* soft nofile 4096" >> /etc/security/limits.conf
echo "* hard nofile 65535" >> /etc/security/limits.conf

echo "* soft nproc 20000" >> /etc/security/limits.conf
echo "* hard nproc 20000" >> /etc/security/limits.conf
