{ host, ... }:
{
  # Survives reinstalls; must not appear in hardware-configuration.nix as well.
  fileSystems.${host.data.mountPoint} = {
    device = "/dev/disk/by-uuid/${host.data.uuid}";
    fsType = "ext4";
  };
}
