{
  pkgs,
  lib,
  ...
}:

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
  ]
  ++
  (with pkgs.gnome;
  [
    gnome-tweaks
    gnome-terminal
    gnome-disk-utility
    dconf-editor
    baobab
  ]
  );

  environment.shellAliases.logout = "kill -9 -1"; # Logout of gnome, very helpful for applying changes to `environment.variables`
}
