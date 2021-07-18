#
# This builds the complete nginx container
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
FROM nginx as prod
WORKDIR /application
RUN rm -rf /var/cache/apk && mkdir /application/var && chmod 777 /application/var

COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./public/ /application/public/
COPY --from=frontend /app/public/build/ /application/public/build/

