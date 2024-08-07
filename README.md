# WordPress & WooCommerce Docker container

This is a Docker container that runs a self-hosted WordPress site meant for development, the site will be available at `http://localhost:8080/` and phpMyAdmin at `http://localhost:8181`.

The Docker WordPress service has a pre-configured admin account for ease of use.

`wp_username: root` `wp_password: root` `mysql_username: root` `mysql_password: NONE`

These values, and more, can be found in the [`.env`](.env) file.

## WordPress plugins

### WooCommerce

The WordPress instance comes with WooCommerce, using the [WordPress CLI](https://developer.wordpress.org/cli/commands/) it downloads and installs the plugin.<br>
<sup>\* You do need to skip the WooCommerce setup wizard at some point and enter a country.</sup>

### Allergens and Dietary

For this plugin a [`submodule`](https://github.blog/open-source/git/working-with-submodules/) is set up, it links to the [`Ictoria-BV/wp_allergenen`](https://github.com/Ictoria-BV/wp_allergenen) [`Dev`](https://github.com/Ictoria-BV/wp_allergenen/tree/Dev) branch. More on this in the [development](#development) section.

## Using the container

### The initial build

The container needs to build the `wpcli` Docker image from the [Dockerfile](dockerfiles/wpcli/Dockerfile). Use this command in the terminal, make sure the command is run from the root directory that contains the [docker-compose.yml](docker-compose.yml):

```sh
docker-compose up --build -d
```

<sup>\* The `build` tag makes sure the [Dockerfile](dockerfiles/wpcli/Dockerfile) is built before starting the container. The `-d` tag is detach, this makes it so you can keep using the terminal.</sup>

### Development

The container is currently set up for the development of the [`allergens-dietary-ictoria`](https://github.com/Ictoria-BV/wp_allergenen/) plugin, that is why a [`submodule`](https://github.blog/open-source/git/working-with-submodules/) is used.

If vscode is set up with the proper GitHub vscode extensions and being logged into the account that has access to the repository, it could/should/would(?), pull the files from the repository.

If it doesn't, there are [docs](https://gist.github.com/gitaarik/8735255) on how to initialize and for troubleshooting.
