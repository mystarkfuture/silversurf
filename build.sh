#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages
# COPR repos
curl -Lo /etc/yum.repos.d/_copr_robot-veracrypt-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/robot/veracrypt/repo/fedora-"${RELEASE}"/robot-veracrypt-fedora-"${RELEASE}".repo

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# printer / scanner utils
rpm-ostree install epson-inkjet-printer-escpr
rpm-ostree install epson-inkjet-printer-escpr2
rpm-ostree install printer-driver-brlaser
rpm-ostree install simple-scan
rpm-ostree install foo2zjs
rpm-ostree install hplip

# utilities
rpm-ostree install p7zip
rpm-ostree install p7zip-plugins
rpm-ostree install wl-clipboard
rpm-ostree install wireguard-tools
rpm-ostree install veracrypt

# DE tools
rpm-ostree install gnome-shell-extension-system-monitor
rpm-ostree install gnome-shell-extension-appindicator
rpm-ostree install gnome-shell-extension-blur-my-shell
rpm-ostree install ulauncher

# Development
rpm-ostree install code
rpm-ostree install make
rpm-ostree install python3-pip
rpm-ostree install libxcrypt-compat
rpm-ostree override remove toolbox --install distrobox

# Terminal tools
rpm-ostree install zoxide
rpm-ostree install stow
rpm-ostree install git
rpm-ostree install zsh
rpm-ostree install fastfetch

#### Example for enabling a System Unit File

systemctl enable podman.socket

# modifications to /etc/
# ZRAM conf
cp /usr/lib/systemd/zram-generator.conf /usr/lib/systemd/zram-generator.conf.bkp
echo -e "\n# Default algorithm changed from lzo-rle to zstd \ncompression-algorithm = zstd" | tee -a /usr/lib/systemd/zram-generator.conf
echo -e "# zram conf copied from PopOS\nvm.swappiness = 180\nvm.watermark_boost_factor = 0\nvm.watermark_scale_factor = 125\nvm.page-cluster = 0" | tee -a /etc/sysctl.d/99-vm-zram-parameters.conf

# WiFi configuration
echo -e "[connection]\nwifi.powersave=2\n" | tee -a /etc/NetworkManager/conf.d/wifi-powersave-off.conf
