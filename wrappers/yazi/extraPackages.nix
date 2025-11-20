{ inputs }:

let
  inherit (inputs.nixpkgs) pkgs;
in with pkgs; [
  jq
  poppler-utils
  _7zz
  ffmpeg
  fd
  ripgrep
  fzf
  zoxide
  imagemagick
  chafa
  resvg
]
