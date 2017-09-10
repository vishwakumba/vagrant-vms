#!/bin/bash

# 04.07.17, latest stable version of cassandra seems to be 3.11.0

JAVA_VERSION="1.8.0"

echo "This may take a few mins.."
echo "Step 1: Installing OpenJDK ${JAVA_VERSION}"
#sudo yum install -y -e 0 -d 0 java-${JAVA_VERSION}-openjdk 
sudo yum install -y java-${JAVA_VERSION}-openjdk 
echo

echo "Step 2: Initialising the cassandra yum repo .."
cat <<EOF > /tmp/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
EOF
sudo cp /tmp/cassandra.repo /etc/yum.repos.d

echo "Step 3: Installing cassandra(3.11.0) "
sudo yum install -y cassandra
sudo systemctl daemon-reload
sudo systemctl enable cassandra
echo

echo "Step 4: Starting cassandra.."
sudo systemctl start cassandra
sudo systemctl status cassandra
echo "Sleeping for 30 sec, so that cassandra is fully started.."
sleep 30
echo

echo "Step 5: Downloading and installing kong rpm(0.10.3).."
curl -sSLk https://github.com/Mashape/kong/releases/download/0.10.3/kong-0.10.3.el7.noarch.rpm -o /tmp/kong-0.10.3.el7.noarch.rpm
sudo yum localinstall -y /tmp/kong-0.10.3.el7.noarch.rpm
echo

echo "Step 6: Configuring Kong, opening firewalld port 8000.."
sudo cp /vagrant/kong.conf /etc/kong/kong.conf
sudo firewall-cmd --zone=public --add-port=8000/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo "Step 7: Starting kong.."
kong start
echo
kong health
echo
echo Done

