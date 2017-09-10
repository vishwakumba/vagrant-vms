#!/bin/bash

start() {
  echo "Krypton: Starting Cake Service.."
  sleep 30
}

stop() {
  echo "Krypton: Stopping Cake Service.."
}

status() {
  echo "Checking the status of the Cake Service.."
}

#########################################

if [ $# -eq 0 ]; then
  echo "Error! Missing input parameter action(start, stop, status)"
  exit -1
fi

case $1 in
  start | stop | status) "$1" 
  ;;
esac
