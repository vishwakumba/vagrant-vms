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
sudo systemctl restart cassandra
sudo systemctl status cassandra
echo

echo Done

