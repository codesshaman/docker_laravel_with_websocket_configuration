FROM alpine:3.17

ARG PHP_VERSION=81

ENV PATH="${PATH}:/usr/local/bin/"

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-ftp \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    wget

# RUN set -x

COPY composer.phar /usr/local/bin/composer

COPY laravel /var/www

WORKDIR /var/www

CMD ["php", "artisan", "websockets:serve"]
