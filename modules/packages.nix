{ pkgs, ... }:
{
  # Flakes read their source from git.
  environment.systemPackages = [ pkgs.git ];
}
