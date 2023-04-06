#!/bin/bash
NAME="$(grep "WS_NAME" .env | sed -r 's/.{,8}//')"
docker exec -it --user root $NAME sh