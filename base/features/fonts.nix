{ pkgs, lib, ... }:
let
  myNerdFonts =
  [
    "NerdFontsSymbolsOnly"
  ];
in
{
  fonts =
  {
    enableDefaultPackages = true;

    packages = with pkgs;
    [
      monocraft
      (nerdfonts.override { fonts = myNerdFonts; })
    ];

    fontconfig =
    {
      enable = true;
      defaultFonts.monospace = lib.singleton "Monocraft";
    };
  };
}
