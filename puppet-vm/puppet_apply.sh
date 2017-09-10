#!/bin/bash

# Use r10k to install modules from Puppetfile
# Call puppet apply on site.pp

environment=$1

env_path=/etc/puppetlabs/code/environments/${environment}
hiera_config=/etc/puppetlabs/code/hiera.yaml
modulepath="${env_path}/site:${env_path}/modules"

# R10K does not seem to download the updated modules sometimes, so the workaround is to delete the local modules 
# and force a download by R10K. This may be slower as R10K does a full clone of every module each time!
rm -rf $env_path/modules/*

# Install Puppetfile modules
/opt/puppetlabs/puppet/bin/r10k puppetfile install --puppetfile "${env_path}/Puppetfile" --moduledir "${env_path}/modules"

# Run puppet apply
cd "${env_path}/"        
puppet apply --verbose --detailed-exitcodes --environment="${environment}" --hiera_config="${hiera_config}" --modulepath="${modulepath}"  "${env_path}/manifests/site.pp"
result=$?

case ${result} in
(0) echo "Exit code: ${result}. Nothing was deployed but no failure indicated."
  ;;
(1) echo "Exit code: ${result}. Puppet apply issue detected."
  ;;
(2) echo "Exit code: ${result}. Puppet apply successful."
  ;;
(4) echo "Exit code: ${result}. Puppet apply may have failed."
  ;;
(6) echo "Exit code: ${result}. Puppet apply may have failed."
  ;;
(*) echo "Unexpected Exit code: ${result}."
  ;;
esac

