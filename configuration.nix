{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/locale.nix
    ./modules/desktop.nix
    ./modules/packages.nix
    ./modules/storage.nix
    ./modules/system.nix
  ];
}
