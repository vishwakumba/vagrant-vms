#!/bin/bash

KEYS_DIR="/etc/puppetlabs/code/eyaml-keys/il2"
echo /opt/puppetlabs/puppet/bin/eyaml $1 --pkcs7-private-key="${KEYS_DIR}/private_key.pkcs7.pem" --pkcs7-public-key="${KEYS_DIR}/public_key.pkcs7.pem" $2 $3 
/opt/puppetlabs/puppet/bin/eyaml $1 --pkcs7-private-key="${KEYS_DIR}/private_key.pkcs7.pem" --pkcs7-public-key="${KEYS_DIR}/public_key.pkcs7.pem" $2 $3 
