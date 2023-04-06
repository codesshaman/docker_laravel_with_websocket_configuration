#!/bin/bash
NAME="$(grep "LARAVEL_NAME" .env | sed -r 's/.{,13}//')"
cd laravel
git reset --hard
git pull
cd ..
# docker exec -it $NAME composer update
docker exec -it $NAME php artisan optimize
