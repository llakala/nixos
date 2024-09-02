{ lib, pkgs, ... }:

{

  programs.bat =
  {
    enable = true;

    extraPackages = with pkgs.bat-extras;
    [
      batman # Prettier version of man
    ];
  };

  home.shellAliases.cat = "bat";
  home.shellAliases.man = "batman";

  home.activation.batCache = lib.mkForce ""; # Until https://github.com/nix-community/home-manager/issues/5481 is fixed
}