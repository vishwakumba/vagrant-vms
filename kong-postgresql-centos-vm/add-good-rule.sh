#!/bin/bash

#curl -i -X POST --url http://localhost:8001/apis/ \
#	    --data 'name=hello-api' --data 'hosts=myclient.myworld.net' --data 'upstream_url=http://myserver.myworld.net:8099'

curl -i -X POST --url http://localhost:8001/apis/ \
	    --data 'name=hello-api' --data 'hosts=myclient.myworld.net' --data 'upstream_url=http://artifactory.itsshared.net:8081'

echo Done
