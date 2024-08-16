#!/bin/bash

# Navigate to the WordPress root directory
cd ${WORDPRESS_PATH}

# Check Node.js version
node -v

# Install WooCommerce development build via WP-CLI
wp plugin install https://github.com/woocommerce/woocommerce/archive/refs/heads/trunk.zip --force --activate

# Install and build WooCommerce development environment
cd wp-content/plugins/woocommerce
npm install
npm run build

# Ensure WooCommerce is active
wp plugin activate woocommerce
