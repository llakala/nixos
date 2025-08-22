{ lib, inputs, baseVars, ... }:

{
  features.desktop = "plasma"; # If we ever stop using KDE, change this
  services.desktopManager.plasma6.enable = true;

  # If you ever need to figure out the name, set this to an empty string and try
  # to rebuild - it'll fail and tell you the valid options
  services.displayManager.defaultSession = "plasma";

  hm.imports = lib.singleton inputs.plasma-manager.homeManagerModules.plasma-manager;
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
}
