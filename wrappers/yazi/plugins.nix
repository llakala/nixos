{ inputs }:
let
  inherit (inputs.nixpkgs) pkgs;
in
{
  "jump-to-char.yazi" = pkgs.yaziPlugins.jump-to-char;
  "chmod.yazi" = pkgs.yaziPlugins.chmod;
  "git.yazi" = pkgs.yaziPlugins.git;
  "smart-paste.yazi" = pkgs.yaziPlugins.smart-paste;

  "suspendcwd.yazi" = ./plugins/suspendcwd;
  "opencwd.yazi" = ./plugins/opencwd;
  "escexit.yazi" = ./plugins/escexit;
  "modified.yazi" = ./plugins/modified;
}
