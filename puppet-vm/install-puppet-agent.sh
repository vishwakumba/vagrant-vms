#!/bin/bash

SECONDS=0
DURATION=0

echo "This may take a few mins.."
echo "Step 1: Configuring the artifactory repo for puppet rpms.."

cat << EOM > /tmp/my-puppet.repo
[Artifactory]
name=Artifactory
#baseurl=http://artifactory.itsshared.net:8081/artifactory/pe-puppet-4.4.2
baseurl=http://artifactory.itsshared.net:8081/artifactory/pe-puppet-4.7.0-local
enabled=1
gpgcheck=0
EOM

sudo cp /tmp/my-puppet.repo /etc/yum.repos.d/

echo
echo "Step 2: Intalling puppet agent.."
sudo yum install -y -e 0 -d 1 puppet
sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
sudo ln -s /opt/puppetlabs/bin/hiera /usr/bin/hiera
sudo ln -s /opt/puppetlabs/bin/facter /usr/bin/facter

echo "Installed puppet version=$(puppet --version)"
echo "Installed hiera version=$(hiera --version)"
echo "Installed facter version=$(facter --version)"
echo

echo "Step 3: Intalling r10k.."
sudo /opt/puppetlabs/puppet/bin/gem install r10k
sudo ln -s /opt/puppetlabs/puppet/bin/r10k /usr/bin/r10k 
echo

echo "Step 4: Intalling git.."
sudo yum install git -y
echo

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"
