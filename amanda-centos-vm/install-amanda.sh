#!/bin/bash

echo "Step 1: Installing the epel yum repo.."
sudo yum install -y epel-release

echo "Step 2: Setting the hostname to amanda-server.."
sudo hostnamectl set-hostname amanda-server

echo "Step 3: Updating /etc/hosts.."
sudo sh -c "echo 192.168.95.95 amanda-server > /etc/hosts"

echo "Step 4: Installing Amanda Updating.." 
sudo yum install -y amanda*

echo "Step 5: Installing Addons.." 
sudo yum install -y xinetd gnuplot perl-ExtUtils-Embed 

echo "Step 6: Restarting xinetd service.." 
sudo systemctl restart xinetd 
sudo systemctl status xinetd 

echo "Step 7: Checking Amanda version.." 
sudo amadmin --version

#echo "Step 8: Configuring Amanda Backup Server.".
#sudo mkdir /amanda
#sudo chown amandabackup /amanda/ /etc/amanda/


#Amanda backup clent machines
#sudo yum install amanda-client xinetd
