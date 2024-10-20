#!/usr/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# # COPR repositories
# Add Staging repo
curl -Lo /etc/yum.repos.d/ublue-os-staging-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/ublue-os/staging/repo/fedora-"${RELEASE}"/ublue-os-staging-fedora-"${RELEASE}".repo

# Patched switcheroo
curl -Lo /etc/yum.repos.d/_copr_sentry-switcheroo-control_discrete.repo https://copr.fedorainfracloud.org/coprs/sentry/switcheroo-control_discrete/repo/fedora-"${RELEASE}"/sentry-switcheroo-control_discrete-fedora-"${RELEASE}".repo

# Patched shells
if [[ "${BASE_IMAGE_NAME}" = "silverblue" ]]; then
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
        gnome-shell
elif [[ "${BASE_IMAGE_NAME}" = "kinoite" && "${RELEASE}" -gt "39" ]]; then
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
        kf6-kio-doc \
        kf6-kio-widgets-libs \
        kf6-kio-core-libs \
        kf6-kio-widgets \
        kf6-kio-file-widgets \
        kf6-kio-core \
        kf6-kio-gui
elif [[ "${BASE_IMAGE_NAME}" = "kinoite" ]]; then
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
        kf5-kio-ntlm \
        kf5-kio-doc \
        kf5-kio-widgets-libs \
        kf5-kio-core-libs \
        kf5-kio-widgets \
        kf5-kio-file-widgets \
        kf5-kio-core \
        kf5-kio-gui
fi

# GNOME Triple Buffering
if [[ "${BASE_IMAGE_NAME}" = "silverblue" && "${RELEASE}" -gt "39" ]]; then
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
        mutter \
        mutter-common
fi

# Fix for ID in fwupd
if [[ "${RELEASE}" -gt "39" ]]; then
    rpm-ostree override replace \
        --experimental \
        --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
            fwupd \
            fwupd-plugin-flashrom \
            fwupd-plugin-modem-manager \
            fwupd-plugin-uefi-capsule-data
fi

# Switcheroo patch
rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:sentry:switcheroo-control_discrete \
        switcheroo-control

rm /etc/yum.repos.d/_copr_sentry-switcheroo-control_discrete.repo

# veracrypt
curl -Lo /etc/yum.repos.d/_copr_robot-veracrypt-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/robot/veracrypt/repo/fedora-"${RELEASE}"/robot-veracrypt-fedora-"${RELEASE}".repo

# nerd fonts
curl -Lo /etc/yum.repos.d/_copr_che-nerd-fonts-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/fedora-"${RELEASE}"/che-nerd-fonts-fedora-"${RELEASE}".repo
