#
# This builds the complete container setup
#

#
# Frontend
#
FROM node:14-alpine as frontend
WORKDIR /app

COPY ./package.json package.json
COPY ./webpack.config.js webpack.config.js
COPY ./yarn.lock yarn.lock
COPY ./assets/ assets

RUN yarn install && yarn run encore prod

#
# Application
#
FROM nginx as nginx
WORKDIR /application
RUN rm -rf /var/cache/apk && mkdir /application/var && chmod 777 /application/var

COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./public/ /application/public/
COPY --from=frontend /app/public/build/ /application/public/build/

FROM composer:2 as composer
WORKDIR /app

COPY ./composer.json composer.json
COPY ./composer.lock composer.lock

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-dev \
    --no-scripts \
    --prefer-dist

#
# Application
#
FROM php:8-fpm-alpine as php-fpm
WORKDIR /application
RUN rm -rf /var/cache/apk && mkdir /application/var && chmod 777 /application/var

COPY docker/production /application
COPY --from=composer /app/vendor/ /application/vendor/
COPY --from=frontend /app/public/build/ /application/public/build/
