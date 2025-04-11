{ lib, pkgs, config, ... }:

let
  layoutName = "custom";
in
{
  # Changes to this seem to only apply after a gnome reboot
  services.xserver.xkb.extraLayouts.${layoutName} =
  {
    description = "Custom layout where CAPS is Escape, and ESC does nothing";
    languages = [ "eng" ];

    # This name doesn't matter, it can be anything
    symbolsFile = pkgs.writeText layoutName
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
  assert config.features.desktop == "gnome";
  {
    xkb-options =
    [
      "terminate:ctrl_alt_bksp"
      "lv3:rwin_switch"
    ];

    # Override gnome to use our custom layout, required
    sources = lib.singleton
    (
      lib.gvariant.mkTuple ["xkb" layoutName]
    );
  };

}
