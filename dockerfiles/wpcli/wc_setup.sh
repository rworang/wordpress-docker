#!/bin/bash

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

fi