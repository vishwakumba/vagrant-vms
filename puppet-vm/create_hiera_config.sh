#!/bin/bash

# Overwrite hiera.yaml from default

hiera_config=/etc/puppetlabs/code/hiera.yaml

cat <<EOT > "${hiera_config}"
---
:backends:
  - yaml
:yaml:
  :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"
:hierarchy:
  - "clientcerts/%{::fqdn}"
  - "environments/%{::environment}"
  - "common"
EOT
