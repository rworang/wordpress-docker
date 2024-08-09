#!/bin/bash

generate_random_product() {
    product_name="Product $(shuf -i 1-100 -n 1)"

    price_type=$(shuf -e "round" "49" "99" -n 1)
    if [ "$price_type" = "round" ]; then
        product_price=$(shuf -i 1-100 -n 1)
    else
        product_price=$(shuf -i 1-99 -n 1).$price_type
    fi

    options="peanuts nuts sesame lupin soya mustard eggs dairy fish crustaceans molluscs gluten corn wheat celery sulfite alcohol vegetarian vegan halal pregnant"

    num_options=$(shuf -i 1-5 -n 1)
    selected_options=$(echo $options | tr ' ' '\n' | shuf -n "$num_options" | tr '\n' ',' | sed 's/,$//')

    value="[\"$(echo $selected_options | sed 's/,/","/g')\"]"

    # Return product data in JSON format
    echo "{
        \"name\": \"$product_name\",
        \"type\": \"simple\",
        \"regular_price\": \"$product_price\",
        \"meta_data\": [{
            \"key\": \"allergens_dietary_ictoria\",
            \"value\": $value
        }]
    }"
}

# Generate all products at once
echo "Generating products..."

products=()
for i in $(seq 1 $RANDOM_PRODUCT_AMOUNT); do
    products+=("$(generate_random_product)")
done

# Insert all products using WP CLI
wp wc product create --batch --path="${WORDPRESS_PATH}" <<JSON
[
$(printf "%s\n" "${products[@]}" | jq -s .)
]
JSON

echo "Products created!"
