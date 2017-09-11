#!/bin/bash

HIERA_CONFIG_DIR=/etc/puppetlabs/code/

sudo rm -f /tmp/hiera.yaml

cat <<EOT > /tmp/hiera.yaml
---
:backends:
    - eyaml
    - yaml  

:yaml:
  :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"

:eyaml:
  :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"
  :pkcs7_private_key: /etc/puppetlabs/code/eyaml-keys/il3/private_key.pkcs7.pem
  :pkcs7_public_key: /etc/puppetlabs/code/eyaml-keys/il3/public_key.pkcs7.pem
  :cache_decrypted: false
  :extension: 'yaml'

:hierarchy:
  - "environments/roles/%{::role}"
  - "common"
EOT

sudo cp /tmp/hiera.yaml $HIERA_CONFIG_DIR

