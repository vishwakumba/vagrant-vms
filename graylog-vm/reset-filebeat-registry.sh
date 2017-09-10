#!/bin/bash

echo "Stopping filebeat.."
sudo systemctl stop filebeat

echo "Removing the filebeat registry file.."
sudo rm -f /var/lib/filebeat/registry /var/log/filebeat/*

echo "Restarting filebeat.."
sudo systemctl start filebeat
sudo systemctl status filebeat

echo Done
