#!/bin/bash

sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
sudo cp /vagrant/sshd_config /etc/ssh/
sudo chmod 600 /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config

sudo mkdir -p /super-heroes-work

sudo userdel -f batman
sudo groupdel super-heroes

sudo groupadd super-heroes  
sudo useradd batman -g super-heroes -s /bin/false -d /super-heroes-work/batman-work
echo "batman:batman" | sudo chpasswd

sudo systemctl restart sshd

echo "SFTP Configuration Complete"

