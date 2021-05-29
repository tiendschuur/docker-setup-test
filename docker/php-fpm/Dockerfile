FROM composer:2 AS composer

FROM php:8.0-fpm
WORKDIR "/application"

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
		libzip-dev \
		libicu-dev \
		git \
		unzip \
	&& docker-php-ext-install -j$(nproc) iconv \
	&& docker-php-ext-configure gd --with-jpeg --with-freetype\
&& docker-php-ext-install -j$(nproc) gd exif pdo pdo_mysql zip intl

COPY --from=composer /usr/bin/composer /usr/bin/composer