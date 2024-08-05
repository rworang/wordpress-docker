#!/bin/sh

# Wait for the database to be ready
echo "Checking database connection..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    printf "."
    sleep 2
done

echo "Database is ready!"


# Download WordPress if not already downloaded
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --path=/var/www/html
fi


# Create wp-config.php if it does not exist
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_DB_USER} \
        --dbpass=${WORDPRESS_DB_PASSWORD} \
        --dbhost=${WORDPRESS_DB_HOST} \
        --path=/var/www/html
fi


# Create the database if it does not exist
if ! wp db check --path=/var/www/html; then
    echo "Creating database..."
    wp db create --path=/var/www/html
fi


# Install WordPress if not already installed
if ! wp core is-installed --path="/var/www/html"; then
    echo "Installing WordPress..."
    wp core install \
        --url="http://localhost:8080" \
        --title="Local Development" \
        --admin_user="root" \
        --admin_password="root" \
        --admin_email="admin@example.com" \
        --path="/var/www/html"
    echo "WordPress installed!"
else
    echo "WordPress is already installed."
fi


# Install WooCommerce if not already installed
if ! wp plugin is-installed woocommerce --path="/var/www/html"; then

    echo "Installing WooCommerce..."
    wp plugin install woocommerce --path="/var/www/html"

    if ! wp plugin is-active woocommerce --path="/var/www/html"; then
        echo "Activating & setting up WooCommerce..."

        wp plugin activate woocommerce --path="/var/www/html"
        echo "WooCommerce activated"

        wp option update fresh_site "false" --path="/var/www/html"
        wp option update woocommerce_newly_installed "no" --path="/var/www/html"

        echo "WooCommerce configuring store..."
        wp option update woocommerce_store_address "123 WooCommerce St" --path="/var/www/html"
        wp option update woocommerce_store_address_2 "Suite 1" --path="/var/www/html"
        wp option update woocommerce_store_city "Commerce City" --path="/var/www/html"
        wp option update woocommerce_store_country "NL" --path="/var/www/html"
        wp option update woocommerce_store_postcode "1234 AB" --path="/var/www/html"
        wp option update woocommerce_currency "EUR" --path="/var/www/html"
        wp option update woocommerce_price_thousand_sep "." --path="/var/www/html"
        wp option update woocommerce_price_decimal_sep "," --path="/var/www/html"

        wp option update woocommerce_api_enabled "true" --path="/var/www/html"
        wp option update woocommerce_allow_tracking 'no' --path="/var/www/html"
        wp option update woocommerce_show_marketplace_suggestions 'no' --path="/var/www/html"
        wp option update woocommerce_demo_store 'no' --path="/var/www/html"

        echo "WooCommerce skipping setup..."
        wp option update woocommerce_onboarding_profile "true" --path="/var/www/html"
        wp option update woocommerce_onboarding_opt_in "false" --path="/var/www/html"
        wp option update woocommerce_enable_setup_wizard "false" --path="/var/www/html"
        wp option update woocommerce_prevent_automatic_wizard_redirect "false" --path="/var/www/html"
        wp option update woocommerce_task_list_keep_completed 'yes' --path="/var/www/html"
        # wp option update woocommerce_task_list_hidden 'true' --path="/var/www/html"
        wp option update woocommerce_task_list_complete 'yes' --path="/var/www/html"
        # wp option update woocommerce_extended_task_list_hidden 'true' --path="/var/www/html"
        wp option update woocommerce_extended_task_list_complete 'yes' --path="/var/www/html"
        wp option update woocommerce_task_list_reminder_bar_hidden 'yes' --path="/var/www/html"
        wp option update woocommerce_task_list_welcome_modal_dismissed 'yes' --path="/var/www/html"
        wp option update woocommerce_admin_customize_store_completed 'yes' --path="/var/www/html"
        wp option update woocommerce_admin_customize_store_survey_completed 'yes' --path="/var/www/html"
        wp option update woocommerce_admin_created_default_shipping_zones 'yes' --path="/var/www/html"
        wp option update woocommerce_admin_reviewed_default_shipping_zones 'yes' --path="/var/www/html"

        wp option update woocommerce_customize_store_onboarding_tour_hidden 'yes' --path="/var/www/html"
        wp option update woocommerce_onboarding_profile_completed 'true' --path="/var/www/html"

        # wp option patch insert woocommerce_onboarding_profile false --path="/var/www/html"
    fi
    echo "WooCommerce installed and set up"
else
    echo "WooCommerce is already installed."
fi

# Keep the container running
tail -f /dev/null
