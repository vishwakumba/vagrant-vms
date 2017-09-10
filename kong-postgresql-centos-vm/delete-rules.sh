#!/bin/bash

echo curl -i -X DELETE --url http://localhost:8001/apis/hello-api
curl -i -X DELETE --url http://localhost:8001/apis/hello-api

echo Done
