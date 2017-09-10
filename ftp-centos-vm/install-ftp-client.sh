#!/bin/bash

echo "Step 1: Installing ftp to test FTP connections.."
sudo yum install ftp -y
echo

echo "Step 2: Installing lftp to test FTPS connections.."
sudo yum install lftp -y
echo

echo Done


