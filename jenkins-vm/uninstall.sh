#!/bin/bash

SECONDS=0
DURATION=0

echo "This may take a few mins.."
echo "Step 1: Installing OpenJDK ${JAVA_VERSION}"
sudo yum install -y -e 0 -d 0 java-${JAVA_VERSION}-openjdk 

echo "Step 2: Installing Jenkins ${JENKINS_VERSION}"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

echo "Step 1: Stopping Jenkins.."
sudo systemctl stop jenkins

echo "Step 2: Removing access to port 8080.."
sudo firewall-cmd --zone=public --remove-port=8080/tcp --permanent
sudo firewall-cmd --reload
firewall-cmd --list-all

echo "Step 3: Uninstalling Jenkins.."
sudo yum remove -y -e 0 -d 1 jenkins

echo "Step 4: Uninstalling Jenkins.."
sudo yum remove -y -e 0 -d 1 java 

echo "Step 5: Removing jenkins.repo file.."
sudo yum remove -y -e 0 -d 1 java 
sudo rm -f /etc/yum.repos.d/jenkins.repo
sudo yum clean all

DURATION=$SECONDS
echo "Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

echo
echo Done

