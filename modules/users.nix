{ host, ... }:
{
  # No password here: it is set with `passwd` after install, so no secret is versioned.
  users.users.${host.user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
