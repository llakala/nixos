{ pkgs, lib, config, ... }:
{
    services.xserver = {
      enable = true;
      excludePackages = with pkgs; [xterm]; # Remove weird xterm

      # Enable Gnome
      desktopManager.gnome.enable = true;

      displayManager = {
        gdm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "username";
      };
      layout = "us";
      xkbVariant = "";
    };

    # Disable all default gnome apps
    services.gnome.core-utilities.enable = false;

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
      dconf-editor
      gnome-disk-utility
    ]);

    # Workaround for GNOME autologin
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
}
