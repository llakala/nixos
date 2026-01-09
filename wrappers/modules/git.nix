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
    settings = {
      type = types.attrs;
      mutatorType = types.attrs;
      mergeFunc = adios.lib.mergeFuncs.mergeAttrsRecursively;
    };
    configFile = {
      type = types.pathLike;
    };

    ignoredPaths = {
      type = types.listOf types.string;
    };
    ignoreFile = {
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
      inherit (builtins) concatStringsSep;
      inherit (inputs.nixpkgs.pkgs) writeText;
      inherit (inputs.nixpkgs.lib.generators) toGitINI;
    in
    assert !(options ? settings && options ? configFile);
    assert !(options ? ignoredPaths && options ? ignoreFile);
    inputs.mkWrapper {
      name = "git"; # Default derivation name is git-with-svn
      inherit (options) package;
      preWrap = ''
        mkdir -p $out/git
      '';
      symlinks = {
        "$out/git/config" = options.configFile or (writeText "config" (toGitINI options.settings));
        "$out/git/ignore" =
          options.ignoreFile or (writeText "ignore" (concatStringsSep "\n" options.ignoredPaths));
      };
      environment = {
        XDG_CONFIG_HOME = "$out";
      };
    };
}
