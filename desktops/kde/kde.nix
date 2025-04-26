{ lib, inputs, config, pkgs, ... }:
{
  features.desktop = "plasma"; # If we ever stop using KDE, change this
  services.desktopManager.plasma6.enable = true;

  # If you ever need to figure out the name, set this to an empty string and try
  # to rebuild - it'll fail and tell you the valid options
  services.displayManager.defaultSession = "plasma";

  hm.imports = lib.singleton inputs.plasma-manager.homeManagerModules.plasma-manager;
  hm.programs.plasma =
  {
    enable = true;
    immutableByDefault = true;
    # overrideConfig = true;
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
  };

  hm.gtk =
  {
    gtk2.configLocation = "${config.hostVars.homeDirectory}/.config/.gtkrc-2.0";
  };

  hm.programs.plasma.workspace.wallpaper =
    pkgs.kdePackages.plasma-workspace-wallpapers
    + "/share/wallpapers/ScarletTree/contents/images/5120x2880.png";
}
