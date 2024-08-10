# Including or excluding the build process

Need to think about including or excluding the build process.

Currently the build step is removed, there some ups and downs to either option, which need to be considered.

## Excluding

- \+ Always runs from the latest build of wordpress:cli
- \+ Speeds up startup
- \- It has to run the setup_wpcli.sh every docker-compose up

## Including

- \~ Runs on the customized build of wordpress:cli which probably is also latest, but if the image is not rebuilt it will stay the version it was at build.
- \- Adds another step in the process which complicates things
- \+ By building the image, the setup_wpcli.sh should only have to be run once

# After using container for a bit

I do think it is better to include an image build step, this way the OS can be pre-setup simpler without causing permission issues. When using `user:root` in the docker-compose wpcli will make things work as long as commands that need to be su'd are run with the right user.

The problem with this is that the wpcli container after everything still runs as the root user, this causes permission issues on the directories it creates. It is easier to just build the image, than to try to figure out what permissions need to be used. By using the build `Dockerfile` we can switch USER easier and make sure that at the end of it the right permissions are set and the proper users are used when needed.
