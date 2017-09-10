#!/bin/bash

LINE1="192.168.165.120      myclient.myworld.net" 
LINE2="192.168.165.121      mykong.myworld.net" 
LINE3="192.168.165.122      myserver.myworld.net" 

echo "Adding hosts to /etc/hosts.."
sudo sed -i "$ a $LINE1" /etc/hosts
sudo sed -i "$ a $LINE2" /etc/hosts
sudo sed -i "$ a $LINE3" /etc/hosts
echo

