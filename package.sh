#!/bin/sh

ACAP_ARCH=armv7hf
ACAP_VERSION=3.1
TAILSCALE_VERSION=1.76.6

curl --remote-name --output-dir app \
    https://raw.githubusercontent.com/tailscale/tailscale/refs/tags/v${TAILSCALE_VERSION}/LICENSE

case $ACAP_ARCH in
    armv7hf) TAILSCALE_FILENAME=tailscale_${TAILSCALE_VERSION}_arm   ;;
    aarch64) TAILSCALE_FILENAME=tailscale_${TAILSCALE_VERSION}_arm64 ;;
esac

curl "https://pkgs.tailscale.com/stable/${TAILSCALE_FILENAME}.tgz" \
    | tar --extract --strip-components=1 --directory app "${TAILSCALE_FILENAME}/tailscaled"

docker run --rm --volume "$PWD/app:/opt/app" \
    axisecp/acap-sdk:${ACAP_VERSION}-${ACAP_ARCH} \
    sh -c ". /opt/axis/acapsdk/environment-setup* && create-package.sh"
