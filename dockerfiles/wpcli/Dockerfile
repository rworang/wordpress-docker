# dockerfiles/wpcli/dockerfile
FROM wordpress:cli

USER root

RUN apk update --no-cache && \
  apk add --upgrade apk-tools && \
  apk upgrade --no-cache && \
  apk add --no-cache mysql-client mariadb-connector-c dos2unix bash jq

COPY init /usr/local/bin/init

RUN dos2unix /usr/local/bin/init/activate-plugins.sh && \
  dos2unix /usr/local/bin/init/generate-products.sh && \
  dos2unix /usr/local/bin/init/install-plugins.sh && \
  dos2unix /usr/local/bin/init/setup.sh && \
  dos2unix /usr/local/bin/init/woocommerce-setup.sh && \
  dos2unix /usr/local/bin/init/wordpress-setup.sh

RUN chmod +x /usr/local/bin/init/activate-plugins.sh && \
  chmod +x /usr/local/bin/init/generate-products.sh && \
  chmod +x /usr/local/bin/init/install-plugins.sh && \
  chmod +x /usr/local/bin/init/setup.sh && \
  chmod +x /usr/local/bin/init/woocommerce-setup.sh && \
  chmod +x /usr/local/bin/init/wordpress-setup.sh

USER www-data
