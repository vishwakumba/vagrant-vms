#!/bin/bash

SECONDS=0
DURATION=0
DIR=$(dirname $0)
SCRIPT=$(basename $0)
NOW=$(date +%Y%m%d-%H%M%S)

echo "Installing and Configuring Filebeat 5.5.2 This may take a few mins.."
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

echo "Step 2: Installing FileBeat.."
sudo yum install -y filebeat
sudo systemctl enable filebeat
sleep 5
echo

echo "Step 3: Configuring FileBeat.."
sudo chmod 755 /var/log/filebeat
sudo chmod 644 /var/log/filebeat/*
if [ ! -r /etc/filebeat/filebeat.yml.original ]; then 
  sudo cp /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.original
fi
sudo cp filebeat.yml.template /etc/filebeat/filebeat.yml

sudo sed -i "s/<<GRAYLOG_HOST_NAME>>/$GRAYLOG_HOST_NAME/" /etc/filebeat/filebeat.yml
sudo sed -i "s/<<GRAYLOG_INPUT_PORT>>/$GRAYLOG_INPUT_PORT/" /etc/filebeat/filebeat.yml
echo

echo "Step 4: Copying sample-log files for testing purposes.."
sudo cp -r sample-logs/* /var/log/
echo 

echo "Step 5: Restart filebeat.."
sudo systemctl restart filebeat
sudo systemctl status filebeat
echo

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"
