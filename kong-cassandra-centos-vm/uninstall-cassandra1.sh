#!/bin/bash

echo "Step 1: Stopping cassandra.."
sudo systemctl disable cassandra
sudo systemctl daemon-reload
#sudo systemctl stop cassandra
process_id=$(pgrep -f cassandra)
echo "process_id=$process_id"
if [ ! -z "$process_id" ]; then
  echo "cassandra process(pid=$process_id) is running, killing it.."
  kill -9 $process_id
fi
echo

echo Done

