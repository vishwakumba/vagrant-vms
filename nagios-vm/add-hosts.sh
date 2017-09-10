#!/bin/bash

LINE1="192.168.240.10      nagios.myworld.net"
LINE2="192.168.240.11      web.myworld.net"
LINE3="192.168.240.12      services.myworld.net"
LINE4="192.168.240.13      database.myworld.net"

echo "Adding hosts to /etc/hosts.."
sudo sed -i "$ a $LINE1" /etc/hosts
sudo sed -i "$ a $LINE2" /etc/hosts
sudo sed -i "$ a $LINE3" /etc/hosts
sudo sed -i "$ a $LINE4" /etc/hosts
echo

