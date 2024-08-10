#!/bin/bash

generate_random_products() {
    for i in $(seq 1 "$RANDOM_PRODUCT_AMOUNT"); do
        # Generate a random product name
        product_name="Product $(shuf -i 1-100 -n 1)"

        # Generate a random price
        price_type=$(shuf -e "round" "49" "99" -n 1)
        if [ "$price_type" = "round" ]; then
            product_price=$(shuf -i 1-100 -n 1)
        else
            product_price=$(shuf -i 1-99 -n 1).$price_type
        fi

        wp wc product create \
            --name="$product_name" \
            --type="simple" \
            --regular_price="$product_price" \
            --path="${WORDPRESS_PATH}" \
            --user="${WORDPRESS_ADMIN_USER}"
    done
}
generate_random_products
