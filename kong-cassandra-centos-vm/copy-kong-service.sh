#!/bin/bash

sudo cp /vagrant/kong-manager.sh /usr/local/kong/
sudo cp /vagrant/kong.service /usr/lib/systemd/system/
sudo systemctl daemon-reload

echo Done
