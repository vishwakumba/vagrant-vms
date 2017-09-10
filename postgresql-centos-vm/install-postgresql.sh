#!/bin/bash

# 20.06.17, latest stable version of postgresql seems to be 9.6.3  

echo "Step 1: Initialising the postgresql yum repo .."
sudo yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm

echo "Step 2: Installing Postgresql 9.6.."
sudo yum install -y postgresql96 postgresql96-lib postgresql96-server postgresql96-contrib 
sudo systemctl enable postgresql-9.6

echo "Step 3: Creating the symlink for postgresql service"
sudo ln -s /usr/lib/systemd/system/postgresql-9.6.service /etc/systemd/system/multi-user.target.wants/postgresql.service
# this step is required if any system service changes are made
sudo systemctl daemon-reload
echo

echo "Step 3: Creating the Postgresql cluster database.."
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb

echo "Step 4: Starting Postgresql.."
sudo systemctl start postgresql
sudo systemctl status postgresql
echo
echo Done


