{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    resources
    filezilla
    spotify
    shortwave # Internet radio
    mediawriter
    # krita # Image editing, currently broken
  ];
}
