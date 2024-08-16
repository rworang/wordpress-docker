#!/bin/bash

set -e

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

##-WooCommerce this is a non-dev version
#
# # WooCommerce setup
# if [ ! -f /tmp/woocommerce-setup-completed ]; then
#     source /tmp/init/woocommerce-setup.sh
#     touch /tmp/woocommerce-setup-completed && echo "WooCommerce setup completed"
# fi

# # Generate random products
# if [ ! -f /tmp/products-generated ]; then
#     source /tmp/init/generate-products.sh
#     touch /tmp/products-generated && echo "Products generated"
# fi

# Install plugins
source /tmp/init/install-plugins.sh

# Enable local plugins
source /tmp/init/activate-plugins.sh

echo "WP-CLI setup completed"
# Keep the container running
tail -f /dev/null
