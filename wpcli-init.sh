#!/bin/sh

# Wait for the database to be ready
echo "Checking database connection..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    printf "."
    sleep 2
done

echo "Database is ready!"

# Print the path variable for debugging
echo "WordPress path is set to ${WORDPRESS_PATH}"

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


# Install WooCommerce if not already installed
if ! wp plugin is-installed woocommerce --path="${WORDPRESS_PATH}"; then

    echo "Installing WooCommerce..."
    wp plugin install woocommerce --path="${WORDPRESS_PATH}"

    if ! wp plugin is-active woocommerce --path="${WORDPRESS_PATH}"; then
        echo "Activating & setting up WooCommerce..."

        wp plugin activate woocommerce --path="${WORDPRESS_PATH}"
        echo "WooCommerce activated"

        echo "WooCommerce configuring store..."
        wp option update woocommerce_store_address "${WOOCOMMERCE_STORE_ADDRESS}" --path="${WORDPRESS_PATH}"
        wp option update woocommerce_store_address_2 "${WOOCOMMERCE_STORE_ADDRESS_2}" --path="${WORDPRESS_PATH}"
        wp option update woocommerce_store_city "${WOOCOMMERCE_STORE_CITY}" --path="${WORDPRESS_PATH}"
        wp option update woocommerce_store_country "${WOOCOMMERCE_STORE_COUNTRY}" --path="${WORDPRESS_PATH}"
        wp option update woocommerce_store_postcode "${WOOCOMMERCE_STORE_POSTCODE}" --path="${WORDPRESS_PATH}"
        wp option update woocommerce_currency "${WOOCOMMERCE_CURRENCY}" --path="${WORDPRESS_PATH}"
        wp option update woocommerce_price_thousand_sep "${WOOCOMMERCE_PRICE_THOUSAND_SEP}" --path="${WORDPRESS_PATH}"
        wp option update woocommerce_price_decimal_sep "${WOOCOMMERCE_PRICE_DECIMAL_SEP}" --path="${WORDPRESS_PATH}"

        # Create some products
        echo "WooCommerce creating products..."
        wp wc product create --name="Product 1" --type="simple" --regular_price="19.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 2" --type="simple" --regular_price="29.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 3" --type="simple" --regular_price="12.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 4" --type="simple" --regular_price="14.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 5" --type="simple" --regular_price="34.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 6" --type="simple" --regular_price="49.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 7" --type="simple" --regular_price="29.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 8" --type="simple" --regular_price="12.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"
        wp wc product create --name="Product 9" --type="simple" --regular_price="14.99" --path="${WORDPRESS_PATH}" --user="${WORDPRESS_ADMIN_USER}"

        # Trying to remove the setup wizard
        # 
        # This is not working.
        #
        # Why is it so difficult to skip that wizard.
        # 
        # echo "WooCommerce configuring settings/skipping setup wizard..."
        # wp option pluck woocommerce_onboarding_profile true --path="${WORDPRESS_PATH}"
        wp option pluck woocommerce_onboarding_profile --path="${WORDPRESS_PATH}"
        wp option patch insert woocommerce_onboarding_profile 1 --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_show_marketplace_suggestions 'no' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_allow_tracking 'no' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_task_list_hidden 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_task_list_complete 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_task_list_welcome_modal_dismissed 'yes' --path="${WORDPRESS_PATH}"

        # wp option update fresh_site "false" --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_newly_installed "no" --path="${WORDPRESS_PATH}"

        # wp option update woocommerce_api_enabled "true" --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_allow_tracking 'no' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_show_marketplace_suggestions 'no' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_demo_store 'no' --path="${WORDPRESS_PATH}"

        # wp option update woocommerce_onboarding_profile "true" --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_onboarding_opt_in "false" --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_enable_setup_wizard "false" --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_prevent_automatic_wizard_redirect "false" --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_task_list_keep_completed 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_task_list_complete 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_extended_task_list_complete 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_task_list_reminder_bar_hidden 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_task_list_welcome_modal_dismissed 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_admin_customize_store_completed 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_admin_customize_store_survey_completed 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_admin_created_default_shipping_zones 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_admin_reviewed_default_shipping_zones 'yes' --path="${WORDPRESS_PATH}"

        # wp option update woocommerce_customize_store_onboarding_tour_hidden 'yes' --path="${WORDPRESS_PATH}"
        # wp option update woocommerce_onboarding_profile_completed 'true' --path="${WORDPRESS_PATH}"

        # wp option patch insert woocommerce_onboarding_profile false --path="${WORDPRESS_PATH}"

    fi
    echo "WooCommerce installed and set up"
else
    echo "WooCommerce is already installed."
fi

# Keep the container running
tail -f /dev/null
