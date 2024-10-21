#!/bin/bash

set -ouex pipefail

# systemd units
systemctl enable podman.socket
systemctl enable check-sb-key.service
systemctl enable system-setup.service

# # start these after first boot - fsroot/usr/libexec/firstboot.sh
# systemctl enable brew-setup.service
# systemctl enable brew-upgrade.timer
# systemctl enable brew-update.timer