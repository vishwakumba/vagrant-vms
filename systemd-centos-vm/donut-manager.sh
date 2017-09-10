#!/bin/bash

start() {
  echo "Krypton: Starting Donut Service.."
  sleep 30
}

stop() {
  echo "Krypton: Stopping Donut Service.."
}

status() {
  echo "Checking the status of the Donut Service.."
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
