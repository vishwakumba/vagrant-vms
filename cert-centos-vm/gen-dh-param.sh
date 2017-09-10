#!/bin/bash

SECONDS=0
DURATION=0

echo "Generating a Diffie-Hellman group.."
echo openssl dhparam -out my-dhparam.pem 2048
openssl dhparam -out my-dhparam.pem 2048

DURATION=$SECONDS
echo "Done. Time taken=$(($DURATION / 60)) minutes and $(($DURATION % 60)) secs"


