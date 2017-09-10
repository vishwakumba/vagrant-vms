#!/bin/bash

SECONDS=0

echo "Uninstalling RabbitMQ, Erlang.."
echo

echo "Step 1: Removing port-access.." 
sudo firewall-cmd --zone=public --remove-port=5672/tcp --permanent
sudo firewall-cmd --zone=public --remove-port=15672/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
echo

echo "Step 2: Uninstalling RabbitMQ Server.."
sudo systemctl stop rabbitmq-server
sudo systemctl disable rabbitmq-server
sudo yum remove -y rabbitmq-server
sudo rm -rf  /var/log/rabbitmq
echo

echo "Step 3: Uninstalling Erlang.."
sudo yum remove -y erlang
echo

echo "Step 4: Removing gysp-yum.repo.."
sudo rm -f /etc/yum.repos.d/gysp-yum.repo
sudo yum clean all
echo

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"
