#!/bin/bash

echo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout my-private.key -out my-public-self-signed.crt
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout my-private.key -out my-public-self-signed.crt

echo Done

