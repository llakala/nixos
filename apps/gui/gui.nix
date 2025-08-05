{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    teams-for-linux
    resources
    filezilla
    moonlight-qt
    spotify
    shortwave # Internet radio
    mediawriter
    # krita # Image editing, currently broken
  ];
}
