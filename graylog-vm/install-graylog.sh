#!/bin/bash

SECONDS=0
DURATION=0
DIR=$(dirname $0)
SCRIPT=$(basename $0)
NOW=$(date +%Y%m%d-%H%M%S)
modulename="mongod"

echo "Installing and Configurating Graylog-Server 2.3.0. This may take a few mins.."
echo
if [ $# -ne 1 ]; then
  echo "Error: $SCRIPT should be invoked with one parameter."
  echo "   For example: $SCRIPT vagrant-graylog.config.sh" 
  echo "   For example: $SCRIPT dev-graylog.config.sh" 
  echo "   For example: $SCRIPT prod-graylog.config.sh" 
  exit 1
fi

config_file=$1
if [ ! -r $config_file ]; then
  echo "Error: unable to read config_file=$config_file. Does it exist and have read permissions?"
  exit 1
fi

source $config_file

echo "Step 1: Configuring gysp-test-local.repo.."
sudo rm -f /tmp/gysp-test-local.repo
cat <<SECTION > /tmp/gysp-test-local.repo
[gysp-test-local-artifactory]
name=gysp-test-local repo in Artifactory
baseurl=http://artifactory.itsshared.net:8081/artifactory/gysp-test-local/
gpgcheck=0
SECTION

sudo cp /tmp/gysp-test-local.repo /etc/yum.repos.d/
sudo yum clean all
echo

echo "Step 2: Installing OpenJDK 1.8.0..."
sudo yum install -y java-1.8.0-openjdk-devel
echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> $HOME/.bashrc
echo

echo "Step 3: Installing and configuring ElasticSearch.."
sudo yum install -y elasticsearch

#creating the data directory for elasticsearch (Note: need to resove the selinux issue for this)
sudo mkdir -m 755 -p /data/elasticsearch
sudo chown elasticsearch:elasticsearch /data/elasticsearch

sudo systemctl enable elasticsearch
sudo systemctl restart elasticsearch

if sudo bash -c "[ ! -r /etc/elasticsearch/elasticsearch.yml.original ]"; then 
  sudo cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.original
fi
sudo cp /etc/elasticsearch/elasticsearch.yml.original /etc/elasticsearch/elasticsearch.yml
sudo bash -c 'echo "cluster.name: graylog" >> /etc/elasticsearch/elasticsearch.yml'
sudo bash -c 'echo "path.data: /data/elasticsearch" >> /etc/elasticsearch/elasticsearch.yml'
echo

echo "Step 4: Installing MongoDB.."
sudo yum install -y mongodb-org

#creating the data directory for mongodb (Note: need to resove the selinux issue for this)
sudo mkdir -m 755 -p /data/mongodb
sudo chown mongod:mongod /data/mongodb

sudo sed -i 's|/var/lib/mongo|/data/mongodb|' /etc/mongod.conf

sudo yum install policycoreutils-python -y 

sudo cp /vagrant/selinux/${modulename}.te /tmp/${modulename}.te
sudo checkmodule -M -m -o /tmp/${modulename}.mod /tmp/${modulename}.te
sudo semodule_package -o /tmp/${modulename}.pp -m /tmp/${modulename}.mod
sudo semodule -i /tmp/${modulename}.pp

sudo systemctl enable mongod
sudo systemctl start mongod
echo

echo "Step 5: Installing Graylog Server(Rest and Web)"
sudo yum install -y graylog-server
sudo mkdir -p /data/graylog-server/journal
sudo chmod -R 755 /data/graylog-server
sudo chown -R graylog:graylog /data/graylog-server
sudo systemctl enable graylog-server
echo

echo "Step 6: Configuring Graylog Server.."
if sudo bash -c "[ ! -r /etc/graylog/server/server.conf.original ]"; then 
  sudo cp /etc/graylog/server/server.conf /etc/graylog/server/server.conf.original
fi
sudo cp /etc/graylog/server/server.conf.original /etc/graylog/server/server.conf

sudo bash -c "cat <<EOM >> /etc/graylog/server/server.conf

#######################################################################################
#Added by Vishwa Kumba, 22.08.17
password_secret = hellohellohellohellohello
root_username = $ROOT_USERNAME
root_password_sha2 = $ROOT_PASSWORD_SHA2
web_listen_uri = http://$GRAYLOG_HOST_NAME:9000/
rest_listen_uri = http://$GRAYLOG_HOST_NAME:9000/api/
message_journal_dir = /data/graylog-server/journal

transport_email_enabled = true
transport_email_protocol = smtp
transport_email_hostname = $SMTP_SERVER
transport_email_port = $SMTP_PORT 
transport_email_use_auth = true
transport_email_use_tls = true
transport_email_use_ssl = false
transport_email_auth_username = $SMTP_AUTH_USER
transport_email_auth_password = $SMTP_AUTH_PWD 
transport_email_subject_prefix = Graylog Alert Email
transport_email_from_email = $SMTP_AUTH_USER
transport_email_from_name = gysp-graylog-monitoring

EOM"
echo

echo "Step 7: Configuring /etc/hosts.."
if sudo bash -c "[ ! -r /etc/hosts.original ]"; then     
  sudo cp /etc/hosts /etc/hosts.original
fi
sudo cp /etc/hosts.original /etc/hosts
sudo sed -i "/$GRAYLOG_HOST_NAME/d" /etc/hosts
sudo sed -i "$ a $GRAYLOG_HOST_IP     $GRAYLOG_HOST_NAME" /etc/hosts
echo

echo "Step 5: Opening Graylog web port 9000.."
sudo firewall-cmd --zone=public --add-port=9000/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5044/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5045/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo "Step 6: Starting Graylog Server.."
sudo systemctl restart graylog-server
echo

echo "Step 7: Displaying the current status of mongodb, elasticseaerch and graylog-server.."
sudo systemctl status mongod elasticsearch graylog-server

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"

