#!/bin/bash

echo "Step 1: Downloading latest nagios-xi installation bundle.."
rm -rf $HOME/work
mkdir $HOME/work
cd $HOME/work
curl -Lk http://assets.nagios.com/downloads/nagiosxi/xi-latest.tar.gz -O
echo

echo "Step 2: Extracting the bundle.."
tar -zxvf xi-latest.tar.gz
cd nagiosxi
echo

echo "Step 3: Installing the NagiosXI bundle.."
sudo ./fullinstall
echo

echo Done
