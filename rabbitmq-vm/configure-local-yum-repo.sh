#!/bin/bash

if [ ! -d "/etc/yum.repos.d.backup" ]; then 
  sudo mkdir -p /etc/yum.repos.d.backup
  sudo mv /etc/yum.repos.d/* /etc/yum.repos.d.backup/
fi 

cat << EOM > /tmp/mypuppet.repo
[yum-puppet-repo]
name=yum-centos-repo
baseurl=http://192.168.150.150/puppet-4.7.0
enabled=1
gpgcheck=0
EOM

sudo cp /tmp/mypuppet.repo /etc/yum.repos.d/

cat << EOM > /tmp/mycentos7.repo
[yum-centos-repo]
name=yum-centos-repo
baseurl=http://192.168.150.150/centos7
enabled=1
gpgcheck=0
EOM

sudo cp /tmp/mycentos7.repo /etc/yum.repos.d/

sleep 2
sudo yum clean all

echo Done
