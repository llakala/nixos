{ adios }:
let
  inherit (adios) types;
in
{
  name = "git";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    gh.path = "/gh";
    less.path = "/less";
  };

  options.iniConfig = {
    type = types.attrs;
    defaultFunc =
      { inputs, ... }:
      (import ./settings.nix { inherit inputs; });
  };

  options.ignoreFile = {
    type = types.path;
    default = ./ignore;
  };

  options.configDir = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs lib;
        inherit (pkgs) linkFarm writeText;
        inherit (lib.generators) toGitINI;
      in
      linkFarm "gitconfig" [
        { name = "git/config"; path = writeText "config" (toGitINI options.iniConfig); }
        { name = "git/ignore"; path = options.ignoreFile; }
      ];
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) symlinkJoin makeWrapper;
        in
      symlinkJoin {
        name = "git-wrapped";
        paths = [ pkgs.gitFull ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          wrapProgram $out/bin/git \
            --set GIT_CONFIG_GLOBAL ${options.configDir}/git/config \
        '';
        meta.mainProgram = "git";
      };
  };
}
