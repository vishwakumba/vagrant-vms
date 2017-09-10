#!/bin/bash

sudo mkdir -p /usr/local/super

sudo cp /vagrant/cake-manager.sh /usr/local/super
sudo cp /vagrant/donut-manager.sh /usr/local/super
sudo cp /vagrant/bakery-manager.sh /usr/local/super

sudo chmod -R 755 /usr/local/super
sudo chown root:root /usr/local/super

sudo cp /vagrant/cake.service   /usr/lib/systemd/system/
sudo cp /vagrant/donut.service  /usr/lib/systemd/system/
sudo cp /vagrant/bakery.service /usr/lib/systemd/system/

sudo systemctl enable cake
sudo systemctl enable donut
sudo systemctl enable bakery

sudo systemctl daemon-reload

#sudo systemctl start cake
#sudo systemctl start donut
sudo systemctl start bakery


echo Done
