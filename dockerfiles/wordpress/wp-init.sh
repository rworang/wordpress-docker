#!/bin/sh

# Check if the plugins directory exists and is not empty before building
if [ "$(ls -A plugins)" ]; then
    cp -r plugins /var/www/html/wp-content/plugins
fi

# Check if the themes directory exists and is not empty before building
if [ "$(ls -A themes)" ]; then
    cp -r themes /var/www/html/wp-content/themes
fi