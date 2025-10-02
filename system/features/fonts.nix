{ pkgs, lib, ... }:

let
  myNerdFonts = with pkgs.nerd-fonts; [
    symbols-only
  ];

  # Monocraft installs all versions by default, and I'm not sure of a way to select the
  # non-ligature version. Instead, I just override so only this version is installed.
  # I use 3.0, as 4.0 introduced bold and italics. I hate italics, and Kitty doesn't
  # provide a decent way to disable them. So, as a workaround, we just use 3.0
  noLigaMonocraft = pkgs.fetchurl {
    name = "Monocraft-no-ligatures.ttf";
    hash = "sha256-i41YIuc4hcnPMuJdS0peUTbWaOCmTCySLDzih4bJImM=";
    url = "https://github.com/IdreesInc/Monocraft/releases/download/v3.0/${noLigaMonocraft.name}";
  };

  myMonocraft = pkgs.monocraft.overrideAttrs {
    srcs = [ noLigaMonocraft ];
  };
in {
  fonts = {
    enableDefaultPackages = true;

    packages = myNerdFonts ++ lib.singleton myMonocraft;

    fontconfig = {
      enable = true;
      defaultFonts.monospace = lib.singleton "Monocraft";
    };
  };
}
