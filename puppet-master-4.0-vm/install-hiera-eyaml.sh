#!/bin/bash

#echo sudo /opt/puppetlabs/puppet/bin/puppetserver gem install hiera-eyaml
#sudo /opt/puppetlabs/puppet/bin/puppetserver gem install hiera-eyaml

echo sudo /opt/puppetlabs/puppet/bin/gem install hiera-eyaml --no-doc --no-ri
sudo /opt/puppetlabs/puppet/bin/gem install hiera-eyaml --no-doc --no-ri

echo Done

