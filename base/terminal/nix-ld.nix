{ pkgs, ... }:
{
  # Enable nix ld
  programs.nix-ld =
  {
    enable = true;
  };
}