#!/bin/bash

echo "Step 1: Installing nginx.."
sudo yum install epel-release -y
sudo yum install nginx -y 
echo

echo "Step 2: Restarting Nginx HTTP Web Server.."
sudo systemctl enable nginx
sudo systemctl restart nginx
sudo systemctl status nginx
echo

echo "Step 3: Opening http port 80.."
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --reload
firewall-cmd --list-all
echo

echo "Step 4: Mounting the CentOS 7 ISO Image.."
sudo mkdir -p /usr/share/nginx/html/centos7
sudo umount /usr/share/nginx/html/centos7
sudo mount -o loop /vagrant/CentOS-7-x86_64-Everything.iso /usr/share/nginx/html/centos7
echo

echo "Step 5: Installing createrepo tool.."
sudo yum install -y createrepo
echo

echo "Step 6: Copying puppet-4.7.0 rpms.."
sudo cp -r /vagrant/puppet-4.7.0 /usr/share/nginx/html/
sudo createrepo /usr/share/nginx/html/puppet-4.7.0
echo

echo "Step 7: Copying mylocal rpms.."
sudo cp -r /vagrant/mylocal /usr/share/nginx/html/
sudo createrepo /usr/share/nginx/html/mylocal
echo

echo "Done. centos7, puppet-4.7.0 and mylocal repos are set up now on this VM."


