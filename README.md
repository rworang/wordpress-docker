# WordPress & WooCommerce Docker Container

This Docker container runs a self-hosted WordPress site tailored for development. The site is available at `http://localhost:8080/`, and phpMyAdmin can be accessed at `http://localhost:8181/`.

The container includes a pre-configured WordPress admin account:

- **Username:** `root`
- **Password:** `root`
- **MySQL Username:** `root`
- **MySQL Password:** _None_

These credentials, along with other configuration details, can be found in the [`.env`](.env) file.

## Table of Contents

- [WordPress Plugins](#wordpress-plugins)
  - [WooCommerce](#woocommerce)
  - [Allergens and Dietary](#allergens-and-dietary)
- [Using the Container](#using-the-container)
  - [Starting the Container](#starting-the-container)
  - [Stopping the Container](#stopping-the-container)
- [Documentation](#documentation)
- [Resources](#resources)

## WordPress Plugins

### WooCommerce

The WordPress instance includes WooCommerce, which is downloaded and installed using the [WordPress CLI](https://developer.wordpress.org/cli/commands/).  
_Note: You still need to skip the WooCommerce setup wizard and select a country._

### Allergens and Dietary

This plugin was previously managed as a [`submodule`](https://github.blog/open-source/git/working-with-submodules/), but for simplicity that is removed. It is expected to manage that yourself, either by a symbolic link, managing GitHub Desktop to place the plugin root inside the `work_dir/plugins/PLUGIN_NAME` folder (PLUGIN_NAME needs to be the same as the value in the `.env`).

## Using the Container

For development usage you can create a new repository from this template, in the top right there is the green `Use this template` button, it creates a copy of this repository on your account without the commit history.

The reason this is a template is because when working with multiple accounts it's easier to just quickly create a new repo from the template on the account that has permission to view/work on the private repository. Linking the plugin to that repository would/should not cause any permission issues.

### Linking the Plugin Directory

- Submodule:<br>
  You can use the `submodule` option but you'll need to figure that out, I don't think it is needed in this environment. _This will cause permission issues if not used correctly._

- Symbolic link:<br>
  I prefer to create a symbolic link called `allergens-dietary-ictoria` inside the `plugins` folder that links to the root of the plugin. _This is not the same as a shortcut._

  ```sh
  # https://www.man7.org/linux/man-pages/man1/ln.1.html
  ln -s <source_dir> <link>
  ```

- GitHub Desktop:<br>
  You can also manage it through GitHub Desktop, you'll just need to make sure you link and place the directories correctly.

### Starting the Container

Start the container with wait for it to be finished, this can be seen in Docker under the logs of `local/wpcli`:

```sh
docker-compose up -d # detach
```

### Starting the Container [DEV]

For development you can run the container in watch mode, this looks for file changes and enables hot-reloading. _This can't run in detach mode. `ctrl+c` stops the container, you will need to run the stop container with `-v` to clear volumes._

```sh
docker compose --profile develop up --watch
```

### Stopping the Container

To stop the container, run:

```sh
docker-compose down
or
docker-compose down -v # to remove the volumes, this will need to re-do the setup | [DEV] 
```

## Documentation

For further documentation, visit the [docs](docs) directory.

_\* The docs are not created yet and is just the old README and some random stuff._

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
