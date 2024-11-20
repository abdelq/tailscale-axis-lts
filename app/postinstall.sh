#!/bin/sh

echo -e 'net.ipv4.ip_forward = 1\nnet.ipv6.conf.all.forwarding = 1' > /etc/sysctl.d/99-tailscale.conf
sysctl -p /etc/sysctl.d/99-tailscale.conf
