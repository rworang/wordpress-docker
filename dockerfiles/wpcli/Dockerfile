# https://github.com/docker-library/repo-info/blob/master/repos/wordpress/local/cli.md
# dockerfiles/wpcli/dockerfile
FROM wordpress:cli

USER root
# replace shell with bash so we can source files

RUN apk update --no-cache
RUN for i in alpine-baselayout apk-tools mysql-client mariadb-connector-c dos2unix bash git curl node npm; do apk add --upgrade --no-cache $i; done 
RUN apk upgrade --no-cache

# RUN cd /etc/profile.d && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh

ADD --chown=33:33 --chmod=755 init /tmp/init
RUN for i in /tmp/init/*.sh; do dos2unix $i; done

USER 33:33
ENV HOME /tmp

ENTRYPOINT ["/bin/bash", "-c", "/tmp/init/setup.sh"]