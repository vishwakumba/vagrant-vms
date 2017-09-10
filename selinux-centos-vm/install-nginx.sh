#!/bin/bash
cat << EOM > /tmp/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOM

sudo cp /tmp/nginx.repo /etc/yum.repos.d/

sudo yum install nginx -y
echo
sudo systemctl enable nginx
sudo systemctl start nginx
systemctl status nginx
echo

sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8081/tcp --permanent
sudo firewall-cmd --reload
firewall-cmd --list-all
echo

echo Done
