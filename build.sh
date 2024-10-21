#!/bin/bash

set -ouex pipefail

# Copy fsroot/ root to /
rsync -rvK /ctx/fsroot/ /
chmod +x /ctx/build_files/*

/ctx/buikd_files/copr.sh
/ctx/buikd_files/packages.sh
/ctx/buikd_files/brew.sh
/ctx/buikd_files/systemd.sh
/ctx/buikd_files/mods.sh
