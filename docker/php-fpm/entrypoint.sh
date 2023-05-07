#!/bin/bash

composer install --no-scripts

printf "\u001b[41;1m >>>> Project has been started \u001b[0m\n";

php-fpm
