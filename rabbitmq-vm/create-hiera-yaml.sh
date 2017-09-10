#!/bin/bash

HIERA_CONFIG_DIR=/etc/puppetlabs/code/

sudo rm -f /tmp/hiera.yaml

cat <<EOT > /tmp/hiera.yaml
---

:backends:
  - yaml

:yaml:
  :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"

:hierarchy:
  - "environments/%{::environment}/%{::fqdn}"
  - "environments/%{::environment}"
  - "common"
EOT

sudo cp /tmp/hiera.yaml $HIERA_CONFIG_DIR

