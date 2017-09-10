#!/bin/bash

for i in {1..5}; do 
  NOW=$(date +%Y%m%d-%H%M%S)
  echo "${NOW} - Starting netcat(nc) at port 8099.."
  { echo -ne "HTTP/1.1 200 OK\r\n\r\n"; cat response.txt; } | nc -l -p 8099
done
