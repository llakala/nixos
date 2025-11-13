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
    defaultFunc = { inputs }: import ./settings.nix { inherit inputs; };
  };
  options.ignoreFile = {
    type = types.path;
    default = ./ignore;
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs lib;
        inherit (pkgs) symlinkJoin makeWrapper writeText;
        inherit (lib.generators) toGitINI;
        gitconfig = writeText "config" (toGitINI options.iniConfig);
      in
      symlinkJoin {
        name = "git-wrapped";
        paths = [ pkgs.gitFull ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          mkdir -p $out/git
          ln -s ${gitconfig} $out/git/config
          ln -s ${options.ignoreFile} $out/git/ignore
          wrapProgram $out/bin/git \
            --set XDG_CONFIG_HOME $out
        '';
        meta.mainProgram = "git";
      };
  };
}
