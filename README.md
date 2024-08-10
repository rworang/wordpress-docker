# WordPress Development Environment with Docker

![In Development](https://img.shields.io/badge/status-in%20development-orange)
![MIT License](https://img.shields.io/badge/license-MIT-blue)

This repository provides a Docker-based development environment for WordPress, complete with MySQL, phpMyAdmin, and WP-CLI support.

## 📝 Table of Contents

- [Getting Started](#getting-started)
- [Container Overview](#container-overview)
- [Development](#development)
- [Starting the Containers](#starting-the-containers)
- [Stopping the Containers](#stopping-the-containers)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## 🚀 Getting Started
<a name="getting-started"></a>
1. **Clone the Repository:**

   ```bash
   git clone https://github.com/rworang/wordpress-docker.git
   cd wordpress-docker
   ```

2. **Create a `.env` file:**

   Create a `.env` file in the root of the project to store environment variables like MySQL root password, database name, etc. There is a `example.env` included that can be copied and adjusted.

   ```markdown
   | **Key**                          | **Value**               |
   | :------------------------------- | :---------------------- |
   | `WORDPRESS_PATH`                 | `/var/www/html`         |
   | `PLUGIN_NAME`                    | `plugin-name-goes-here` |
   | `WORDPRESS_DB_HOST`              | `mysql`                 |
   | `WORDPRESS_DB_USER`              | `root`                  |
   | `WORDPRESS_DB_PASSWORD`          |                         |
   | `WORDPRESS_DB_NAME`              | `wordpress`             |
   | `WORDPRESS_DEBUG`                | `true`                  |
   | `WORDPRESS_DEBUG_LOG`            | `true`                  |
   | `WORDPRESS_DEBUG_DISPLAY`        | `false`                 |
   | `WORDPRESS_SCRIPT_DEBUG`         | `true`                  |
   | `MYSQL_DATABASE`                 | `wordpress`             |
   | `MYSQL_ALLOW_EMPTY_PASSWORD`     | `yes`                   |
   | `WORDPRESS_SITE_URL`             | `http://localhost:8080` |
   | `WORDPRESS_SITE_TITLE`           | `Local Development`     |
   | `WORDPRESS_ADMIN_USER`           | `root`                  |
   | `WORDPRESS_ADMIN_PASSWORD`       | `root`                  |
   | `WORDPRESS_ADMIN_EMAIL`          | `admin@root.com`        |
   | `WOOCOMMERCE_STORE_ADDRESS`      | `123 WooCommerce St`    |
   | `WOOCOMMERCE_STORE_ADDRESS_2`    | `Suite 1`               |
   | `WOOCOMMERCE_STORE_CITY`         | `Commerce City`         |
   | `WOOCOMMERCE_STORE_COUNTRY`      | `NL`                    |
   | `WOOCOMMERCE_STORE_POSTCODE`     | `1234 AB`               |
   | `WOOCOMMERCE_CURRENCY`           | `EUR`                   |
   | `WOOCOMMERCE_PRICE_THOUSAND_SEP` | `.`                     |
   | `WOOCOMMERCE_PRICE_DECIMAL_SEP`  | `,`                     |
   | `RANDOM_PRODUCT_AMOUNT`          | `6`                     |
   ```

3. **Build the Docker Images:**

   Before starting the containers, build the necessary Docker images using:

   ```bash
   docker-compose build
   ```

   This will build the services that require a custom image (e.g., `wd_wpcli`).

4. **Start the Containers with the Develop Profile:**

   To start the containers and enable the watcher on the plugins repository, use:

   ```bash
   docker-compose --profile develop up -d
   ```

   The `develop` profile will activate configurations like file watchers that automatically sync changes in your plugin directory.

5. **Access the Services:**

   - **WordPress:** Open your browser and go to [http://localhost:8080](http://localhost:8080)
   - **phpMyAdmin:** Open your browser and go to [http://localhost:8181](http://localhost:8181)
   - **WP-CLI:** You can use the `wd_wpcli` container to run WP-CLI commands:

     ```bash
     docker exec -it wd_wpcli wp --info
     ```

## 🛠️ Container Overview
<a name="container-overview"></a>
- **MySQL (`wd_mysql`):**

  - Stores the WordPress database.
  - Configuration is done through the `.env` file.
  - Data is persisted using a Docker volume.

- **WordPress (`wd_wp`):**

  - Serves the WordPress site.
  - Exposes port 8080 to your localhost.
  - Mounts the WordPress core and plugin development directories.

- **WP-CLI (`wd_wpcli`):**

  - Provides a command-line interface for WordPress.
  - Can be used for running WP-CLI commands.
  - Automatically syncs with the WordPress and plugin directories.

- **phpMyAdmin (`wd_phpmyadmin`):**
  - Provides a web-based interface for managing the MySQL database.
  - Exposes port 8181 to your localhost.

## 🧑‍💻 Development
<a name="development"></a>
To develop your WordPress plugin:

1. Place your plugin source code in the `./work_dir/plugins/${PLUGIN_NAME}` directory.
2. The plugin will be automatically synced and available in the WordPress installation.

## ▶️ Starting the Containers
<a name="starting-the-containers"></a>
To stop the containers, run:

```bash
docker-compose --profile develop up -d
```
## 🛑 Stopping the Containers
<a name="stopping-the-containers"></a>
To stop the containers, run:

```bash
docker-compose down
```

This will stop and remove the containers, but your data will be preserved in the Docker volumes.

## 🔧 Troubleshooting
<a name="troubleshooting"></a>
- If you encounter issues, try rebuilding the containers:

  ```bash
  docker-compose build
  docker-compose --profile develop up -d
  ```

- Check the logs for any errors:

  ```bash
  docker-compose logs -f
  ```

- Clear volumes and rebuild:

  ```bash
  docker-compose down -v --rmi local
  docker-compose build
  docker-compose --profile develop up -d
  ```

## 📜 License
<a name="license"></a>
This project is licensed under the MIT License.
