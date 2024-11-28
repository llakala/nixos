{ lib, pkgs, ... }:

let
  layoutName = "custom";
in
{
  services.xserver.xkb.extraLayouts.${layoutName} = # Changes to this seem to only apply after a gnome reboot
  {
    description = "Custom layout where CAPS is Escape, and ESC does nothing";
    languages = [ "eng" ];
    symbolsFile = pkgs.writeText layoutName # This name doesn't matter, it can be anything
    ''
      xkb_symbols
      {
        include "us(basic)"

        key <CAPS> {[ Escape ]};
        key <ESC> {[ VoidSymbol ]};
      };
    '';
  };

  hm.dconf.settings."org/gnome/desktop/input-sources" =
  {
    xkb-options =
    [
      "terminate:ctrl_alt_bksp"
      "lv3:rwin_switch"
    ];
    sources = lib.singleton # Override gnome to use our custom layout, required
    (
      lib.gvariant.mkTuple ["xkb" layoutName]
    );
  };

}
