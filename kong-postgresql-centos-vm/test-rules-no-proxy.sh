#!/bin/bash

echo curl -i http://mykong.myworld.net:8000/ -H 'Host: myclient.myworld.net' --noproxy '*' -v
curl -i http://mykong.myworld.net:8000/ -H 'Host: myclient.myworld.net' --noproxy '*' -v

echo Done 
