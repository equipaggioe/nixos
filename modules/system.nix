{ host, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Upgrades and garbage collection stay manual: nothing is scheduled.

  system.stateVersion = host.stateVersion;
}
