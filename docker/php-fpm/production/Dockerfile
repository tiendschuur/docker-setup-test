#
# This builds the complete php-fpm container
#

FROM composer:2 as vendor
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
FROM php:8-fpm-alpine
WORKDIR /application
RUN rm -rf /var/cache/apk && mkdir /application/var && chmod 777 /application/var

COPY . /application
COPY --from=vendor /app/vendor/ /application/vendor/
