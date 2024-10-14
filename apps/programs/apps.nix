{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    gparted
    filezilla
    moonlight-qt
    spotify
    shortwave # Internet radio
    obsidian # Notes
    gnome-feeds # rss feeds
  ];
}
