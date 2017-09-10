#!/bin/bash

echo "Step 1: Installing vsftpd packages.."
sudo yum install vsftpd -y
echo

echo "Step 2: Restarting FTP Server.."
sudo systemctl enable vsftpd
sudo systemctl restart vsftpd
sudo systemctl status vsftpd
echo

echo "Step 3: Restarting FTP Server.."
sudo firewall-cmd --zone=public --add-port=21/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo "Step 4: Creating a sample user called 'vish'.."
sudo userdel -r vish
sudo useradd vish
echo "vish" | sudo passwd --stdin vish 
echo

echo "Step 5: Creating a sample file called star.txt in /home/vish directory.."
echo "Twinkle twinkle little star!" > /tmp/star.txt
sudo cp /tmp/star.txt /home/vish

echo Done


