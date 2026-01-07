{ adios }:
let
  inherit (adios) types;
in {
  name = "git";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    ignoreFile = {
      type = types.pathLike;
    };
    iniConfig = {
      type = types.attrs;
      mutatorType = types.attrs;
      mergeFunc = adios.lib.mergeFuncs.mergeAttrsRecursively;
    };
    iniConfigFile = {
      type = types.pathLike;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.git;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) writeText;
      inherit (inputs.nixpkgs.lib.generators) toGitINI;
    in
    assert !(options ? iniConfig && options ? iniConfigFile);
    inputs.mkWrapper {
      name = "git"; # Default derivation name is git-with-svn
      inherit (options) package;
      preWrap = ''
        mkdir -p $out/git
      '';
      symlinks = {
        "$out/git/config" = options.iniConfigFile or writeText "config" (toGitINI options.iniConfig);
        "$out/git/ignore" = options.ignoreFile or null;
      };
      environment = {
        XDG_CONFIG_HOME = "$out";
      };
    };
}
