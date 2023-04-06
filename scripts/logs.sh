#!/bin/bash
NAME="$(grep "LARAVEL_NAME" .env | sed -r 's/.{,13}//')"
docker logs $NAME