#!/bin/bash

SECONDS=0
DURATION=0
NODEJS_VERSION="4.4.2"

echo "This may take a few mins.."

echo
echo "Intalling nodejs-${NODEJS_VERSION}"
curl --silent --location https://rpm.nodesource.com/setup_4.x | sudo bash -

sudo yum install -y -e 0 -d 1 nodejs-${NODEJS_VERSION}

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"


