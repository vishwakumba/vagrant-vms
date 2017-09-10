#!/bin/bash

rm -rf /tmp/good-*

export LD_PRELOAD="/usr/local/lib/libfaketime.so.1"
export FAKETIME="+15d"

echo "LD_PRELOAD=$LD_PRELOAD"
echo "FAKETIME=$FAKETIME"

java Hello

ls -ld /tmp/good*

stat /tmp/good*

