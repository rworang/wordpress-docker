# WordPress & WooCommerce Docker container

This is a Docker container that runs a self-hosted WordPress site meant for development, the site will be available at `http://localhost:8080/` and phpMyAdmin at `http://localhost:8181`.

The Docker WordPress service has a pre-configured admin account for ease of use.

`wp_username: root` `wp_password: root` `mysql_username: root` `mysql_password: NONE`

These values, and more, can be found in the [`.env`](.env) file.

## Index

- [Wordpress Plugins](#wordpress-plugins)
  - WooCommerce
  - Allergens and Dietary
- [Using the container](#using-the-container)
  - [Cloning the repository](#cloning-the-repository)
  - [The initial build](#the-initial-build)
  - [Stopping the container](#stopping-the-container)
  - [Starting the container](#starting-the-container)
- [Development](#development)
- [Troubleshooting](#Troubleshooting)
  - [Plugin activation fails](#plugin-activation-fails)
  - [Other commands](#other-commands)
- [Resources](#resources)
- [Documentation](docs)

## WordPress plugins

- ### WooCommerce

  The WordPress instance comes with WooCommerce, using the [WordPress CLI](https://developer.wordpress.org/cli/commands/) it downloads and installs the plugin.<br>
  <sup>\* You do need to skip the WooCommerce setup wizard at some point and enter a country.</sup>

- ### Allergens and Dietary

  For this plugin a [`submodule`](https://github.blog/open-source/git/working-with-submodules/) is set up, it links to the [`Ictoria-BV/wp_allergenen`](https://github.com/Ictoria-BV/wp_allergenen) [`Dev`](https://github.com/Ictoria-BV/wp_allergenen/tree/Dev) branch. More on this in the [development](#development) section.

## Using the container

The [`docker-compose.yml`](docker-compose.yml) file in this repository is used to define and run a WordPress site with a WooCommerce plugin, the site can be accessed on `http://localhost:8080/` and phpMyAdmin on `http://localhost:8181`.

### Cloning the repository

You can clone the repository but you need to make sure to use [`--recurse-submodules`](https://git-scm.com/book/en/v2/Git-Tools-Submodules), it will automatically initialize and update each submodule in the repository.

```sh
git clone --recurse-submodules https://github.com/rworang/wordpress-docker.git
```

Then use this to make sure the files are updated:

```sh
git submodule update --init --recursive
```

<sup>\* It runs `git submodule update` and `git submodule init`. The `--init` flag initializes submodules within the repository. The `--recursive` flag handles submodules recursively. If a submodule has its own submodules, this flag ensures it also initializes and updates those nested submodules.</sup>

### The initial build

The container needs to build the `local_wpcli` Docker image from the [Dockerfile](dockerfiles/wpcli/Dockerfile). Use this command in the terminal and make sure the command is run from the `wordpress-docker` root directory that contains the [docker-compose.yml](docker-compose.yml):

```sh
docker-compose up --build -d
```

<sup>\* The `build` flag makes sure the [Dockerfile](dockerfiles/wpcli/Dockerfile) is built before starting the container. The `-d` flag is detach, this makes it so you can keep using the terminal.</sup>

When you run this command it will build the `wpcli` Docker image, this can be seen in Docker Desktop called `local/wordpress_cli`. This is just a copy of the official [`wordpress:cli`](https://hub.docker.com/_/wordpress) but with a copy of [`wpcli-init.sh`](dockerfiles/wpcli/wpcli-init.sh) included. And see something like this:

```sh
 ✔ Network wordpress-docker_development  Created   0.1s
 ✔ Volume "wordpress-docker_wordpress"   Created   0.0s
 ✔ Volume "wordpress-docker_plugins"     Created   0.0s
 ✔ Volume "wordpress-docker_mysql"       Created   0.0s
 ✔ Container local_mysql                 Started   1.0s
 ✔ Container local_wp                    Started   1.3s
 ✔ Container local_phpmyadmin            Started   1.4s
 ✔ Container local_wpcli                 Started   1.5s
```

After the command finishes in the terminal, the container will be mounted and visible in Docker Desktop called `wordpress-docker`, by clicking on this you will be able to see the logs of the 4 services.

We will be looking for the `local_wpcli` logs, you can click on it to only see those logs, but it can be useful to see all services. It waits for `local_mysql` to be set up and log `Checking database connection...`, if you see that, the Shell script is running, it will log the steps it takes and you can re-trace those in [`wpcli-init.sh`](dockerfiles/wpcli/wpcli-init.sh).

What we to see specifically are these logs:

```sh
Checking database connection...
......Database is ready
...
WordPress installed!
...
WooCommerce installed and set up
WooCommerce activated
WooCommerce store configured
WooCommerce products created
...
Allergens and Dietary plugin activated
```

If these logs are confirmed we can be sure the build has completed successfully. May there be failed logs (only for `local_wpcli`), then you should look into [troubleshooting](#troubleshooting).

Now when we visit [`http://localhost:8080/?post_type=product`](http://localhost:8080/?post_type=product) we should see 24 random products with a random selection of tags from the [`allergens-dietary-ictoria`](https://github.com/Ictoria-BV/wp_allergenen/) plugin.

By going to [`http://localhost:8080/wp-login.php`](http://localhost:8080/wp-login.php) you can login using `root:root`.

- ### Stopping the container

The `docker-compose down` command can be run as is.

```sh
  docker-compose down
```

- ### Starting the container

If the `local_wpcli` image is [built](#the-initial-build), the container can be run by using:

```sh
  docker-compose up -d
```

## Development

The container is currently set up for the development of the [`allergens-dietary-ictoria`](https://github.com/Ictoria-BV/wp_allergenen/) plugin, that is why a [`submodule`](https://github.blog/open-source/git/working-with-submodules/) is used.

If vscode is set up with the proper GitHub vscode extensions and being logged into the account that has access to the repository it should pull the files from the repository.

If it doesn't, there is this [gist](https://gist.github.com/gitaarik/8735255) on how to initialize and for troubleshooting and you can also try these. `git pull --recurse-submodules` `git submodule init` `git submodule update --init --recursive`

## Troubleshooting

Most errors/fails should be fixable with these commands:

```sh
# remove volumes
docker-compose down -v
# re-run build process, makes it so wpcli-init.sh runs again
docker-compose up --build -d

or

# remove used volumes
# `wordpress-docker_wordpress` `wordpress-docker_plugins` `wordpress-docker_mysql`
docker-compose down -v
# remove local image `local/wordpress_cli`
docker rmi -f local/wordpress_cli
# re-build the `local/wordpress_cli` image with a fresh download of official `wordpress:cli`
docker-compose build --no-cache
# run the start command
docker-compose up -d
```

### Plugin activation fails

- If WooCommerce fails to activate it might be alright, as long as it did not fail the install. **It can later be activated in the WordPress admin panel.** <br><sup>\* Do note that it not being activated might interfere with the product creation.</sup>
- If Allergens and Dietary fails then it might be an issue with the `submodule`, check if you can see the files in vscode under `work_dir/plugins/allergens-dietary-ictoria`. If they're not there you need to check if you are logged with the proper github account on vscode, have given all the proper permissions etc. <br><sup>_\* More on this will be added at a later time, but check the git commands under [development](#development), this [submodule post](https://github.blog/open-source/git/working-with-submodules/) and this [submodules basic explanation gist](https://gist.github.com/gitaarik/8735255)._</sup>

### Other commands

_`The following commands are only if necessary, do look them up before using them as some remove stored data or do a general clean-up of unused data.`_

**Remove Existing Containers and Images**:

```sh
docker-compose down --rmi all --volumes --remove-orphans
```

**Rebuild Docker Images**:

```sh
docker-compose build --no-cache
```

**Remove Dangling Images**:

```sh
docker image prune -f
```

**Remove Unused Volumes**:

```sh
docker volume prune -f
```

**Remove Unused Networks**:

```sh
docker network prune -f
```

**Remove Unused Containers**:

```sh
docker container prune -f
```

**Remove All Unused Data**:

```sh
docker system prune -a -f
```

## Resources

- [Use Docker to create a local WordPress development environment](https://www.massolit-media.com/technical-writing/local-wordpress-development-environment-with-docker/)
- [How To Install WordPress With Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose)
- [Understanding CMD and ENTRYPOINT Differences in Docker](https://devtron.ai/blog/cmd-and-entrypoint-differences/)
- [How Compose works](https://docs.docker.com/compose/compose-application-model/)
- [Set environment variables within your container's environment](https://docs.docker.com/compose/environment-variables/set-environment-variables/)
- [WP-CLI Commands](https://developer.wordpress.org/cli/commands/)
- [Working with submodules](https://github.blog/open-source/git/working-with-submodules/)
- [Docker Official Image: wordpress](https://hub.docker.com/_/wordpress)
- [Git Submodules basic explanation](https://gist.github.com/gitaarik/8735255)
