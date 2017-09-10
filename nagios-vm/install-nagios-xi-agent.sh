#!/bin/bash

DIR=$(dirname $0)

SECONDS=0
DURATION=0
NOW=$(date +%Y%m%d-%H%M%S)

echo "Step 1: Configuring mycentos-yum-repo.."
cat <<SECTION > /tmp/mycentos.repo
[mycentos]
name=CentOS-\$releasever - Base
baseurl=http://mycentos-yum-repo.myworld.net/centos7
gpgcheck=0
SECTION

sudo mkdir -p /etc/yum.repos.d-${NOW}
sudo mv /etc/yum.repos.d/* /etc/yum.repos.d-${NOW}/
sudo cp /tmp/mycentos.repo /etc/yum.repos.d/
sudo yum clean all

LINE="192.168.150.150      mycentos-yum-repo.myworld.net"
sudo sed -i "$ a $LINE" /etc/hosts
echo

echo "Step 2: Copying the nagios-agent bundle.."
rm -rf /tmp/linux-nrpe-agent*
cp /vagrant/nagios-setup/linux-nrpe-agent.tar.gz /tmp
echo

echo "Step 3: Extracting the bundle.."
cd /tmp
tar -zxvf linux-nrpe-agent.tar.gz 
cd linux-nrpe-agent
echo

echo "Step 4: Installing the nagiosxi agent bundle.."
sudo ./fullinstall
echo

echo Done
