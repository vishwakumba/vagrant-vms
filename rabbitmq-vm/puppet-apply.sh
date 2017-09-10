#!/bin/bash

SECONDS=0
DURATION=0

RED='\033[0;31m' 
GREEN='\033[0;92m' 
NC='\033[0m'

function red() {
  msg=$1
  printf "${RED}${msg}${NC}\n" 
}

function green() {
  msg=$1
  printf "${GREEN}${msg}${NC}\n" 
}

##############################################################################################
# Main

#environment=$1
environment="local"
if [ -z "${environment}" ]; then
  echo "Error: environment input parameter is missing!"
  exit -1
fi

env_path=/etc/puppetlabs/code/environments/${environment}
hiera_config=/etc/puppetlabs/code/hiera.yaml
modulepath="${env_path}/site:${env_path}/modules"

#echo "Step 1: Running R10k to fetch the dependent modules.."
#sudo rm -rf $env_path/modules/*
#sudo /opt/puppetlabs/puppet/bin/r10k puppetfile install --puppetfile "${env_path}/Puppetfile" --moduledir "${env_path}/modules" --verbose
#echo

echo "Step 2: Running Puppet in a standalone mode.."
sudo puppet apply --verbose --detailed-exitcodes --environment="${environment}" \
  --hiera_config="${hiera_config}" --modulepath="${modulepath}"  "${env_path}/manifests/site.pp" --debug
result=$?
echo

if [ $result -eq 0 -o  $result -eq 2 ]; then
  green "PUPPET RUN SUCCESSFUL.."
else 
  
  red "ERROR: PUPPET RUN FAILED.."
fi

DURATION=$SECONDS
echo "Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"
