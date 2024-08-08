#!/bin/bash

if ! wp plugin is-active allergens-dietary-ictoria --path="${WORDPRESS_PATH}"; then
        echo "Activating Allergens and Dietary plugin..."
        wp plugin activate allergens-dietary-ictoria --path="${WORDPRESS_PATH}"
    if wp plugin is-active allergens-dietary-ictoria --path="${WORDPRESS_PATH}"; then
            echo "Allergens and Dietary plugin activated"
    else
            echo "Unable to activate Allergens and Dietry plugin"
    fi
fi