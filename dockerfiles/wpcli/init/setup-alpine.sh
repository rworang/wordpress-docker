#!/bin/bash

# Setup Alpine
apk update --no-cache
apk add --upgrade apk-tools
apk upgrade --no-cache
apk add --no-cache mysql-client mariadb-connector-c dos2unix bash

if [ ! -f /tmp/alpine-setup-completed ]; then

  dos2unix /tmp/init/activate-plugins.sh
  dos2unix /tmp/init/generate-products.sh
  dos2unix /tmp/init/install-plugins.sh
  dos2unix /tmp/init/setup.sh
  dos2unix /tmp/init/woocommerce-setup.sh
  dos2unix /tmp/init/wordpress-setup.sh

  chmod +x /tmp/init/activate-plugins.sh
  chmod +x /tmp/init/generate-products.sh
  chmod +x /tmp/init/install-plugins.sh
  chmod +x /tmp/init/setup.sh
  chmod +x /tmp/init/woocommerce-setup.sh
  chmod +x /tmp/init/wordpress-setup.sh

  touch /tmp/alpine-setup-completed

fi

# could add a check here to see if everything is set up already
# now I have it on the separate setups, so I don't need to do it here
su -s /bin/sh -c '/tmp/init/setup.sh' root
