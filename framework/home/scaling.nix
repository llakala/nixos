{ ... }:
{


  dconf.settings =
  {
    "org/gnome/desktop/interface" =
    {
       scaling-factor = lib.hm.gvariant.mkUint32 1;
    };


  };

}