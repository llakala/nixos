{ lib, hostVars, ... }:

{
  programs.dconf.profiles.gdm.databases = lib.singleton # dconf options from nixos, NOT home-manager
  {
    settings."org/gnome/desktop/interface" = # Scaling on login screen
    {
      scaling-factor = lib.gvariant.mkUint32 hostVars.scalingFactor;
    };
  };

  hm.dconf.settings."org/gnome/desktop/interface" =
  {
    scaling-factor = lib.gvariant.mkUint32 hostVars.scalingFactor;
  };

}