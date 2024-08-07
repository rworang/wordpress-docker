## WordPress & WooCommerce Docker container

<sup>\* This is a live document, changes to it will be made.</sup>

This is a Docker container that runs a pre-configured WordPress installation, installs & activates WooCommerce and populates it with products.

The WordPress install is set up with the default `admin_user:password` of `root:root`, the values of these, and more, can be set in the `.env` file under `# Default WordPress Admin account`.

It is currently set-up for [`allergens-dietary-ictoria`](https://github.com/Ictoria-BV/wp_allergenen) plugin and expects the proper files for this plugin to be placed inside `work_dir/plugins/allergens-dietary-ictoria`.

---

## Index

- [Running & removing the container](#running-&-removing-the-container)
- - [Initial build](#initial-build)
- - [Mounting the container](#mounting-the-container)
- - [Unmounting the container](#unmounting-the-container)
- [Docker Images](#docker-images)
- [Docker Volumes](#docker-volumes)
- [Troubleshooting](#troubleshooting)

---

## Running & removing the container

To run the container you need to build the images for them to be used in the `docker-compose.yml`.

### Initial build

For the initial `docker-compose up` use these options

- `--build` tag to build the `local/wordpress` and `local/wordpress_cli` images
- `--detach` for detached mode so you can keep using the terminal.

```sh
  docker-compose up --build --detach
  or
  docker-compose up --build -d
```

`When using GitHub Desktop make sure to always run the build command from the `main` branch, unless changes are made to the Docker build process and related files.`

### After initial build

_Once the command is finished in the terminal check for the status of the setup in the `wordpress-docker` or `local_wpcli` container logs on Docker Desktop. The logs originate from the `dockerfiles/wpcli/wpcli-init.sh` Shell script, you can check against that if everything is loaded properly._

The rough outline of the steps of `wpcli-init.sh` are:

> - Wait for database connection
> - Download WordPress core if not downloaded
> - Set up `wp-config.php` if not found
> - Create database if not created
> - Install WordPress if not installed
> - Install WooCommerce if not installed
> - Activate WooCommerce if not installed
> - Configure WooCommerce store
> - Create test products (these use the [`allergens-dietary-ictoria`](https://github.com/Ictoria-BV/wp_allergenen) `meta_data`)
> - Activate [`allergens-dietary-ictoria`](https://github.com/Ictoria-BV/wp_allergenen) plugin
>   <sub>\* the activation of plugins doens't always work, it might need manual activation</sub>

### Mounting the container

If after the initial `docker-compose up` command the `local/wordpress` and `local/wordpress_cli` images are shown in Docker Desktop, or via the terminal, the container can be run by using:

```sh
  docker-compose up --detach
  or
  docker-compose up -d
```

### Unmounting the container

The `docker-compose down` command can be run as is, but if no essential data is stored on the volumes you might as well run the `--volumes` option to clear out the volumes.

```sh
  docker-compose down --volumes
  or
  docker-compose down -v
```

---

## Docker Images

The `docker-compose.yml` builds local images of the `wordpress` and `wpcli` which are named `local/wordpress_cli` and `local/wordpress`. For general development these images only need to be built on the initial setup.

_Currently the `wordpress` image is not necessary, the `docker-compose.yml` could be adjusted to use `wordpress:latest`, I have not fully tested this but it should work._

_`If this or anything related to the builds gets changed make sure to run the proper commands to get a clean install.`_

---

## Docker Volumes

`wordpress:/var/www/html`

- Binds WordPress install directory to the `wordpress` volume, makes it easy to access files via Docker Desktop.

`./work_dir/plugins/allergens-dietary-ictoria:/var/www/html/wp-content/plugins/allergens-dietary-ictoria`

- Sets up a bind between `work_dir/plugins/allergens-dietary-ictoria` and the correct location of it inside the WordPress install directory.

`plugins:/var/www/html/wp-content/plugins`

- This binds the `plugins` volume to the plugins directory inside the WordPress install directory.

The last two volumes **have to be in that order**, this will make sure the content of `work_dir/plugins/allergens-dietary-ictoria` gets copied into the WordPress installation before the `plugins` volume gets mounted.

This is important because, if it is not done in this order the contents of the WordPress plugins directory can be copied into `work_dir/plugins`. These files then have different owners and can make it difficult to them, on WSL they can be removed by using `sudo rm -r work_dir/plugins/directory-or-file-name`.

---

## Troubleshooting

If there are ever any errors or oddities, use `docker-compose down -v` and re-do `docker-compose up --build -d`. And if that does not fix it, these commands can be used to clean up Docker as there might be some corrupted data. It is important to wait for all commands to fully complete before visiting the site or changing any data.

**Error establishing a database connection**
If you get this or a similar error when accessing the site check if `local_wpcli` is done setting up and refresh.

_`Be careful with these commands as some remove stored data, or do a general clean-up of unused data.`_

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

**Remove Unused Containers**:

```sh
docker container prune -f
```

**Remove Unused Volumes**:

```sh
docker volume prune -f
```

**Remove Unused Networks**:

```sh
docker network prune -f
```

**Remove All Unused Data**:

```sh
docker system prune -a -f
```
