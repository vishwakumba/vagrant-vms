#!/bin/bash

echo "Step 1: Stop the Postgresql server.."
sudo systemctl stop postgresql
sudo systemctl disable postgresql
echo

echo "Step 2: Uninstalling the postgresql packages.."
sudo yum erase -y postgresql96 postgresql96-lib postgresql96-server postgresql96-contrib
sudo yum erase -y pgdg-redhat96-9.6-3.noarch
echo

echo "Step 3: Removing the database directory.."
sudo rm -rf /var/lib/pgsql
echo

echo "Step 4: Removing the postgresql symlink service.."
sudo rm -f /etc/systemd/system/multi-user.target.wants/postgresql.service
echo

echo Done

