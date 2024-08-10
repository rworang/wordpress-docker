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

# # Install Debug Bar if not already installed
# if ! wp plugin is-installed debug-bar --path="${WORDPRESS_PATH}"; then
#   wp plugin install debug-bar --path="${WORDPRESS_PATH}"
# fi

# # Install Dev Debug Tools if not already installed
# if ! wp plugin is-installed dev-debug-tools --path="${WORDPRESS_PATH}"; then
#   wp plugin install dev-debug-tools --path="${WORDPRESS_PATH}"
# fi

# # Install Log Deprecated Notices if not already installed
# if ! wp plugin is-installed log-deprecated-notices --path="${WORDPRESS_PATH}"; then
#   wp plugin install log-deprecated-notices --path="${WORDPRESS_PATH}"
# fi

# # Install Query Monitor if not already installed
# if ! wp plugin is-installed query-monitor --path="${WORDPRESS_PATH}"; then
#   wp plugin install query-monitor --path="${WORDPRESS_PATH}"
# fi

# # Install Theme Check if not already installed
# if ! wp plugin is-installed theme-check --path="${WORDPRESS_PATH}"; then
#   wp plugin install theme-check --path="${WORDPRESS_PATH}"
# fi
