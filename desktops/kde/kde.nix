{ lib, inputs, config, ... }:
{
  services.desktopManager.plasma6.enable = true;

  hm.gtk =
  {
    gtk2.configLocation = "${config.hostVars.homeDirectory}/.config/.gtkrc-2.0";
  };

  hm.imports = lib.singleton inputs.plasma-manager.homeManagerModules.plasma-manager;

  hm.programs.plasma =
  {
    enable = true;
    immutableByDefault = true;
    # overrideConfig = true;
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
  };
}
