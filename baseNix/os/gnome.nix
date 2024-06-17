{
  pkgs,
  lib,
  config,
  hostVars,
  ...
}:

{
    services.displayManager.autoLogin =
    {
      enable = true;
      user = hostVars.username;
    };
    services.xserver =
    {
      enable = true;
      excludePackages = with pkgs; [xterm]; # Remove weird xterm

      # Enable Gnome
      desktopManager.gnome.enable = true;

      displayManager.gdm.enable = true;
      xkb =
      {
        layout = "us";
        variant = "";
      };
    };


    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = with pkgs;
    [
      gnome-tour
    ];



    programs.dconf.enable = true;

    # Add some actually useful packages back
    environment.systemPackages = with pkgs;
    [
      gnome-extension-manager
    ] ++ (with pkgs.gnome;
    [
      gnome-tweaks
      nautilus
      gnome-terminal
      gnome-disk-utility
      resources
      gnome-keyring
    ]);

    # Workaround for GNOME autologin
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
}
