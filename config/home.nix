{
  inputs,
  lib,
  pkgs,
  ...
}:

{

  imports =
  [
  ];

  nixpkgs.config.allowUnfree = true;

  home =
  {
    username = "username";
    homeDirectory = "/home/username";
    stateVersion = "23.11";
  };


  home.packages =
  with pkgs;
  [
    firefox
    vscode
    usbimager
    pika-backup
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
