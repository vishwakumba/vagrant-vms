#!/bin/bash

SECONDS=0
DURATION=0
PROM_VERSION="1.5.2"
WORK_DIR="$HOME/install-prometheus-temp"
INSTALL_DIR="/usr/local/prometheus"

echo "This may take a few mins.."

echo "Step 1: Initialising the directories.."

rm -rf $WORK_DIR 
sudo rm -rf $INSTALL_DIR
mkdir $WORK_DIR 
sudo mkdir $INSTALL_DIR

echo "Step 2: Downloading the bundles.."
cd $WORK_DIR

curl -sSLk https://github.com/prometheus/prometheus/releases/download/v1.5.2/prometheus-1.5.2.linux-amd64.tar.gz -O
curl -sSLk https://github.com/prometheus/alertmanager/releases/download/v0.5.1/alertmanager-0.5.1.linux-amd64.tar.gz -O
curl -sSLk https://github.com/prometheus/blackbox_exporter/releases/download/v0.4.0/blackbox_exporter-0.4.0.linux-amd64.tar.gz -O

echo "Step 3: Extracting the bundles.."
echo "Extracting prometheus-1.5.2.linux-amd64.tar.gz .."
sudo tar -zxf prometheus-1.5.2.linux-amd64.tar.gz -C $INSTALL_DIR 

echo "Extracting alertmanager-0.5.1.linux-amd64.tar.gz .."
sudo tar -zxf alertmanager-0.5.1.linux-amd64.tar.gz -C $INSTALL_DIR 

echo "Extracting blackbox_exporter-0.4.0.linux-amd64.tar.gz .."
sudo tar -zxf blackbox_exporter-0.4.0.linux-amd64.tar.gz -C $INSTALL_DIR 

echo Done
