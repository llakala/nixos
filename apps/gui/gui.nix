{ pkgs, pkgs-unstable, ... }:

let
  stablePackages = with pkgs;
  [
    gparted
    teams-for-linux
    filezilla
    moonlight-qt
    spotify
    shortwave # Internet radio
    libreoffice
    prismlauncher
    mediawriter
    # krita # Image editing, currently broken
  ];

  unstablePackages = with pkgs-unstable;
  [
  ];


in
{
  environment.systemPackages = stablePackages ++ unstablePackages;
}
