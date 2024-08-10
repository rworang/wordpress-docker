# dockerfiles/wpcli/dockerfile
FROM wordpress:cli

USER root

RUN apk update --no-cache
RUN apk add --upgrade apk-tools
RUN apk upgrade --no-cache
RUN for i in mysql-client mariadb-connector-c dos2unix bash; do apk add --no-cache $i; done 

ADD --chown=www-data:www-data --chmod=755 init /tmp/init
RUN for i in /tmp/init/*.sh; do dos2unix $i; done

USER www-data

ENTRYPOINT ["/bin/bash", "-c", "/tmp/init/setup.sh"]