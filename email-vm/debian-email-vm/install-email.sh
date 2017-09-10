#!/bin/bash

SECONDS=0
DURATION=0
CONFIG_FILE="/etc/ssmtp/ssmtp.conf"

echo "Step 1: Installing ssmtp .."
sudo apt-get install -y ssmtp 
echo

echo "Step 2: Configuring /etc/ssmtp/ssmtp.conf .."
sudo cp /etc/ssmtp/ssmtp.conf /tmp/ssmtp.conf
sudo chmod 666 /tmp/ssmtp.conf
echo "**************************************************************" >> /tmp/ssmtp.conf
echo "mailhub=smtp.gmail.com:587" >> /tmp/ssmtp.conf
echo "AuthUser=dwp.chaps.monitoring@gmail.com" >> /tmp/ssmtp.conf
echo "AuthPass=S3cr3t00" >> /tmp/ssmtp.conf
echo "FromLineOverride=YES" >> /tmp/ssmtp.conf
echo "UseSTARTTLS=YES" >> /tmp/ssmtp.conf

sudo cp /tmp/ssmtp.conf /etc/ssmtp/ssmtp.conf 
sudo chmod 644 /etc/ssmtp/ssmtp.conf
echo

echo Done
