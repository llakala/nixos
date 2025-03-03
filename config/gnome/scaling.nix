{ lib, config, ... }:

{
  # dconf options from nixos, NOT home-manager. Makes scaling also apply to login screen
  programs.dconf.profiles.gdm.databases = lib.singleton
  {
    settings."org/gnome/desktop/interface" =
    {
      scaling-factor = lib.gvariant.mkUint32 config.hostVars.scalingFactor;
    };
  };
}
