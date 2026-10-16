{ inputs }:
let
  inherit (inputs.nixpkgs.pkgs) yaziPlugins;
in {
  "jump-to-char.yazi" = yaziPlugins.jump-to-char;
  "chmod.yazi" = yaziPlugins.chmod;
  "git.yazi" = yaziPlugins.git;
  "smart-paste.yazi" = yaziPlugins.smart-paste;

  "suspendcwd.yazi" = ./plugins/suspendcwd;
  "opencwd.yazi" = ./plugins/opencwd;
  "escexit.yazi" = ./plugins/escexit;
  "modified.yazi" = ./plugins/modified;
}
