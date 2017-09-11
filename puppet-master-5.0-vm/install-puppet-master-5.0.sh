#!/bin/bash

echo "Step 1: Installing PuppetMaster 5.0.."
sudo yum localinstall -y rpms/puppetserver-5.0.0-1.el7.noarch.rpm rpms/puppet-agent-5.1.0-1.el7.x86_64.rpm
echo

echo "Step 2: Configuring /etc/sysconfig/puppetserver.."
sudo cp /etc/sysconfig/puppetserver /etc/sysconfig/puppetserver-10.09.17
sudo sed -i 's/-Xms2g -Xmx2g/-Xms512m -Xmx512m/g' /etc/sysconfig/puppetserver 
echo

echo "Step 3: Starting PuppetServer.."
sudo systemctl enable puppetserver
sudo systemctl start puppetserver
echo

echo Done

