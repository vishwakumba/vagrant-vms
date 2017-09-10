#!/bin/bash

SECONDS=0
DURATION=0
JAVA_VERSION="1.8.0"

echo "This may take a few mins.."

echo
echo "Intalling Java-${JAVA_VERSION}"
sudo yum install -y java-${JAVA_VERSION}-openjdk-devel 

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"


