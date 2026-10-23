{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs =
    { nixpkgs, ... }:
    let
      host = import ./host.nix;
    in
    {
      nixosConfigurations.${host.hostName} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit host; };
        modules = [ ./configuration.nix ];
      };
    };
}
