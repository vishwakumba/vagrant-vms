#!/bin/bash

echo "Step 1: Installing the puppet5 repo.."
sudo rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
echo

echo "Step 2: "
sudo yum localinstall -y rpms/puppetserver rpms/puppetserver-5.0.0-1.el7.noarch.rpm rpms/puppet-agent-5.1.0-1.el7.x86_64.rpm 

echo


echo Done

