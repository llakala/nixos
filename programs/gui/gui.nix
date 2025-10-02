{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    resources
    filezilla
    shortwave # Internet radio
    mediawriter
    # krita # Image editing, currently broken
  ];
}
