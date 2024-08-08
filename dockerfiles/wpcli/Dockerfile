# dockerfiles/wpcli/dockerfile
FROM wordpress:cli

USER root

RUN apk update --no-cache && \
  apk add --upgrade apk-tools && \
  apk upgrade --no-cache && \
  apk add --no-cache mysql-client mariadb-connector-c dos2unix

USER www-data
