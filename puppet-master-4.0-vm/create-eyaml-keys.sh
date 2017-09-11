#!/bin/bash

IL2_TARGET_DIR="/etc/puppetlabs/code/eyaml-keys/il2"
IL3_TARGET_DIR="/etc/puppetlabs/code/eyaml-keys/il3"

function createkeys() {
  DIR=$1
  sudo rm -rf $DIR
  sudo mkdir -p $DIR
  cd $DIR
  sudo /opt/puppetlabs/puppet/bin/eyaml createkeys
  sudo mv ./keys/* $DIR/ 
  sudo rmdir keys
  echo "Created keys in the directory=$IL2_TARGET_DIR"
  sudo ls -l $TARGET_DIR 
  echo
  cd
}

####################################################################
# Main

echo "Creating eyaml keys for IL2.."
createkeys $IL2_TARGET_DIR

echo "Creating eyaml keys for IL3.."
createkeys $IL3_TARGET_DIR

