# Spoolman Ingress HA Add-on
![Version][version]
![Spoolman-update-shield]

![Supports amd64 Architecture][amd64-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports armv7 Architecture][Spoolman-armv7-shield]

## About
This add-on is based on [Spoolman](https://github.com/Donkie/Spoolman).

This add-on has Ingress support, allowing Spoolman to appear in the Home Assistant sidebar.

For the non-ingress version (direct IP access), see the [Spoolman add-on](https://github.com/bytenoodle/hassioaddon/tree/main/spoolman).

Ingress support thanks to [@dmuth23](https://github.com/dmuth23)


## Notes
1. **Ingress**
   - Spoolman is accessible via the Home Assistant sidebar.
   - No direct port access is available in this version. Use the [non-ingress version](https://github.com/bytenoodle/hassioaddon/tree/main/spoolman) if you need direct IP access (e.g. for Bambu Lab printer integration).

2. **Timezone**
   - The add-on automatically uses the Home Assistant system timezone.
   - No manual timezone configuration is required.  
   - Default fallback: `Europe/Stockholm`.

3. **Data directories**
   - `addon_config/<slug>/` → main add-on data, logs, and backups.  
     - `<slug>` is the add-on folder name automatically created by Home Assistant, e.g., `20c49e40_spoolman_ingress`.  
   - The add-on automatically creates the following subdirectories inside this folder:
     - `backups/` → backup storage
     - `logs/` → log files
     - `cache/` → temporary cache files
   - All directories have correct permissions for the Spoolman process.  
   - **Note:** `/config` refers to the main Home Assistant configuration path inside the container, but all add-on files live under `addon_config/<slug>/`.

4. **Version numbering**
   - Using **x.x.x-x-ingress** format.  
   - The first three numbers match the official Spoolman version (e.g., `0.23.1`).  
   - The number after the first dash (`-X`) is for changes specific to this Home Assistant add-on (e.g., `0.23.1-0-ingress`).  

5. **External DB Sync & Backups**
   - The add-on automatically syncs filaments and materials from the external SpoolmanDB.  
   - Automatic database backups are scheduled for midnight.  
   - No configuration is required; everything runs in the background.

## Known issues
- None so far.

## Installation
1. [Add the repository][repository] to your Home Assistant add-ons.  
2. Install the **Spoolman Ingress** add-on.  
3. Start the add-on.  
4. Access Spoolman via the sidebar in Home Assistant.
   - If Spoolman does not appear in the sidebar, go to **Settings → Add-ons → Spoolman Ingress** and enable **Show in sidebar**.

## Troubleshooting

| Problem | Possible cause | Solution |
|---------|----------------|----------|
| **Add-on not starting** | nginx failed to start | Check the add-on logs for nginx errors and restart the add-on. |
| **Sidebar not loading** | Ingress URL could not be determined | Check the add-on logs for `[WARN] Could not determine ingress URL` and restart the add-on. |
| **Time incorrect in logs** | Host timezone misconfigured | Ensure Home Assistant system timezone is correct in **Settings → System → Time & Date**. |
| **Database not updating** | Corrupted SQLite database | Backup and remove `/config/spoolman.db`, then restart the add-on to recreate the database. |

## Support
- If you encounter any issues, please open an issue on the [Bytenoodle/hassioaddon GitHub repository](https://github.com/bytenoodle/hassioaddon/issues).  
- Include your add-on logs and a brief description of the problem.  
- This helps to diagnose and fix problems faster.

## Screenshot

![Preview][preview]

<!--
Assets
-->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[Spoolman-armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[version]: https://img.shields.io/badge/version-v0.23.1--0--ingress-blue.svg
[Spoolman-update-shield]: https://img.shields.io/badge/Updated%20on-2026--06--11-blue.svg
[repository]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/bytenoodle/hassioaddon
[preview]: https://raw.githubusercontent.com/bytenoodle/hassioaddon/refs/heads/main/spoolman-ingress/preview.png
