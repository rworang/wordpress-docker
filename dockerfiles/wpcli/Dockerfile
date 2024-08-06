# dockerfiles/wpcli/dockerfile
FROM wordpress:cli

USER root

RUN apk update --no-cache && \
  apk add --upgrade apk-tools && \
  apk upgrade --no-cache && \
  apk add --no-cache mysql-client mariadb-connector-c dos2unix

COPY wpcli-init.sh /usr/local/bin/wpcli-init.sh

RUN dos2unix /usr/local/bin/wpcli-init.sh
# RUN echo "Content of wpcli-init.sh:" && cat /usr/local/bin/wpcli-init.sh
RUN chmod +x /usr/local/bin/wpcli-init.sh
# RUN ls -l /usr/local/bin/wpcli-init.sh

USER www-data
