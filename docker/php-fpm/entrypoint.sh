#!/bin/bash

composer install

bin/console assets:install

printf "\u001b[41;1m >>>> Project has been started \u001b[0m\n";

php-fpm