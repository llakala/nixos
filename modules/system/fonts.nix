{ pkgs, ... }:

let
  myNerdFonts = with pkgs.nerd-fonts; [
    symbols-only
  ];

  myMonocraft = pkgs.monocraft.overrideAttrs (finalAttrs: {
    srcs = builtins.filter (src: src.name == "Monocraft-no-ligatures.ttc") finalAttrs.srcs;
  });
in {
  fonts = {
    enableDefaultPackages = true;

    packages = myNerdFonts ++ [ myMonocraft ];

    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Monocraft" ];
    };
  };
}
