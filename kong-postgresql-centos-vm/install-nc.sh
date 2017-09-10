#!/bin/bash

echo "Step 1: Installing netcat(nc).."
sudo yum install -y nc

echo "Step 2: Opening firewalld port 8099.."
sudo firewall-cmd --zone=public --add-port=8099/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all

echo Done
