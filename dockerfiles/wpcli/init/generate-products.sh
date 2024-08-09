#!/bin/bash

# Increment the meta_id by 3
meta_id=160

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

        # Meta data
        # key="allergens_dietary_ictoria"

        # Define options
        # options="peanuts nuts sesame lupin soya mustard eggs dairy fish crustaceans molluscs gluten corn wheat celery sulfite alcohol vegetarian vegan halal pregnant"

        # Select random options
        # num_options=$(shuf -i 1-5 -n 1)
        # selected_options=$(echo $options | tr ' ' '\n' | shuf -n "$num_options" | tr '\n' ',' | sed 's/,$//')

        # Format selected options into JSON
        # value="[\"$(echo $selected_options | sed 's/,/","/g')\"]"

        # Create product using WP CLI
        su -s /bin/sh -c 'wp wc product create \
            --name="$product_name" \
            --type="simple" \
            --regular_price="$product_price" \
            --path="${WORDPRESS_PATH}" \
            --user="${WORDPRESS_ADMIN_USER}"' www-data
        # su -s /bin/sh -c 'wp wc product create \
        #     --name="$product_name" \
        #     --type="simple" \
        #     --regular_price="$product_price" \
        #     --meta_data="[ { \"id\": $meta_id, \"key\": \"$key\", \"value\": $value } ]" \
        #     --path="${WORDPRESS_PATH}" \
        #     --user="${WORDPRESS_ADMIN_USER}"' www-data

        # meta_id=$((meta_id + 3))
    done
}
generate_random_products
echo "Products created!"
