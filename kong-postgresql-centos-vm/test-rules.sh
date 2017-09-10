#!/bin/bash

echo curl -i http://mykong.myworld.net:8000/employee/100 -H 'Host: myclient.myworld.net' -v
curl -i http://mykong.myworld.net:8000/employee/100 -H 'Host: myclient.myworld.net' -v

echo Done 
