#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# COPR repos
/tmp/copr.sh

# this installs a package from fedora repos
/tmp/packages.sh

# systemd units
/tmp/systemd-units.sh

# Customizations
/tmp/customizations.sh
