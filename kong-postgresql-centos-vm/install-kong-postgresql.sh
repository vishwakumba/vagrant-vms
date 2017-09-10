#!/bin/bash

echo "Step 1: Downloading and installing kong rpm(0.10.3).."
curl -sSLk https://github.com/Mashape/kong/releases/download/0.10.3/kong-0.10.3.el7.noarch.rpm -o /tmp/kong-0.10.3.el7.noarch.rpm
sudo yum localinstall -y /tmp/kong-0.10.3.el7.noarch.rpm
echo

echo "Step 2: Configuring Kong, opening firewalld port 8000.."
sudo cp /vagrant/kong.conf /etc/kong/kong.conf
sudo firewall-cmd --zone=public --add-port=8000/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo "Step 3: Initialising the postgresql yum repo(9.6.3).."
sudo yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm
echo

echo "Step 4: Installing Postgresql 9.6.."
sudo yum install -y postgresql96 postgresql96-lib postgresql96-server postgresql96-contrib 
sudo systemctl enable postgresql-9.6
echo

echo "Step 5: Creating the symlink for postgresql service"
sudo ln -s /usr/lib/systemd/system/postgresql-9.6.service /etc/systemd/system/multi-user.target.wants/postgresql.service
# this step is required if any system service changes are made in RHEL 7
sudo systemctl daemon-reload
echo

echo "Step 6: Creating the Postgresql cluster database.."
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
echo

echo "Step 7: Setting up Postgresql authentication.."
sudo mv /var/lib/pgsql/9.6/data/pg_hba.conf /var/lib/pgsql/9.6/data/pg_hba.conf.old
sudo cp /vagrant/pg_hba.conf /var/lib/pgsql/9.6/data/pg_hba.conf
sudo chown postgres:postgres /var/lib/pgsql/9.6/data/pg_hba.conf
echo

echo "Step 8: Starting Postgresql.."
sudo systemctl start postgresql
sudo systemctl status postgresql
echo

echo "Step 9: Creating kong user and database.."
sudo -u postgres psql -c "CREATE USER kong WITH PASSWORD 'kong'"
sudo -u postgres psql -c 'CREATE DATABASE kong OWNER kong'
echo

echo "Step 10: Starting kong.."
kong start
echo

kong health
echo
echo Done

