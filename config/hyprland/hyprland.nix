{ pkgs, lib, ... }:

{
  programs.hyprland =
  {
    enable = true;
    withUWSM = true;
  };

  hm.xdg.portal.extraPortals = lib.singleton pkgs.xdg-desktop-portal-hyprland;

  environment.systemPackages = with pkgs;
  [
    waybar
    dunst
    rofi-wayland
    networkmanagerapplet
  ];

  hm.xdg.configFile."hypr/hyprland.conf" =
  {
    source = ./hyprland.hypr.conf;
    force = true;
  };
}