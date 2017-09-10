#!/bin/bash

LINE1="192.168.7.175      mygraylog.myworld.net" 
LINE2="192.168.7.176      myfilebeat.myworld.net" 
LINE3="192.168.150.150    mycentos.myworld.net"

echo "Adding hosts to /etc/hosts.."
sudo sed -i "$ a $LINE1" /etc/hosts
sudo sed -i "$ a $LINE2" /etc/hosts
sudo sed -i "$ a $LINE3" /etc/hosts
echo
