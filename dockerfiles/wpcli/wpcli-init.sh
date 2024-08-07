#!/bin/bash

generate_random_product() {
    # Generate a random product name
    product_name="Product $(shuf -i 1-100 -n 1)"
    
    # Generate a random price
    price_type=$(shuf -e "round" "49" "99" -n 1)
    if [ "$price_type" = "round" ]; then
        product_price=$(shuf -i 1-100 -n 1)
    else
        product_price=$(shuf -i 1-99 -n 1).$price_type
    fi

    # Meta data
    meta_id=160
    key="allergens_dietary_ictoria"

    # Define options
    options="peanuts nuts sesame lupin soya mustard eggs dairy fish crustaceans molluscs gluten corn wheat celery sulfite alcohol vegetarian vegan halal pregnant"
    
    # Select random options
    num_options=$(shuf -i 1-5 -n 1)
    selected_options=$(echo $options | tr ' ' '\n' | shuf -n "$num_options" | tr '\n' ',' | sed 's/,$//')

    value="[\"$(echo $selected_options | sed 's/,/","/g')\"]"

    # Create product using WP CLI
    wp wc product create \
        --name="$product_name" \
        --type="simple" \
        --regular_price="$product_price" \
        --meta_data="[ { \"id\": $meta_id, \"key\": \"$key\", \"value\": $value } ]" \
        --path="${WORDPRESS_PATH}" \
        --user="${WORDPRESS_ADMIN_USER}"
}


# Wait for the database to be ready
echo "Checking database connection..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    printf "."
    sleep 2
done
echo "Database is ready"

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
    echo "WooCommerce installed and set up"
else
    echo "WooCommerce is already installed."
fi

if ! wp plugin is-active woocommerce --path="${WORDPRESS_PATH}"; then
    echo "Activating WooCommerce..."
    wp plugin activate woocommerce --path="${WORDPRESS_PATH}"
    if wp plugin is-active woocommerce --path="${WORDPRESS_PATH}"; then
        echo "WooCommerce activated"
    else
        echo "Unable to activate WooCommerce plugin"
    fi
fi


if wp plugin is-active woocommerce --path="${WORDPRESS_PATH}"; then
    echo "WooCommerce configuring store..."
    wp option update woocommerce_store_address "${WOOCOMMERCE_STORE_ADDRESS}" --path="${WORDPRESS_PATH}"
    wp option update woocommerce_store_address_2 "${WOOCOMMERCE_STORE_ADDRESS_2}" --path="${WORDPRESS_PATH}"
    wp option update woocommerce_store_city "${WOOCOMMERCE_STORE_CITY}" --path="${WORDPRESS_PATH}"
    wp option update woocommerce_store_country "${WOOCOMMERCE_STORE_COUNTRY}" --path="${WORDPRESS_PATH}"
    wp option update woocommerce_store_postcode "${WOOCOMMERCE_STORE_POSTCODE}" --path="${WORDPRESS_PATH}"
    wp option update woocommerce_currency "${WOOCOMMERCE_CURRENCY}" --path="${WORDPRESS_PATH}"
    wp option update woocommerce_price_thousand_sep "${WOOCOMMERCE_PRICE_THOUSAND_SEP}" --path="${WORDPRESS_PATH}"
    wp option update woocommerce_price_decimal_sep "${WOOCOMMERCE_PRICE_DECIMAL_SEP}" --path="${WORDPRESS_PATH}"
    echo "WooCommerce store configured"

    # Create some products
    echo "WooCommerce creating products..."
    max=${RANDOM_PRODUCT_AMOUNT}
    for i in $(seq 1 $max)
    do
        echo "Creating product $i..."
        generate_random_product
    done
    echo "WooCommerce products created"

    # wp wc product create \
    #     --name="Product 1" \
    #     --type="simple" \
    #     --regular_price="19.99" \
    #     --meta_data='[{"id":160,"key":"allergens_dietary_ictoria","value":["peanuts","nuts","sesame","lupin","soya","mustard","eggs","dairy","fish","crustaceans","molluscs","gluten","corn","wheat","celery","sulfite","alcohol","vegetarian","vegan","halal","pregnant"]}]' \
    #     --path="${WORDPRESS_PATH}" \
    #     --user="${WORDPRESS_ADMIN_USER}"
fi

if ! wp plugin is-active allergens-dietary-ictoria --path="${WORDPRESS_PATH}"; then
        echo "Activating Allergens and Dietary plugin..."
        wp plugin activate allergens-dietary-ictoria --path="${WORDPRESS_PATH}"
    if wp plugin is-active allergens-dietary-ictoria --path="${WORDPRESS_PATH}"; then
            echo "Allergens and Dietary plugin activated"
    else
            echo "Unable to activate Allergens and Dietry plugin"
    fi
fi

# Keep the container running
tail -f /dev/null


