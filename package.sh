#!/bin/sh

ACAP_ARCH=armv7hf
ACAP_VERSION=3.1
TAILSCALE_VERSION=1.76.6

MAJOR_VERSION=$(echo $TAILSCALE_VERSION | cut -d. -f1)
MINOR_VERSION=$(echo $TAILSCALE_VERSION | cut -d. -f2)
MICRO_VERSION=$(echo $TAILSCALE_VERSION | cut -d. -f3)

sed -i '' \
    -e "s/APPMAJORVERSION=\"[0-9]*\"/APPMAJORVERSION=\"${MAJOR_VERSION}\"/" \
    -e "s/APPMINORVERSION=\"[0-9]*\"/APPMINORVERSION=\"${MINOR_VERSION}\"/" \
    -e "s/APPMICROVERSION=\"[0-9]*\"/APPMICROVERSION=\"${MICRO_VERSION}\"/" \
    app/package.conf

curl --remote-name --output-dir app \
    https://raw.githubusercontent.com/tailscale/tailscale/refs/tags/v${TAILSCALE_VERSION}/LICENSE

case $ACAP_ARCH in
    armv7hf) TAILSCALE_FILENAME=tailscale_${TAILSCALE_VERSION}_arm   ;;
    aarch64) TAILSCALE_FILENAME=tailscale_${TAILSCALE_VERSION}_arm64 ;;
esac

curl "https://pkgs.tailscale.com/stable/${TAILSCALE_FILENAME}.tgz" \
    | tar --extract --strip-components=1 --directory app/lib "${TAILSCALE_FILENAME}/tailscaled"

docker run --rm --volume "$PWD/app:/opt/app" \
    axisecp/acap-sdk:${ACAP_VERSION}-${ACAP_ARCH} \
    sh -c ". /opt/axis/acapsdk/environment-setup* && create-package.sh"

rm -f app/tailscaled
