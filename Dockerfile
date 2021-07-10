#
# This builds the complete php-fpm container
#

FROM composer:2 as vendor
WORKDIR /app

COPY composer.json composer.json
COPY composer.lock composer.lock

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-dev \
    --no-scripts \
    --prefer-dist

#
# Frontend
#
FROM node:14-alpine as frontend

COPY package.json webpack.config.js yarn.lock /app/
COPY assets/ /app/assets/

WORKDIR /app

RUN yarn install && yarn run encore prod && ls -la /app/public/build

#
# Application
#
FROM php:8-fpm-alpine
WORKDIR /application
RUN rm -rf /var/cache/apk

COPY . /var/www/html
COPY --from=vendor /app/vendor/ /var/www/html/vendor/
COPY --from=frontend /app/public/build/ /var/www/html/public/build/


#EXPOSE 80

#CMD /usr/sbin/php-fpm -R --nodaemonize
