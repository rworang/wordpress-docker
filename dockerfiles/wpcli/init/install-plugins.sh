#!/bin/bash

# Install plugin if not already installed
# if ! wp plugin is-installed ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"; then
#     echo "Installing ${PLUGIN_NAME}..."
#     wp plugin install ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"
#     echo "WooCommerce installed and set up"
# fi

# Install Debug Bar if not already installed
if ! wp plugin is-installed debug-bar --path="${WORDPRESS_PATH}"; then
  wp plugin install debug-bar --path="${WORDPRESS_PATH}"
fi

# Install Dev Debug Tools if not already installed
if ! wp plugin is-installed dev-debug-tools --path="${WORDPRESS_PATH}"; then
  wp plugin install dev-debug-tools --path="${WORDPRESS_PATH}"
fi

# Install Log Deprecated Notices if not already installed
if ! wp plugin is-installed log-deprecated-notices --path="${WORDPRESS_PATH}"; then
  wp plugin install log-deprecated-notices --path="${WORDPRESS_PATH}"
fi

# Install Query Monitor if not already installed
if ! wp plugin is-installed query-monitor --path="${WORDPRESS_PATH}"; then
  wp plugin install query-monitor --path="${WORDPRESS_PATH}"
fi

# Install Theme Check if not already installed
if ! wp plugin is-installed theme-check --path="${WORDPRESS_PATH}"; then
  wp plugin install theme-check --path="${WORDPRESS_PATH}"
fi
