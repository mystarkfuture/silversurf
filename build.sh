#!/bin/bash

set -ouex pipefail

# Copy fsroot/ root to /
rsync -rvK /tmp/ctx/fsroot/ /

chmod +x /tmp/ctx/build_files/*

/tmp/ctx/build_files/copr.sh
/tmp/ctx/build_files/packages.sh
/tmp/ctx/build_files/brew.sh
/tmp/ctx/build_files/systemd.sh
/tmp/ctx/build_files/mods.sh
