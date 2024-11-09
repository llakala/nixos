{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    gparted
    filezilla
    moonlight-qt
    viewnior # image viewer
    spotify
    shortwave # Internet radio
    obsidian # Notes
    gnome-feeds # rss feeds
  ];
}
