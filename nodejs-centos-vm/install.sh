#!/bin/bash

echo "Step 1: Installing nodejs 8.x.."
echo curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
echo
sudo yum -y install nodejs
echo

echo "Step 4: Opening Port 8100 for nodejs appl.."
sudo firewall-cmd --zone=public --add-port=8100/tcp --permanent
sudo firewall-cmd --reload
firewall-cmd --list-all

echo
echo Done

