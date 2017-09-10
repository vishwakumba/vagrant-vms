#!/bin/bash

echo "Step 1: Stopping Graylog Server.."
sudo systemctl stop graylog-server
sudo rm -f /var/log/graylog-server/server.log
echo

echo "Step 2 : Deleting graylog_0 index in ElastiSearch.."
curl -XDELETE http://localhost:9200/graylog_0
echo
echo 

echo "Step 3 : Deleting graylog_deflector index in ElastiSearch.."
curl -XDELETE localhost:9200/graylog_deflector
echo
echo

echo "Step 4: Starting Graylog Server.."
sudo systemctl start graylog-server
sudo systemctl status graylog-server
echo
echo Done
