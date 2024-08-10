#!/bin/bash
#
# Use this to install plugins
#
# Install plugin if not already installed
# if ! wp plugin is-installed ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"; then
#     wp plugin install ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"
# fi

# Install Plugins if not already installed
wp plugin install debug-bar dev-debug-tools log-deprecated-notices query-monitor theme-check --path="${WORDPRESS_PATH}"
