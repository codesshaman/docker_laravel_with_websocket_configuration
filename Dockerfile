FROM php:8.1.5-fpm-alpine

WORKDIR /var/www

ENV PATH="${PATH}:/usr/local/bin/"

RUN apk update add wget curl zip unzip nano mc && \
    set -ex && apk --no-cache add postgresql-dev && \ 
    docker-php-ext-install pdo pdo_pgsql && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apk*

# RUN set -x

COPY laravel /var/www/

COPY composer.phar /usr/local/bin/composer

COPY ./php/php.ini /usr/local/etc/php/conf.d/php.ini

CMD ["php-fpm","-F"]