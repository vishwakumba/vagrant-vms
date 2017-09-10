#!/bin/bash

echo "Step 2: Uninstalling cassandra..."
sudo yum remove -y cassandra 
sudo rm -rf /etc/cassandra
sudo rm -rf /usr/share/cassandra/
sudo rm -rf /var/lib/cassandra
sudo rm -rf /var/log/cassandra
sudo rm -rf /opt/apache-cassandra-3.10 
echo
echo Done

