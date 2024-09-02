{ lib, ... }:

{

  programs.bat =
  {
    enable = true;
  };

  home.shellAliases.cat = "bat";

  home.activation.batCache = lib.mkForce ""; # Until https://github.com/nix-community/home-manager/issues/5481 is fixed
}