#!/bin/bash

# Check if it's the first boot
if [ ! -f /etc/.firstboot ]; then
    # Create a flag file to indicate the first boot has been completed
    touch /etc/.firstboot

    # Enable brew services
    systemctl enable brew-setup.service
    systemctl enable brew-upgrade.timer
    systemctl enable brew-update.timer
fi
