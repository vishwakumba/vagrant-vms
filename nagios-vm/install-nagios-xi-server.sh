#!/bin/bash

SECONDS=0
DURATION=0

BUNDLE="nagiosxi-5-4.8.el7.x86_64.tar.gz"
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

echo "Step 2: Copying $BUNDLE.."
rm -rf $HOME/work
mkdir $HOME/work
cd $HOME/work
#echo curl -O http://artifactory.itsshared.net:8081/artifactory/gysp-test-local/nagiosxi-5-4.8.el7.x86_64.tar.gz
#curl -O http://artifactory.itsshared.net:8081/artifactory/gysp-test-local/nagiosxi-5-4.8.el7.x86_64.tar.gz
cp /vagrant/nagios-setup/nagiosxi-5-4.8.el7.x86_64.tar.gz .
echo

echo "Step 3: Extracting the bundle.."
tar -zxvf $BUNDLE
cd nagiosxi
echo

echo "Step 4: Installing the Nagios Server.."
sudo ./fullinstall
echo

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

