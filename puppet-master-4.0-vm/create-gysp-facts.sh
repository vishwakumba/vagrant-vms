#!/bin/bash

echo "
---
zone : il3
role : il3_database

" > /tmp/gysp-facts.yaml

sudo cp /tmp/gysp-facts.yaml /opt/puppetlabs/facter/facts.d/

cat /opt/puppetlabs/facter/facts.d/gysp-facts.yaml

echo Done
