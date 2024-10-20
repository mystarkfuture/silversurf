#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# Install HomeBrew ---------------------------------------------
# Convince the installer we are in CI
touch /.dockerenv

# Make these so script will work
mkdir -p /var/home
mkdir -p /var/roothome

# essentials for homebrew
rpm-ostree install gcc
rpm-ostree install g++
rpm-ostree install make
rpm-ostree install automake
rpm-ostree install autoconf
rpm-ostree install glibc-devel
rpm-ostree install libstdc++-devel
rpm-ostree install binutils
rpm-ostree install kernel-devel

# Brew Install Script
curl -Lo /tmp/brew-install https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
chmod +x /tmp/brew-install
/tmp/brew-install
tar --zstd -cvf /usr/share/homebrew.tar.zst /home/linuxbrew/.linuxbrew

# Install HomeBrew ---------------------------------------------

# COPR repos
curl -Lo /etc/yum.repos.d/_copr_robot-veracrypt-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/robot/veracrypt/repo/fedora-"${RELEASE}"/robot-veracrypt-fedora-"${RELEASE}".repo
curl -Lo /etc/yum.repos.d/_copr_che-nerd-fonts-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/fedora-"${RELEASE}"/che-nerd-fonts-fedora-"${RELEASE}".repo


# this installs a package from fedora repos
# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# printer / scanner utils
rpm-ostree install epson-inkjet-printer-escpr
rpm-ostree install epson-inkjet-printer-escpr2
rpm-ostree install printer-driver-brlaser
rpm-ostree install simple-scan
rpm-ostree install foo2zjs
rpm-ostree install hplip
rpm-ostree install firewall-config

# utilities
rpm-ostree install p7zip
rpm-ostree install p7zip-plugins
rpm-ostree install wl-clipboard
rpm-ostree install wireguard-tools
rpm-ostree install veracrypt
rpm-ostree install solaar
rpm-ostree install git-credential-libsecret
rpm-ostree install input-remapper
rpm-ostree install lm_sensors
rpm-ostree install rclone
rpm-ostree install restic
rpm-ostree install setools-console
rpm-ostree install openssh-askpass

# fonts
rpm-ostree install opendyslexic-fonts

# DE tools
rpm-ostree install gnome-shell-extension-system-monitor
rpm-ostree install gnome-shell-extension-appindicator
rpm-ostree install gnome-shell-extension-blur-my-shell
rpm-ostree install gnome-shell-extension-caffeine
rpm-ostree install ulauncher

# Development
rpm-ostree install code
rpm-ostree install python3-pip
rpm-ostree install libxcrypt-compat
rpm-ostree override remove toolbox --install distrobox

# Terminal tools
rpm-ostree install zoxide
rpm-ostree install stow
rpm-ostree install git
rpm-ostree install zsh
rpm-ostree install fastfetch

# Cleanup unnecessary apps
rpm-ostree override remove gnome-extensions-app
rpm-ostree override remove gnome-tour
rpm-ostree override remove firefox-langpacks
rpm-ostree override remove firefox
# rpm-ostree override remove gnome-software-rpm-ostree
# rpm-ostree override remove ublue-os-update-services
# rpm-ostree override remove podman-docker

# systemd units
systemctl enable podman.socket
systemctl enable brew-setup.service
systemctl enable brew-upgrade.timer
systemctl enable brew-update.timer

# modifications to /etc/
# ZRAM conf
cp /usr/lib/systemd/zram-generator.conf /usr/lib/systemd/zram-generator.conf.bkp
echo -e "\n# Default algorithm changed from lzo-rle to zstd \ncompression-algorithm = zstd" | tee -a /usr/lib/systemd/zram-generator.conf
echo -e "# zram conf copied from PopOS\nvm.swappiness = 180\nvm.watermark_boost_factor = 0\nvm.watermark_scale_factor = 125\nvm.page-cluster = 0" | tee -a /etc/sysctl.d/99-vm-zram-parameters.conf

# WiFi configuration
echo -e "[connection]\nwifi.powersave=2\n" | tee -a /etc/NetworkManager/conf.d/wifi-powersave-off.conf
