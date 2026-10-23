{ host, ... }:
{
  networking.hostName = host.hostName;
  networking.networkmanager.enable = true;
}
