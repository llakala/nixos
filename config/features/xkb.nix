{ lib, pkgs, config, ... }:

let
  layoutName = "custom";
in
{
  # Changes to this seem to only apply after a gnome reboot
  services.xserver.xkb.extraLayouts.${layoutName} =
  {
    description = "Custom layout where CAPS is Escape, and ESC does nothing";
    languages = lib.singleton "eng";
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

  # Don't forget this - it actually makes the layout apply.
  services.xserver.xkb.layout = layoutName;

  hm.dconf.settings."org/gnome/desktop/input-sources" =
  assert config.features.desktop == "gnome";
  {
    xkb-options =
    [
      "terminate:ctrl_alt_bksp"
      "lv3:rwin_switch"
    ];
  };

}
