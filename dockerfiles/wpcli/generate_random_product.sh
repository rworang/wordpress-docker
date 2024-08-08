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