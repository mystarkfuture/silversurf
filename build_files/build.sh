#!/bin/bash

set -ouex pipefail

# copy fsroot content (etc,usr) to container root
rsync -rvK /ctx/fsroot/ /

/ctx/build_files/copr-repos.sh
/ctx/build_files/packages.sh
/ctx/build_files/brew.sh
/ctx/build_files/systemd.sh
/ctx/build_files/etc-mods.sh