#
# This builds the complete nginx container
#

#
# Frontend
#
FROM node:14-alpine as frontend

COPY ../../../../package.json webpack.config.js yarn.lock /app/
COPY ../../../../assets /app/assets/
COPY ./../nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /app

RUN yarn install && yarn run encore prod && ls -la /app/public/build

#
# Application
#
FROM nginx
WORKDIR /application
RUN rm -rf /var/cache/apk && mkdir /application/var && chmod 777 /application/var

COPY ../../../.. /application
COPY --from=frontend /app/public/build/ /application/public/build/

