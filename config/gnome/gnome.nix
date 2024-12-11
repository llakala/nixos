{ pkgs, lib, ... }:

{
  services.xserver =
  {
    enable = true;
    excludePackages = with pkgs; [xterm]; # Remove weird xterm

    # Enable Gnome
    desktopManager.gnome.enable = true;
  };


  services.gnome =
  {
    core-utilities.enable = false;
    evolution-data-server.enable = lib.mkForce false; # Disable Events and Tasks Reminders from always running in the background
    sushi.enable = true; # Nautilus previewing
  };

  environment.gnome.excludePackages = with pkgs;
  [
    gnome-tour
  ];


  # Add some actually useful packages back
  environment.systemPackages = with pkgs;
  [
    gnome-extension-manager
    video-trimmer
    gnome-tweaks
    gnome-terminal
    gnome-disk-utility
    dconf-editor
    baobab # Disk Usage Analyzer

    totem # Video viewer
    loupe # Image viewer
  ];

  environment.shellAliases.logout = "kill -9 -1"; # Logout of gnome, very helpful for applying changes to `environment.variables`
}
