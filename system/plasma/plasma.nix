{ lib, sources, baseVars, pkgs, ... }:

{
  features.desktop = "plasma"; # If we ever stop using KDE, change this
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = [ pkgs.kdePackages.okular ];

  # If you ever need to figure out the name, set this to an empty string and try
  # to rebuild - it'll fail and tell you the valid options
  services.displayManager.defaultSession = "plasma";

  hm.imports = lib.singleton "${sources.plasma-manager}/modules";
  hm.programs.plasma = {
    enable = true;
    immutableByDefault = true;
    # overrideConfig = true;
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
  };

  hm.gtk = {
    gtk2.configLocation = "${baseVars.homeDirectory}/.config/.gtkrc-2.0";
  };

  # Pretty orange tree :3
  hm.programs.plasma.workspace.wallpaper = ./wallpaper.png;

  # On by default - I'll save on my closure size
  services.orca.enable = false;
  services.speechd.enable = false;
}
