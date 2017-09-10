#!/bin/bash

echo "Step 1: Uninstalling ssmtp .."
sudo yum erase -y ssmtp 
sudo rm -rf /etc/ssmtp
echo

echo "Step 2: Unnstalling epel.repo .."
sudo yum erase -y epel-release
echo

echo Done

