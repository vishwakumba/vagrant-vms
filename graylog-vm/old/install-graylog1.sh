#!/bin/bash

echo "This may take a few mins.."

source /vagrant/add-mycentos-yum-repo.sh

echo "Step 1: Installing OpenJDK 1.8.0..."
sudo yum install -y java-1.8.0-openjdk-devel
echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> $HOME/.bashrc
echo

echo "Step 2: Installing ElasticSearch.."
sudo curl http://mycentos.myworld.net/mylocal/elasticsearch/GPG-KEY-elasticsearch -o /etc/pki/rpm-gpg/GPG-KEY-elasticsearch 
sudo rpm --import /etc/pki/rpm-gpg/GPG-KEY-elasticsearch 

sudo yum install -y elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl restart elasticsearch

#This is required for graylog
sudo bash -c 'echo "cluster.name: graylog" >> /etc/elasticsearch/elasticsearch.yml'
echo

echo "Step 3: Installing MongoDB.."
sudo curl https://www.mongodb.org/static/pgp/server-3.4.asc -o /etc/pki/rpm-gpg/GPG-KEY-mongodb
sudo rpm --import /etc/pki/rpm-gpg/GPG-KEY-mongodb

echo "
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/GPG-KEY-mongodb
" > /tmp/mongodb.repo

sudo cp /tmp/mongodb.repo /etc/yum.repos.d/

sudo yum install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod
echo

echo "Step 4: Installing Graylog Server(Rest and Web)"
sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-2.2-repository_latest.rpm
sudo yum install -y graylog-server
sudo systemctl enable graylog-server
sudo cp /etc/graylog/server/server.conf /etc/graylog/server/server.conf.backup
sudo cp /vagrant/server.conf /etc/graylog/server/
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
