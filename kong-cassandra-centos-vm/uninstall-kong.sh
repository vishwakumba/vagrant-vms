#!/bin/bash

echo "Step 1: Stopping kong.."
sudo systemctl stop kong
sudo /usr/local/bin/kong stop
echo
sudo /usr/local/bin/kong health
echo

echo "Step 2: Uninstalling kong...."
sudo yum remove -y kong
sudo yum remove -y epel-release
sudo yum remove -y epel-release-7-9.noarch
sudo rm -rf /etc/kong
sudo rm -rf /usr/local/kong
sudo rm -rf /var/log/kong
echo

echo "Step 3: Removing firewalld port 8000"
sudo firewall-cmd --zone=public --remove-port=8000/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo Done

