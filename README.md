# WordPress Development Environment with Docker

This repository contains a Docker-based development environment for WordPress, including a MySQL database, phpMyAdmin, and WP-CLI.

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your machine
- [Docker Compose](https://docs.docker.com/compose/) (usually comes with Docker)

## Getting Started

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```

2. **Create a `.env` file:**

   Create a `.env` file in the root of the project to store environment variables such as MySQL root password, database name, etc. The file should look something like this:

   ```env
   MYSQL_ROOT_PASSWORD=your_root_password
   MYSQL_DATABASE=your_database
   MYSQL_USER=your_user
   MYSQL_PASSWORD=your_password

   WORDPRESS_DB_HOST=mysql:3306
   WORDPRESS_DB_USER=your_user
   WORDPRESS_DB_PASSWORD=your_password
   WORDPRESS_DB_NAME=your_database
   WORDPRESS_PATH=/var/www/html
   PLUGIN_NAME=your_plugin_name
   ```

3. **Build and Start the Containers:**

   Run the following command to build and start all the services defined in the `docker-compose.yml`:

   ```bash
   docker-compose up -d
   ```

4. **Access the Services:**

   - **WordPress:** Open your browser and go to [http://localhost:8080](http://localhost:8080)
   - **phpMyAdmin:** Open your browser and go to [http://localhost:8181](http://localhost:8181)
   - **WP-CLI:** You can use the `wd_wpcli` container to run WP-CLI commands:

     ```bash
     docker exec -it wd_wpcli wp --info
     ```

## Container Overview

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

## Development

To develop your WordPress plugin:

1. Place your plugin source code in the `./work_dir/plugins/${PLUGIN_NAME}` directory.
2. The plugin will be automatically synced and available in the WordPress installation.

## Stopping the Containers

To stop the containers, run:

```bash
docker-compose down
```

This will stop and remove the containers, but your data will be preserved in the Docker volumes.

## Troubleshooting

- If you encounter any issues, try rebuilding the containers:

  ```bash
  docker-compose up -d --build
  ```

- Check the logs for any errors:

  ```bash
  docker-compose logs -f
  ```

## License

This project is licensed under the MIT License.
