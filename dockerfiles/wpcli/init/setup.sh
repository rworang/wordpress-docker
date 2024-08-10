#!/bin/bash

# Wait for the database to be ready
echo "Checking database connection..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    printf "."
    sleep 2
done
echo "Database is ready"

# WordPress setup
if [ ! -f /tmp/wordpress-setup-completed ]; then
    source /tmp/init/wordpress-setup.sh
    touch /tmp/wordpress-setup-completed && echo "WordPress setup completed"
fi

# WooCommerce setup
if [ ! -f /tmp/woocommerce-setup-completed ]; then
    source /tmp/init/woocommerce-setup.sh
    touch /tmp/woocommerce-setup-completed && echo "WooCommerce setup completed"
fi

# Generate random products
if [ ! -f /tmp/products-generated ]; then
    source /tmp/init/generate-products.sh
    touch /tmp/products-generated && echo "Products generated"
fi

# Install plugins
source /tmp/init/install-plugins.sh

# Enable local plugins
# su -s /bin/sh -c 'source /tmp/init/activate-plugins.sh' www-data

cp /tmp/init/wp-config.php ${WORDPRESS_PATH}/wp-config.php
echo 'copied wp-config.php'

# Keep the container running
tail -f /dev/null
