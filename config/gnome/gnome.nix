{ pkgs, lib, ... }:

{
  features.desktop = "gnome"; # If we ever stop using Gnome, change this
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
    loupe # Image viewer
    totem # Video viewer
    adwaita-icon-theme
  ];

  features.imageViewer = "loupe";
  features.videoViewer = "totem";

  environment.shellAliases.logout = "kill -9 -1"; # Logout of gnome, very helpful for applying changes to `environment.variables`
}
