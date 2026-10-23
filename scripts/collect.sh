#!/usr/bin/env bash
# Collects the machine data this configuration still needs. Read-only: it
# mounts, formats and installs nothing.
#
# Usage, from the NixOS installer with the system partitions mounted at /mnt
# and the data partition NOT mounted:
#   sudo ./scripts/collect.sh /mnt
set -euo pipefail

root="${1:?usage: collect.sh <root>, e.g. /mnt}"
out="machine"
mkdir -p "$out"

nixos-generate-config --root "$root" --show-hardware-config > "$out/hardware-configuration.nix"
nixos-version > "$out/nixos-version.txt"
if [ -d /sys/firmware/efi ]; then echo uefi; else echo bios; fi > "$out/boot-mode.txt"
lsblk -o NAME,SIZE,FSTYPE,LABEL,UUID,MOUNTPOINTS > "$out/disks.txt"
lspci -nnk > "$out/pci.txt"

echo "Written to $out/"
