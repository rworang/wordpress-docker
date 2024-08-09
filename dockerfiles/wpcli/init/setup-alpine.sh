#!/bin/bash

# Setup Alpine
apk update --no-cache
apk add --upgrade apk-tools
apk upgrade --no-cache
apk add --no-cache mysql-client mariadb-connector-c dos2unix bash

if [ ! -f /usr/local/bin/alpine-setup-completed ]; then

  dos2unix /usr/local/bin/init/activate-plugins.sh
  dos2unix /usr/local/bin/init/generate-products.sh
  dos2unix /usr/local/bin/init/install-plugins.sh
  dos2unix /usr/local/bin/init/setup.sh
  dos2unix /usr/local/bin/init/woocommerce-setup.sh
  dos2unix /usr/local/bin/init/wordpress-setup.sh

  chmod +x /usr/local/bin/init/activate-plugins.sh
  chmod +x /usr/local/bin/init/generate-products.sh
  chmod +x /usr/local/bin/init/install-plugins.sh
  chmod +x /usr/local/bin/init/setup.sh
  chmod +x /usr/local/bin/init/woocommerce-setup.sh
  chmod +x /usr/local/bin/init/wordpress-setup.sh

  touch /usr/local/bin/alpine-setup-completed

fi

# could add a check here to see if everything is set up already
# now I have it on the separate setups, so I don't need to do it here
/usr/local/bin/init/setup.sh
