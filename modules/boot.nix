{ host, ... }:
{
  assertions = [
    {
      assertion = host.uefi;
      message = "systemd-boot requires UEFI; this machine boots in legacy BIOS mode.";
    }
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
