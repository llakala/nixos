{ pkgs, ... }:

let
  stablePackages = with pkgs;
  [
    gparted
    filezilla
    moonlight-qt
    spotify
    shortwave # Internet radio
    obsidian # Notes
    gnome-feeds # rss feeds
    krita # Image editing
  ];

  unstablePackages = with pkgs;
  [
    modrinth-app
  ];


in
{
  environment.systemPackages = stablePackages ++ unstablePackages;
}
