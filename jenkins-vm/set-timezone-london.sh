#!/bin/bash

echo "Before changing TimeZone to London,  Current Date/time=$(date)"

sudo mv /etc/localtime /etc/localtime.default
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime

echo "Done. Changed TimeZone to London, Current Date/time=$(date)"
