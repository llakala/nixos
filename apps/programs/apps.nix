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
    obsidian # Notes
    gnome-feeds # rss feeds
    krita # Image editing
  ];

  unstablePackages = with pkgs-unstable;
  [
    modrinth-app
  ];


in
{
  environment.systemPackages = stablePackages ++ unstablePackages;
}
