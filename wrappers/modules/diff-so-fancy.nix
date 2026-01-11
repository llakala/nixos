{ adios }:
let
  inherit (adios) types;
in {
  name = "diff-so-fancy";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
    git.path = "/git";
  };

  options = {
    package = {
      type = types.derivation;
      description = "The diff-so-fancy package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.diff-so-fancy;
    };
  };

  impl =
    { inputs, options }:
    let
      gitWrapper = inputs.git {};
    in
    inputs.mkWrapper {
      inherit (options) package;
      environment = {
        # If you don't have this, diff-so-fancy can't find your gitconfig
        GIT_CONFIG_GLOBAL = "${gitWrapper}/git/config";
      };
    };
}
