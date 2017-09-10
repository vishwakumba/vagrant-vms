#!/bin/bash

echo "Step 1: Copying the nagios-agent bundle.."
cp /vagrant/nagios-agent/linux-nrpe-agent.tar.gz /tmp
echo

echo "Step 2: Extracting the bundle.."
cd /tmp
rm -f linux-nrpe-agent
tar -zxvf linux-nrpe-agent.tar.gz 
cd linux-nrpe-agent
echo

echo "Step 3: Installing the nagiosxi agent bundle.."
sudo ./fullinstall
echo

echo Done
