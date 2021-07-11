#
# This builds the complete nginx container
#

#
# Frontend
#
FROM node:14-alpine as frontend
WORKDIR /application

COPY ../../../../package.json webpack.config.js yarn.lock /application/
COPY ../../../../assets /app/assets/

RUN yarn install && yarn run encore prod && ls -la /application/public/build

#
# Application
#
FROM nginx
WORKDIR /application
RUN rm -rf /var/cache/apk && mkdir /application/var && chmod 777 /application/var

COPY ../../../.. /application
COPY --from=frontend /application/docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=frontend /application/public/build/ /application/public/build/

