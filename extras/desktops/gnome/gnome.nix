{ pkgs, lib, ... }:

{
  services.desktopManager.gnome.enable = true;

  services.gnome =
  {
    core-apps.enable = false;
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
  ];

  environment.shellAliases.logout = "kill -9 -1"; # Logout of gnome, very helpful for applying changes to `environment.variables`
}
