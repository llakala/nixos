{ pkgs, lib, ... }:

{
  # If we ever stop using Gnome, change this
  features.desktop = "gnome";
  services.xserver =
  {
    enable = true;

    # Remove weird xterm
    excludePackages = with pkgs; [xterm];

    # Enable Gnome
    desktopManager.gnome.enable = true;
  };


  services.gnome =
  {
    core-utilities.enable = false;

    # Disable Events and Tasks Reminders from always running in the background
    evolution-data-server.enable = lib.mkForce false;

    # Nautilus previewing
    sushi.enable = true;
  };

  environment.gnome.excludePackages = with pkgs;
  [
    gnome-tour
  ];

  programs.gnome-disks.enable = true;

  # Add some actually useful packages back
  environment.systemPackages = with pkgs;
  [
    gnome-extension-manager
    video-trimmer
    gnome-tweaks
    gnome-terminal
    dconf-editor
    baobab
    adwaita-icon-theme
  ];

  # Logout of gnome, very helpful for applying changes to `environment.variables`
  environment.shellAliases.logout = "kill -9 -1";
}
