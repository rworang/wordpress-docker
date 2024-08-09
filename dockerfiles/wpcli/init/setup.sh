#!/bin/bash

# Wait for the database to be ready
echo "Checking database connection..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    printf "."
    sleep 2
done
echo "Database is ready"

# WordPress setup
source /usr/local/bin/init/wordpress-setup.sh

# WooCommerce setup
source /usr/local/bin/init/woocommerce-setup.sh

# Generate random products
source /usr/local/bin/init/generate-products.sh

# Enable local plugins
source /usr/local/bin/init/activate-plugins.sh

# Keep the container running
tail -f /dev/null
