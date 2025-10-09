{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    resources
    shortwave # Internet radio
    mediawriter
    # krita # Image editing, currently broken
  ];
}
