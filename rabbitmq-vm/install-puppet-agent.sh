#!/bin/bash

SECONDS=0
DURATION=0

echo "This may take a few mins.."
echo
echo "Step 1: Intalling puppet agent.."
sudo yum install -y -e 0 -d 1 puppet
sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
sudo ln -s /opt/puppetlabs/bin/hiera /usr/bin/hiera
sudo ln -s /opt/puppetlabs/bin/facter /usr/bin/facter

echo "Installed puppet version=$(puppet --version)"
echo "Installed hiera version=$(hiera --version)"
echo "Installed facter version=$(facter --version)"
echo

echo "Step 2: Intalling r10k.."
sudo /opt/puppetlabs/puppet/bin/gem install r10k
sudo ln -s /opt/puppetlabs/puppet/bin/r10k /usr/bin/r10k 
echo

echo "Step 3: Intalling git.."
sudo yum install git -y
echo

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"
