# Tailscale for AXIS OS LTS

ACAP to install Tailscale on an older generation Axis surveillance camera.

## Building

Assuming all dependencies are installed, it's possible to just run `package.sh` to generate the `.eap` file.

On your first run, you will need to add a valid `authkey.txt` that you can generate [in the admin panel](https://login.tailscale.com/admin/settings/keys).

## Improvements

- [ ] Automatically removing the authentication key once used
- [ ] Installing and using Tailscale's certificates
