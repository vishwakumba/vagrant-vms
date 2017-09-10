#!/bin/bash

echo "Step 1: Stop the mongod server.."
sudo systemctl stop mongod
echo

echo "Step 2: Remove the data and log directories.."
sudo rm -rf /var/log/mongodb
sudo rm -rf /var/lib/mongo
sudo rm -f /etc/mongod
echo

echo "Step 3: Stop the mongodb server.."
sudo yum erase -y $(rpm -qa | grep mongodb-org)
echo

echo Done

