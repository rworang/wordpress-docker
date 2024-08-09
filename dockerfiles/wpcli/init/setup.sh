#!/bin/bash

# Wait for the database to be ready
echo "Checking database connection..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    printf "."
    sleep 2
done
echo "Database is ready"

# WordPress setup
if [ ! -f /usr/local/bin/wordpress-setup-completed ]; then
    su -s /bin/sh -c 'source /usr/local/bin/init/wordpress-setup.sh' www-data
    touch /tmp/wordpress-setup-completed
fi

# WooCommerce setup
# if [ ! -f /usr/local/bin/woocommerce-setup-completed ]; then
#     su -s /bin/sh -c 'source /usr/local/bin/init/woocommerce-setup.sh' www-data
#     touch /usr/local/bin/woocommerce-setup-completed
# fi

# Generate random products
# if [ ! -f /usr/local/bin/products-generated ]; then
#     source /usr/local/bin/init/generate-products.sh
#     touch /usr/local/bin/products-generated
# fi

# Install plugins
# source /usr/local/bin/init/install-plugins.sh

# Enable local plugins
# su -s /bin/sh -c 'source /usr/local/bin/init/activate-plugins.sh' www-data

cp /usr/local/bin/init/wp-config.php ${WORDPRESS_PATH}/wp-config.php
echo 'copied wp-config.php'

# Keep the container running
tail -f /dev/null
