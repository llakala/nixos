{ lib, ... }:

{


  programs.dconf.profiles.gdm.database =
  [{
    settings."org/gnome/desktop/interface".scaling-factor = lib.gvariant.mkUint32 2;
  }];


}