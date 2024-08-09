#!/bin/bash

# Activate plugin if not already active
if ! wp plugin is-active ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"; then
    echo "Activating ${PLUGIN_NAME}..."
    wp plugin activate ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"
fi
