{ lib, pkgs, ... }:

let
  layoutName = "custom";
in {
  services.xserver.xkb.extraLayouts.${layoutName} = {
    description = "Custom layout where CAPS is Escape, and ESC does nothing";
    languages = lib.singleton "eng";

    # The layout name doesn't matter, it can be anything
    symbolsFile = pkgs.writeText layoutName ''
      xkb_symbols
      {
        include "us(basic)"

        key <CAPS> {[ Escape ]};
        key <ESC> {[ VoidSymbol ]};
      };
    '';
  };

  # Don't forget this - it actually makes the layout apply
  services.xserver.xkb.layout = layoutName;
}
