{ inputs, pkgs, lib, ... }:

{
  # TODO: BRING BACK WHEN I SYNC SUBSTITUTION AND FORK
  # nix.package = inputs.nixReadline.packages.${pkgs.system}.default;

  nix.settings = # My custom binary cache for recompiled nix
  {
    substituters = lib.singleton "https://nix-readline.cachix.org";
    trusted-public-keys = lib.singleton "nix-readline.cachix.org-1:SThCd1uenyO4i3ey7BED/436oagSEfJe3YSD4fE9cqs=";
  };


  hm.programs.readline =
  {
    enable = true;

    bindings =
    {
      "\\t" = "menu-complete";
      "\\e[Z" = "menu-complete-backward";
      "\\C-w" = "backward-kill-word";
    };

    variables =
    {
      editing-mode = "vi";
      show-mode-in-prompt = true;

      enable-bracketed-paste = true;
    };
  };
}
