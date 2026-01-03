{ adios }:
{
  name = "diff-so-fancy";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
    git.path = "/git";
  };

  impl =
    { inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      gitWrapper = inputs.git {};
    in
    inputs.mkWrapper {
      package = pkgs.diff-so-fancy;
      environment = {
        # If you don't have this, diff-so-fancy can't find your gitconfig
        GIT_CONFIG_GLOBAL = "${gitWrapper}/git/config";
      };
    };
}
