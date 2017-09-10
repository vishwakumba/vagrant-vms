#!/bin/bash

SECONDS=0

echo "Uninstalling Graylog, ElasticSearch, MongoDB and OpenJDK.."
echo

echo "Step 1: Removing port-access.." 
sudo firewall-cmd --zone=public --remove-port=9000/tcp --permanent
sudo firewall-cmd --zone=public --remove-port=5044/tcp --permanent
sudo firewall-cmd --zone=public --remove-port=5045/tcp --permanent
sudo firewall-cmd --zone=public --remove-port=5046/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo "Step 2: Uninstalling Graylog Server.."
sudo systemctl stop graylog-server
sudo systemctl disable graylog-server
sudo yum remove -y graylog-server
sudo rm -rf /etc/graylog /var/lib/graylog-server /var/log/graylog-server
echo

echo "Step 3: Uninstalling ElasticSearch.."
sudo systemctl stop elasticsearch
sudo systemctl disable elasticsearch
sudo yum remove -y elasticsearch
sudo rm -rf /etc/elasticsearch /var/lib/elasticsearch /var/log/elasticsearch
echo

echo "Step 4: Uninstalling MongoDB.."
sudo systemctl stop mongod
sudo systemctl disable mongod
sudo yum remove -y mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-tools mongodb-org-mongos
sudo rm -rf /var/lib/mongo /etc/mongod /var/log/mongodb 
echo

echo "Step 5: Uninstalling OpenJDK 1.8.0..."
sudo yum remove -y java-1.8.0-openjdk-devel  java-1.8.0-openjdk java-1.8.0-openjdk-headless
sed -i '/JAVA_HOME/d' $HOME/.bashrc
echo

echo "Step 6: Removing gysp-test-local.repo.."
sudo rm -f /etc/yum.repos.d/gysp-test-local.repo
sudo yum clean all
echo

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

