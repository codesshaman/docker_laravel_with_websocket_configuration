#!/bin/bash
NAME="$(grep "NGINX_NAME" .env | sed -r 's/.{,11}//')"
docker logs $NAME