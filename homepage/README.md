# Homepage
![Version][version]
![Production ready][production-ready]
![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

## About
This addon is based on the [gethomepage/homepage](https://hub.docker.com/r/gethomepage/homepage/).

## Known issues
- None so far.

## Notes
- HOMEPAGE_ALLOWED_HOSTS got a wildcard (*) in the addon config.yaml or it would give a invalid host error so use this addon only on local network.
  More info here: https://gethomepage.dev/installation/#homepage_allowed_hosts

## Installation
1. [Add my add-ons repository][repository] to your Home Assistant addons.
2. Install this add-on.
3. Edit add-on config as needed. At the moment you can only change exposed port, which is 3000 by default.
4. Start the add-on.
5. Done, enjoy!

## Edit Homepage config files
1. Use the filebrowser addon or use sftp to your ha os.
2. Go into addon_config folder.
3. Go into xxxxxxx_homepage folder (xxxxxxx are random numbers).
4. So the folder structre looks like: /addon_config/abcd123_homepage/
5. Edit the configuration files for homepage (more info on Configuration for homepage: https://gethomepage.dev/configs/).

## Screenshot

![Preview][preview]

<!--
Assets
-->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg


[version]: https://img.shields.io/badge/Version-1.0.1-green
[production-ready]: https://img.shields.io/badge/Production%20ready-yes-green.svg

[repository]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/bytenoodle/hassioaddon
[preview]: https://raw.githubusercontent.com/gethomepage/homepage/refs/heads/dev/images/1.png
