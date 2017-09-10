#!/bin/bash

echo "This may take a few mins.."

source /vagrant/add-mycentos-yum-repo.sh
source /vagrant/add-mylocal-yum-repo.sh

echo "Step 1: Installing OpenJDK 1.8.0..."
sudo yum install -y java-1.8.0-openjdk-devel
echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> $HOME/.bashrc
echo

echo "Step 2: Installing ElasticSearch.."
sudo yum install -y elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl restart elasticsearch

#This is required for graylog
sudo bash -c 'echo "cluster.name: graylog" >> /etc/elasticsearch/elasticsearch.yml'
echo

echo "Step 3: Installing MongoDB.."
sudo yum install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod
echo

echo "Step 4: Installing Graylog Server(Rest and Web)"
sudo yum install -y graylog-server
sudo systemctl enable graylog-server
sudo cp /etc/graylog/server/server.conf /etc/graylog/server/server.conf.backup
sudo cp /vagrant/graylog-server-2.3.0.conf /etc/graylog/server/server.conf
echo

echo "Step 5: Opening Graylog web port 9000.."
sudo firewall-cmd --zone=public --add-port=9000/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5044/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5045/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5046/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo "Step 6: Starting Graylog Server.."
sudo systemctl start graylog-server
sudo systemctl status graylog-server

echo Done
