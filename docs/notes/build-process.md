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
