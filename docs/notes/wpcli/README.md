# TO-DO

Split `wpcli-init.sh` into separate files

- generate_random_product() (needs to be optimized, have to look into wordpress cli command docs)
- [stays] Database check (might be turned into a function to toggle logging, could optimize things)
- wordpress setup
- woocommerce setup
- allergens plugin activation (maybe add some check to see if the `submodule` and/or `work_dir/plugins/allergens-dietary-ictoria` is populated)

```sh
# wp wc product create \

    #     --name="Product 1" \
    #     --type="simple" \
    #     --regular_price="19.99" \
    #     --meta_data='[{"id":160,"key":"allergens_dietary_ictoria","value":["peanuts","nuts","sesame","lupin","soya","mustard","eggs","dairy","fish","crustaceans","molluscs","gluten","corn","wheat","celery","sulfite","alcohol","vegetarian","vegan","halal","pregnant"]}]' \
    #     --path="${WORDPRESS_PATH}" \
    #     --user="${WORDPRESS_ADMIN_USER}"
```

- add better logging

https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
