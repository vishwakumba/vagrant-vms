#!/bin/bash

SECONDS=0
DURATION=0
NAGIOS_CORE_VERSION="4.2.4"
NAGIOS_PLUGINS_VERSION="2.1.4"
WORK_DIR="$HOME/install-nagios-temp"

echo "This may take a few mins.."
echo "Step 1: Stopping nagios and httpd servers.."
sudo systemctl stop nagios
sudo systemctl stop httpd 

echo "Step 2: Uninstalling nagios prerequisites.."
sudo yum remove -y -e 0 -d 0 httpd php gcc glibc glibc-common gd gd-devel make net-snmp unzip
sudo rm -rf /usr/local/nagios

echo
echo "Step 3: Removing nagios user and nagcmd group.."
sudo userdel nagios
sudo groupdel nagcmd

echo
echo "Step 4: Removing the working directory.."
sudo rm -rf $WORK_DIR

echo
echo "Step 5: Download and extract nagios-core,nagios-plugins tar files.."
DURATION=$SECONDS
echo "Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

echo
echo Done

