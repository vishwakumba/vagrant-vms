#!/bin/bash

start() {
  echo "kong-manager - starting kong.."
  /usr/local/bin/kong start 
}

stop() {
  echo "kong-manager - stopping kong.."
  /usr/local/bin/kong stop
}

status() {
  echo "kong-manager - checking status of kong.."
  /usr/local/bin/kong health 
}

######################################################################

if [ $# -eq 0 ]; then
  echo "Error! Missing input parameter action(start, stop, status)"
  exit -1
fi

case $1 in
  start | stop | status) "$1" 
  ;;
esac
