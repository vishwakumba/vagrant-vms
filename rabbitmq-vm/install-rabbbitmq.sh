#!/bin/bash

#!/bin/bash

echo "Step 1: Setting up the rabbitmq-erlang repo.."
sudo rm -f /tmp/rabbitmq-erlang.repo
cat << EOM > /tmp/rabbitmq-erlang.repo
[rabbitmq-erlang]
name=rabbitmq-erlang
baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
gpgcheck=1
gpgkey=https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
repo_gpgcheck=0
enabled=1
EOM
sudo cp /tmp/rabbitmq-erlang.repo /etc/yum.repos.d/
echo

echo "Step 2: Installing erlang .."
sudo yum install erlang -y
echo

echo "Step 3: Installing RabbitMQ.."
sudo yum localinstall -y https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_11/rabbitmq-server-3.6.11-1.el7.noarch.rpm
sudo systemctl start rabbitmq-server
systemctl status rabbitmq-server
echo

echo Done