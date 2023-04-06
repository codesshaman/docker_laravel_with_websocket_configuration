#!/bin/bash
GIT_PATH="$(grep "GIT_PATH" .env | sed -r 's/.{,9}//')"
GIT_BRANCH="$(grep "GIT_BRANCH" .env | sed -r 's/.{,11}//')"
NAME="$(grep "LARAVEL_NAME" .env | sed -r 's/.{,13}//')"
TIMEOUT=3
# Функция проверки имени проекта в конфиге nginx
check_project_name() {
  if [ -f "nginx/conf.d/nginx.conf" ]; then
    PCONFNAME="$(grep 'fastcgi_pass' nginx/conf.d/nginx.conf | sed -r 's/.{,20}//' | sed -r 's/(.+).{6}/\1/')"
    if [ "$PCONFNAME" == "$NAME" ]; then
      echo "Текущий nginx/conf.d/nginx.conf настроен"
    else
      sed -i "s!$PCONFNAME:9000!$NAME:9000!1" nginx/conf.d/nginx.conf
      echo "Меняю имя проекта в nginx/conf.d/nginx.conf"
    fi
  else
    echo "nginx/conf.d/nginx.conf not found"  
  fi
}
# Функция билда
run() {
  check_project_name
  docker-compose up -d --build
  sleep ${TIMEOUT}
  docker exec -it ${NAME} composer update
}
# Функция клонирования сборки
clone() {
  check_env
  git clone ${GIT_PATH} -b ${GIT_BRANCH} laravel
}
# Тело скрипта
if [ ! -d "laravel/" ]; then
  clone
  echo "Запускаю конфигурацию ${FOLDER}!"
  run
else
  echo "Запускаю конфигурацию ${FOLDER}!"
  run
fi