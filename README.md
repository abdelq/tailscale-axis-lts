# Tailscale for AXIS OS LTS

ACAP to install Tailscale on an older generation Axis surveillance camera.

## Building

Assuming all dependencies are installed, it's possible to just run `package.sh` to generate the `.eap` file.

On your first run, you will need to add a valid `authkey.txt` that you can generate [in the admin panel](https://login.tailscale.com/admin/settings/keys).

## Improvements

- [ ] Writing errors to the syslog \
      Only errors to avoid wear on the device's flash drive.
      Either by attempting to tweak `APPOPTS` to pipe to `logger` or by updating the C wrapper.
- [ ] Adding a settings page \
      It should be possible to update `/etc/apache2/conf.d/vhosts/all/urls_tailscaled.conf` as
      part of a post-install script to use Apache as a reverse proxy for the Tailscale web server.
      The settings page in `app/html/index.html` can then have an `<iframe>` that refers to that page.
- [ ] Installing and using Tailscale's certificates
- [ ] Automatically removing the authentication key once used
