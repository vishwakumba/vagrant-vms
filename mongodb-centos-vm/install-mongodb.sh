#!/bin/bash

echo "Step 1: Initialising the yum repo .."
cat <<EOF > /tmp/mongodb.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOF
echo

sudo cp /tmp/mongodb.repo /etc/yum.repos.d/

echo "Step 2: Installing MongoDB .."
sudo yum install mongodb-org -y
echo
echo Done

#Note : mongodb-org package includes mongodb-org, mongodb-org-server, mongodb-org-mongos, mongodb-org-shell, mongodb-org-tools

