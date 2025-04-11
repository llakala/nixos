{ pkgs, pkgs-unstable, ... }:

let
  stablePackages = with pkgs;
  [
    gparted
    teams-for-linux
    filezilla
    moonlight-qt
    spotify

    # Internet radio
    shortwave
    libreoffice
    prismlauncher
    mediawriter

    # Image editing, currently broken
    # krita
  ];

  unstablePackages = with pkgs-unstable;
  [
  ];


in
{
  environment.systemPackages = stablePackages ++ unstablePackages;
}
