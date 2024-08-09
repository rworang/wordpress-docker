#!/bin/bash

# Download WordPress if not already downloaded
if [ ! -f "$WORDPRESS_PATH/wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --path="${WORDPRESS_PATH}"
fi

# Create wp-config.php if it does not exist
if [ ! -f "$WORDPRESS_PATH/wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --path="${WORDPRESS_PATH}"

    wp config set WP_DEBUG true --path="${WORDPRESS_PATH}"
    wp config set WP_DEBUG_LOG true --path="${WORDPRESS_PATH}"
    wp config set WP_DEBUG_DISPLAY false --path="${WORDPRESS_PATH}"
    wp config set SCRIPT_DEBUG true --path="${WORDPRESS_PATH}"
fi

# Create the database if it does not exist
if ! wp db check --path="${WORDPRESS_PATH}"; then
    echo "Creating database..."
    wp db create --path="${WORDPRESS_PATH}"
fi

# Install WordPress if not already installed
if ! wp core is-installed --path="${WORDPRESS_PATH}"; then
    echo "Installing WordPress..."
    wp core install \
        --url="${WORDPRESS_SITE_URL}" \
        --title="${WORDPRESS_SITE_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --path="${WORDPRESS_PATH}"
    echo "WordPress installed!"
else
    echo "WordPress is already installed."
fi
