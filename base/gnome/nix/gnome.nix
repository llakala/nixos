{
  pkgs,
  lib,
  config,
  hostVars,
  ...
}:

{

    services.xserver =
    {
      enable = true;
      excludePackages = with pkgs; [xterm]; # Remove weird xterm

      # Enable Gnome
      desktopManager.gnome.enable = true;
      xkb =
      {
        layout = "us";
        variant = "";
      };
    };


    services.gnome =
    {
      core-utilities.enable = false;
    };

    environment.gnome.excludePackages = with pkgs;
    [
      gnome-tour
    ];




    # Add some actually useful packages back
    environment.systemPackages = with pkgs;
    [
      gnome-extension-manager
    ]
    ++
    (with pkgs.gnome;
    [
      gnome-tweaks
      nautilus
      gnome-terminal
      gnome-disk-utility
      gnome-boxes
      resources
    ]
    );
}
