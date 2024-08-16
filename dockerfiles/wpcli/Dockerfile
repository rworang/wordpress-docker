# Using the specific PHP 8.1 version of the WordPress CLI image, which is still Alpine-based
FROM wordpress:cli-php8.1

USER root

# Update the package list and install necessary packages
RUN apk update --no-cache

# Install packages including Node.js and npm
RUN apk add --no-cache \
  alpine-baselayout \
  apk-tools \
  mysql-client \
  mariadb-connector-c \
  dos2unix \
  bash \
  git \
  curl \
  nodejs \
  npm

# Upgrade installed packages to their latest versions
RUN apk upgrade --no-cache

# Convert any Windows-style line endings in scripts to Unix-style
ADD --chown=33:33 --chmod=755 init /tmp/init
RUN for i in /tmp/init/*.sh; do dos2unix $i; done

# Switch back to the www-data user (user ID 33) for running scripts
USER 33:33

# Set the home directory to /tmp
ENV HOME /tmp
