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
1. HOMEPAGE_ALLOWED_HOSTS
   - By default, this add-on uses a wildcard (*) for HOMEPAGE_ALLOWED_HOSTS.
   - This is safe for typical Home Assistant setups because the add-on runs locally in an isolated container and is not directly exposed to the Internet.
   - Security note: If you ever expose this container to external networks, using a wildcard may allow unwanted requests. In that case, it’s recommended to specify the allowed host(s) explicitly.
   - Future versions of this add-on may allow dynamic configuration of HOMEPAGE_ALLOWED_HOSTS via the add-on options to improve security for advanced setups.
   - More info here: https://gethomepage.dev/installation/#homepage_allowed_hosts
2. If you need to use /var/run/docker.sock (optional, for Docker integrations), make sure Protection Mode is disabled for this addon.
   - More info here about /var/run/docker.sock: https://gethomepage.dev/installation/#homepage_allowed_hosts


## Installation
1. [Add my add-ons repository][repository] to your Home Assistant addons.
2. Install this add-on.
3. Edit add-on config as needed. At the moment you can only change exposed port, which is 3000 by default.
4. If you need /var/run/docker.sock see notes above.
5. Start the add-on.
6. Done, enjoy!

## Edit Homepage Config Files
1. Use the File Editor add-on or connect to your Home Assistant via SFTP.
2. Navigate to the addon_config folder.
3. Open the folder for the Homepage add-on, e.g., xxxxxxx_homepage (xxxxxxx are random numbers).
4. The folder structure should look like: /addon_config/abcd123_homepage/.
5. Edit the configuration files for Homepage. For more information on Homepage configuration, see: https://gethomepage.dev/configs/

## Screenshot

![Preview][preview]

<!--
Assets
-->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg


[version]: https://img.shields.io/badge/version-v1.5.0-blue.svg
[production-ready]: https://img.shields.io/badge/Production%20ready-yes-green.svg

[repository]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/bytenoodle/hassioaddon
[preview]: https://raw.githubusercontent.com/gethomepage/homepage/refs/heads/dev/images/1.png
