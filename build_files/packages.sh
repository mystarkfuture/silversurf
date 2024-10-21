#!/bin/bash

set -ouex pipefail

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

# Cleanup unnecessary apps
rpm-ostree override remove gnome-extensions-app
rpm-ostree override remove gnome-tour
rpm-ostree override remove firefox-langpacks
rpm-ostree override remove firefox

# # use these to disable system update modules
# rpm-ostree override remove gnome-software-rpm-ostree
# rpm-ostree override remove ublue-os-update-services
# rpm-ostree override remove podman-docker