#!/bin/bash

echo "Step 1: Configuring plain FTP.."
if sudo bash -c "[ ! -r /etc/vsftpd/vsftpd.conf.original ]"; then     
  sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.original
fi

sudo cp /vagrant/vsftpd.conf.no.ssl /etc/vsftpd/vsftpd.conf

echo "Step 2: Restarting FTP Server.."
sudo systemctl enable vsftpd
sudo systemctl restart vsftpd
sudo systemctl status vsftpd

echo "Step 3: Opening 21 and multiple ports.."
sudo firewall-cmd --zone=public --add-port=49152/tcp --permanent
sudo firewall-cmd --zone=public --add-port=49152/tcp --permanent
sudo firewall-cmd --zone=public --add-port=49153/tcp --permanent
sudo firewall-cmd --reload
firewall-cmd --list-all
success


echo Done


