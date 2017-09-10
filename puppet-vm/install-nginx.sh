#!/bin/bash

SECONDS=0
DURATION=0
NGINX_VERSION="1.8.1"

echo "This may take a few mins.."
echo "Step 1: Configuring the nginx yum repo.."

cat << EOM > /tmp/my-nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOM

sudo cp /tmp/my-nginx.repo /etc/yum.repos.d/

echo
echo "Step 2: Intalling nginx-${NGINX_VERSION}"
sudo yum install -y -e 0 -d 1 nginx-${NGINX_VERSION} 

echo "Installed nginx version=$(nginx -v)"
echo "Installed nginx rpms=$(rpm -qa | grep nginx)"

ech0
echo "Step 3: Opening port 80.."
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=9001/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all

echo
echo "Step 4: Restarting nginx.."
sudo systemctl restart nginx 
sudo systemctl status nginx

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

