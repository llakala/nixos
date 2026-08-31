{ pkgs, ... }:

let
  layoutName = "custom";
in {
  services.xserver.xkb.extraLayouts.${layoutName} = {
    description = ''
      My custom layout, where:
      - Caps is Esc, and Esc does nothing
      - Right Alt is Compose
    '';
    languages = [ "eng" ];

    # The layout name doesn't matter, it can be anything
    symbolsFile = pkgs.writeText layoutName ''
      xkb_symbols
      {
        include "us(basic)"
        include "compose(ralt)"

        key <CAPS> {[ Escape ]};
        key <ESC> {[ VoidSymbol ]};
      };
    '';
  };

  # Don't forget this - it actually makes the layout apply
  services.xserver.xkb.layout = layoutName;
}
