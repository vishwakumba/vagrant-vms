#!/bin/bash

SECONDS=0
DURATION=0
NAGIOS_CORE_VERSION="4.2.4"
NAGIOS_PLUGINS_VERSION="2.1.4"
WORK_DIR="$HOME/install-nagios-temp"

echo "This may take a few mins.."
echo "Step 1: Installing nagios prerequisites.."
echo sudo yum install -y -e 0 -d 0 httpd php gcc glibc glibc-common gd gd-devel make net-snmp unzip
sudo yum install -y -e 0 -d 0 httpd php gcc glibc glibc-common gd gd-devel make net-snmp unzip

echo
echo "Step 2: Creating nagios user and nagcmd group.."
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -G nagcmd nagios
sudo usermod -G nagcmd apache

echo
echo "Step 3: Creating the temporary working directory=$WORK_DIR.."
sudo rm -rf $WORK_DIR
sudo mkdir -p $WORK_DIR
cd $WORK_DIR

echo
echo "Step 4: Download and extract nagios-core,nagios-plugins tar files.."
echo sudo curl -Lk -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-${NAGIOS_CORE_VERSION}.tar.gz
sudo curl -Lk -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-${NAGIOS_CORE_VERSION}.tar.gz
echo sudo curl -Lk -O https://nagios-plugins.org/download/nagios-plugins-${NAGIOS_PLUGINS_VERSION}.tar.gz
sudo curl -Lk -O https://nagios-plugins.org/download/nagios-plugins-${NAGIOS_PLUGINS_VERSION}.tar.gz
sudo tar -xf nagios-${NAGIOS_CORE_VERSION}.tar.gz
sudo tar -xf nagios-plugins-${NAGIOS_PLUGINS_VERSION}.tar.gz

ls -lh

echo
echo "Step 5: Compile and the build nagios core bundle to produce the nagios core binaries.."  
cd $WORK_DIR/nagios-${NAGIOS_CORE_VERSION}
sudo ./configure --with-command-group=nagcmd
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode
sudo make install-webconf

echo
echo "Step 6: Update the emaild in contacts.cfg file.."  
sudo sed -i 's/nagios@localhost/vishwa.dwp@gmail.com/g' /usr/local/nagios/etc/objects/contacts.cfg

echo
echo "Step 7: Generate password for the nagiosadmin user.."  
sudo htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin 

echo
echo "Step 8: Start Apache(httpd) Service.."  
sudo systemctl start httpd.service

echo 
echo "Step 9: Compile and build nagios plugins bundle to produce nagios plugins binaries.."  
cd $WORK_DIR/nagios-plugins-${NAGIOS_PLUGINS_VERSION}
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make
sudo make install

echo 
echo "Step 10: Enabling and restarting nagios and httpd(apache).."  
sudo systemctl enable nagios
sudo systemctl enable httpd
sudo systemctl start nagios
sudo systemctl status httpd.service
sudo systemctl status nagios.service

echo 
echo "Step 11: Opening the port 80.."  
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload

DURATION=$SECONDS
echo "Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

echo
echo Done

