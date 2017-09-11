#!/bin/bash

ARTIFACTORY_URL="http://artifactory.itsshared.net:8081"

echo "Step 1: Listing the current sources of ruby gems.."
gem source --list
echo

echo "Step 2: Removing the default ruby gems source=https://rubygems.org/"
gem source --remove "https://rubygems.org/"
echo

echo "Step 3: Adding the new source 'gysp-gems' from artifactory server.."
gem source --add $ARTIFACTORY_URL/artifactory/api/gems/gysp-gems/
echo

echo "Step 4: Listing the current sources of ruby gems.."
gem source --list
echo

echo Done

