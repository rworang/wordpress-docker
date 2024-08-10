# Intent of Use

The repository is set up as a template, this makes it easy to copy the repository and automatically create a private repository without any commit history. This can then be customized to a users needs.

## Project setup

**Develop profile**<br>
To develop plugins the `work_dir/plugins` directory is setup, for this directory there is a watcher in the `docker-compose.yml`. This watcher will only run if the `develop` profile is used.

<sup>_\* Note: Maybe look into linking WordPress debug env options to the develop profile, not necessary but note-worthy._</sup>

**Adding your plugin**<br>
There are multiple ways to add your plugin, the simplest way is to create a symlink. <sup>[[1](https://www.man7.org/linux/man-pages/man1/ln.1.html)][[2](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.4)]</sup><br> The plugins should be automatically loaded but make sure that the **`name`** of the **`directory`** for the **`plugin`** is the same as the `.env` **`PLUGIN_NAME`** value. The format of the directory name should also not contains spaces or capitals.

The locations and use of `PLUGIN_NAME` key are these:

```bash
- (example).env
  # This is where the environment key is set.

- install-plugins.sh
  # In install plugins it is more used as a placeholder for reference.
  # This could maybe also be used to test install and get debug logs via wp-cli.
  if ! wp plugin is-installed ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"; then
      wp plugin install ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"
  fi

- activate-plugins.sh
  # In activate plugins it is also used as a reference but this is to
  # be uncommented if you want the plugin to be activated on first start.
  if ! wp plugin is-active ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"; then
      wp plugin activate ${PLUGIN_NAME} --path="${WORDPRESS_PATH}"
  fi

  # When activating multiple plugins it is preferred to use it the same as in
  # install-plugins.sh.
  wp plugin activate plugin-one plugin-two plugin-three --path="${WORDPRESS_PATH}"
```

_\* The if statements are not necessary as wp-cli is fine with it, I'll have to remove those during next cleanup._
