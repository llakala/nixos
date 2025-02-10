{ lib, config, ... }:

{
  # dconf options from nixos, NOT home-manager
  programs.dconf.profiles.gdm.databases = lib.singleton
  {
    settings."org/gnome/desktop/interface" = # Scaling on login screen
    {
      scaling-factor = lib.gvariant.mkUint32 config.hostVars.scalingFactor;
    };
  };

  hm.dconf.settings."org/gnome/desktop/interface" =
  {
    scaling-factor = lib.gvariant.mkUint32 config.hostVars.scalingFactor;
  };

  # Delete monitors.xml contents since it overrides any declarative scaling settings
  hm.xdg.configFile."monitors.xml" =
  {
    text = "";
    force = true;
  };

}
