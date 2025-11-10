{ inputs }:
let
  inherit (inputs.nixpkgs) pkgs;
in
"${pkgs.kitty-themes}/share/kitty-themes/themes/Kaolin_Aurora.conf"
