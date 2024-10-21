#!/bin/bash

set -ouex pipefail

# systemd units
systemctl enable podman.socket
systemctl enable check-sb-key.service

# # start these after first boot
# systemctl enable brew-setup.service
# systemctl enable brew-upgrade.timer
# systemctl enable brew-update.timer