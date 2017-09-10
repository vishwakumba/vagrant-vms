#!/bin/bash

SECONDS=0
DURATION=0
JAVA_VERSION="1.8.0"
JENKINS_VERSION="1.651.2"

echo "This may take a few mins.."
echo "Step 1: Installing OpenJDK ${JAVA_VERSION}"
sudo yum install -y -e 0 -d 0 java-${JAVA_VERSION}-openjdk 

echo "Step 2: Installing Jenkins ${JENKINS_VERSION}"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo yum install -y -e 0 -d 0 jenkins-${JENKINS_VERSION}

echo "Step 3: Restarting Jenkins.."
sudo systemctl restart jenkins

echo "Step 4: Opening Port 8080.."
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
firewall-cmd --list-all

DURATION=$SECONDS
echo "Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

echo
echo Done

