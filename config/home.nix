{
  inputs,
  lib,
  pkgs,
  ...
}:

{

  imports =
  [
  ];

  nixpkgs =
  {
    # You can add overlays here
    overlays =
    [];
    # Configure your nixpkgs instance
    config =
    {
      allowUnfree = true;
    };
  };

  home =
  {
    username = "username";
    homeDirectory = "/home/username";
  };


  home.packages =
  with pkgs;
  [
    firefox
    vscode
    usbimager
    pika-backup
  ];

  programs.git = {
    enable = true;
    userName = "Ella Kramer";
    userEmail = "ellakalle6@gmail.com";
  };

  dconf.settings =
  {
    "org/gnome/desktop/interface" =
    {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/wm/preferences" =
    {
      num-workspaces = 1;
    };

    "org/gnome/desktop/peripherals/mouse" =
    {
      accel-profile = "flat";
    };

    "org/gnome/mutter" =
    {
      edge-tiling = true;
      dynamic-workspaces = false;
    };

    "org/gnome/shell" =
    {
      favorite-apps = [ "firefox.desktop" "code.desktop" "org.gnome.Terminal.desktop" "org.gnome.Nautilus.desktop"];
    };
  };


  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
