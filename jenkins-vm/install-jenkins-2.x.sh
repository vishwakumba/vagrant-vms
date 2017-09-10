#!/bin/bash

JAVA_VERSION="1.8.0"

echo "This may take a few mins.."
echo "Step 1: Installing OpenJDK ${JAVA_VERSION}"
sudo yum install -y -e 0 -d 0 java-${JAVA_VERSION}-openjdk 
echo

echo "Step 2: Installing the lastest Jenkins version.."
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
echo

sudo yum install -y -e 0 -d 0 jenkins
echo

echo "Step 3: Restarting Jenkins.."
sudo systemctl restart jenkins
sudo systemctl status jenkins
echo

echo "Step 4: Opening Port 8080.."
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
firewall-cmd --list-all

echo
echo Done

