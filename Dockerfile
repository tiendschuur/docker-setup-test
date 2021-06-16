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
    --no-scripts \
    --prefer-dist

#
# Frontend
#
FROM node:14-alpine as frontend

COPY package.json webpack.config.js yarn.lock /app/
COPY assets/ /app/assets/

WORKDIR /app

RUN yarn install && yarn run encore prod

#
# Application
#
FROM trafex/php-nginx
WORKDIR /application
RUN rm -rf /var/cache/apk
COPY bin config public src templates translations /application/
COPY --chown=nginx --from=vendor /app/vendor/ /application/vendor/
COPY --chown=nginx --from=frontend /app/public/build/ /application/public/build/
