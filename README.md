# WordPress & WooCommerce Docker Container

This Docker container runs a self-hosted WordPress site tailored for development. The site is available at `http://localhost:8080/`, and phpMyAdmin can be accessed at `http://localhost:8181/`.

The container includes a pre-configured WordPress admin account:

- **Username:** `root`
- **Password:** `root`
- **MySQL Username:** `root`
- **MySQL Password:** _None_

These credentials, along with other configuration details, can be found in the [`.env`](.env) file.

## The image build has been removed, the container can now just be [started](#starting-the-container) using `docker-compose up -d` and [stopped](#stopping-the-container) via `docker-compose down -v`

## Table of Contents

- [WordPress Plugins](#wordpress-plugins)
  - [WooCommerce](#woocommerce)
  - [Allergens and Dietary](#allergens-and-dietary)
- [Using the Container](#using-the-container)
  - [Cloning the Repository](#cloning-the-repository)
  - [Initial Build](#initial-build)
  - [Stopping the Container](#stopping-the-container)
  - [Starting the Container](#starting-the-container)
- [Development](#development)
- [Troubleshooting](#troubleshooting)
  - [Plugin Activation Issues](#plugin-activation-issues)
  - [Additional Commands](#additional-commands)
- [Resources](#resources)
- [Documentation](#documentation)

## WordPress Plugins

### WooCommerce

The WordPress instance includes WooCommerce, which is downloaded and installed using the [WordPress CLI](https://developer.wordpress.org/cli/commands/).  
_Note: You still need to skip the WooCommerce setup wizard and select a country._

### Allergens and Dietary

This plugin is managed as a [`submodule`](https://github.blog/open-source/git/working-with-submodules/) and links to the [`Ictoria-BV/wp_allergenen`](https://github.com/Ictoria-BV/wp_allergenen) [`Dev`](https://github.com/Ictoria-BV/wp_allergenen/tree/Dev) branch. For more details, see the [Development](#development) section.

## Using the Container

The [`docker-compose.yml`](docker-compose.yml) file defines and runs the WordPress site with WooCommerce. Access the site at `http://localhost:8080/` and phpMyAdmin at `http://localhost:8181`.

### Cloning the Repository

Clone the repository with submodules:

```sh
git clone --recurse-submodules https://github.com/rworang/wordpress-docker.git
```

Ensure submodules are updated:

```sh
git submodule update --init --recursive
```

_Note: The `--init` flag initializes submodules, and the `--recursive` flag handles nested submodules._

### Initial Build

To build the `local_wpcli` Docker image from the [Dockerfile](dockerfiles/wpcli/Dockerfile), run:

```sh
docker-compose up --build -d
```

_Note: The `--build` flag ensures the Dockerfile is built before starting, and `-d` runs the container in detached mode._

Upon successful build, the container logs should indicate:

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

If these logs appear, the build is successful. If there are issues, refer to [Troubleshooting](#troubleshooting).

Visit [`http://localhost:8080/?post_type=product`](http://localhost:8080/?post_type=product) to see WooCommerce products, and [`http://localhost:8080/wp-login.php`](http://localhost:8080/wp-login.php) to log in with `root:root`.

### Stopping the Container

To stop the container, run:

```sh
docker-compose down
```

### Starting the Container

If the `local_wpcli` image is built, start the container with:

```sh
docker-compose up -d
```

## Development

The container is set up for developing the [`allergens-dietary-ictoria`](https://github.com/Ictoria-BV/wp_allergenen/) plugin using a Git submodule.

Ensure your IDE (e.g., VSCode) is configured with GitHub extensions and access permissions. If submodules aren't pulling correctly, use:

```sh
git pull --recurse-submodules
git submodule init
git submodule update --init --recursive
```

## Troubleshooting

### Plugin Activation Issues

- **WooCommerce:** If activation fails but installation succeeds, you can activate it later via the WordPress admin panel. _Note: If not activated, product creation may be affected._
- **Allergens and Dietary:** If activation fails, check the submodule files in `work_dir/plugins/allergens-dietary-ictoria` via VSCode. Ensure you're logged in to GitHub with the correct permissions.

### Additional Commands

Use these commands if necessary (note that some will remove stored data):

- **Remove Existing Containers and Images:**

  ```sh
  docker-compose down --rmi all --volumes --remove-orphans
  ```

- **Rebuild Docker Images:**

  ```sh
  docker-compose build --no-cache
  ```

- **Clean Up Docker Resources:**

  ```sh
  docker system prune -a -f
  ```

For more detailed commands, refer to the [Docker documentation](https://docs.docker.com/).

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

## Documentation

For further documentation, visit the [docs](docs) directory.

---

### Summary of Changes:

1. **Simplified and Clarified**: I made the language more concise and direct, reducing redundancy.
2. **Formatting Improvements**: Used bullet points and headers to organize the content, making it easier to scan.
3. **Removed Excessive Details**: Removed overly detailed explanations and redirected to appropriate resources when necessary.

This format should be easier to navigate and understand while maintaining all the necessary details for users.
